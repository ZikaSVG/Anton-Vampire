import { state, getPreloadPromise } from '../../app.js';

export const BAT_FILES = {
  security: 'security-check.bat',
  privacy: 'privacy-check.bat',
  comfort: 'comfort-check.bat'
};
export const EXPECTED_TOTAL = { security: 21, privacy: 14, comfort: 13 };

const TABS_DIR = 'src/renderer/tabs/security';

export const auditCache = {
  security: null,
  privacy: null,
  comfort: null,
  log: { security: '', privacy: '', comfort: '' }
};

const autoAuditStarted = new Set();

export const auditRefs = {
  audit: null, logEl: null, titleEl: null, progressEl: null, fillEl: null
};

export function bindAuditConsole(container) {
  auditRefs.audit = container;
  auditRefs.logEl = container.querySelector('#sec-audit-log');
  auditRefs.titleEl = container.querySelector('#sec-audit-title');
  auditRefs.progressEl = container.querySelector('#sec-audit-progress');
  auditRefs.fillEl = container.querySelector('#sec-audit-fill');
}

export function setAuditTitle(text) {
  if (auditRefs.titleEl) auditRefs.titleEl.textContent = text;
}
export function setAuditProgress(text, percent) {
  if (auditRefs.progressEl) auditRefs.progressEl.textContent = text;
  if (auditRefs.fillEl) auditRefs.fillEl.style.width = (percent || 0) + '%';
}

export function pushLog(kind, text, isErr = false) {
  const el = auditRefs.logEl;
  if (!el) return;
  if (el.textContent.startsWith('Нажмите «Запустить') || el.textContent.startsWith('Авто-аудит отключён') || el.textContent.startsWith('Запуск авто-аудита')) {
    el.textContent = '';
  }
  const chunk = (isErr ? '⚠ ' : '') + text;
  el.textContent += chunk + '\n';
  auditCache.log[kind] = el.textContent;
  el.scrollTop = el.scrollHeight;
}

export function updateAuditLog(currentSub, isAutoEnabled) {
  const el = auditRefs.logEl;
  if (!el) return;
  const txt = auditCache.log[currentSub] || (isAutoEnabled ? 'Запуск авто-аудита…' : 'Авто-аудит отключён. Нажмите «▶ Запустить аудит».');
  el.textContent = txt;
  el.scrollTop = el.scrollHeight;
}

// === ВОЗВРАЩЕН ОРИГИНАЛЬНЫЙ ПАРСЕР (ищет END|, а не SUMMARY|) ===
export function parseBatOutput(out) {
  const items = [];
  let summary = null;
  for (const raw of String(out || '').split(/\r?\n/)) {
    const ln = raw.replace(/^\uFEFF/, '').trim();
    if (!ln) continue;
    if (ln.startsWith('ITEM|')) {
      const p = ln.split('|');
      if (p.length >= 6) {
        items.push({ severity: p[1] || 'High', id: p[2] || '', name: p[3] || '', result: p[4] || '', expected: p[5] || '' });
      }
      continue;
    }
    if (ln.startsWith('END|')) {
      const kv = {};
      for (const part of ln.slice(4).split('|')) {
        const eq = part.indexOf('=');
        if (eq < 0) continue;
        kv[part.slice(0, eq).trim()] = part.slice(eq + 1).trim();
      }
      summary = kv;
    }
  }
  return summary ? { summary, items } : null;
}

export function applyAuditResult(kind, result) {
  const parsed = parseBatOutput(result.stdout || '');
  if (!parsed) { pushLog(kind, '⚠ Не удалось распарсить результат.', true); return; }
  const s = parsed.summary;
  if (kind === 'security') {
    auditCache.security = {
      score: Number(s.score || 1), percent: Number(s.percent || 0), grade: s.grade || 'Bogus',
      stats: { passed: Number(s.passed || 0), low: Number(s.low || 0), medium: Number(s.medium || 0), high: Number(s.high || 0), total: Number(s.total || 0) },
      checks: parsed.items
    };
  } else if (kind === 'privacy') {
    auditCache.privacy = {
      privacy: Number(s.privacy || 0), confidential: Number(s.confidential || 0),
      anonymous: Number(s.anonymous || 0), grade: s.grade || 'Bogus', percent: Number(s.percent || 0),
      leaks: parsed.items.filter(i => i.severity === 'High'),
      details: { privacy: parsed.items.filter(i => i.id?.startsWith('P')), confidential: parsed.items.filter(i => i.id?.startsWith('C')), anonymous: parsed.items.filter(i => i.id?.startsWith('A')) }
    };
  } else if (kind === 'comfort') {
    auditCache.comfort = {
      enabled: Number(s.passed || 0), disabled: Number(s.high || 0),
      total: Number(s.total || 0), grade: s.grade || 'Bogus', percent: Number(s.percent || 0),
      details: parsed.items
    };
  }
}

export function finalizeAuditProgress(kind, cached) {
  const items = (String(cached.stdout || '').match(/ITEM\|/g) || []).length;
  const total = EXPECTED_TOTAL[kind] || items;
  setAuditProgress(`${items} / ${total}`, 100);
  setAuditTitle({
    security: ' Аудит безопасности (кэш)',
    privacy: '🕵 Анализ утечек (кэш)',
    comfort: '🛋 Аудит удобства (кэш)'
  }[kind] || '🔍 Аудит (кэш)');
}

export function syncCacheFromPreload() {
  for (const id of ['security', 'privacy', 'comfort']) {
    if (auditCache[id]) continue;
    const c = state.dataCache?.[`audit_${id}`];
    if (c && c.ok) {
      try {
        applyAuditResult(id, c);
        const items = (String(c.stdout || '').match(/ITEM\|/g) || []).length;
        const total = EXPECTED_TOTAL[id] || items;
        auditCache.log[id] = (auditCache.log[id] || '') + `✅ Данные из preload (${items} / ${total})\n`;
      } catch (e) { console.warn('[security] sync from preload failed:', id, e); }
    }
  }
}

export async function runAudit(kind) {
  const fileName = BAT_FILES[kind];
  if (!fileName) return;
  setAuditTitle({
    security: '🛡 Аудит безопасности…',
    privacy: ' Анализ утечек…',
    comfort: '🛋 Аудит удобства…'
  }[kind] || '🔍 Аудит…');
  setAuditProgress('0 / ' + (EXPECTED_TOTAL[kind] || '?'), 0);
  pushLog(kind, `Запуск: ${fileName}`);

  let exists = false;
  try {
    const pr = await window.api.tweaks.probe(`${TABS_DIR}/${fileName}`);
    exists = !!(pr && pr.exists);
  } catch { /* ignore */ }
  if (!exists) { pushLog(kind, `⚠ BAT не найден: ${TABS_DIR}/${fileName}`, true); return; }

  let out = '';
  let count = 0;
  const expected = EXPECTED_TOTAL[kind] || 0;
  try {
    await new Promise((resolve) => {
      window.api.tweaks.runStream(`${TABS_DIR}/${fileName}`, {
        onData: (chunk) => {
          out += chunk;
          pushLog(kind, chunk);
          for (const raw of String(chunk).split(/\r?\n/)) {
            if (raw.trim().startsWith('ITEM|')) {
              count++;
              if (expected > 0) {
                setAuditProgress(`${Math.min(count, expected)} / ${expected}`, Math.round(Math.min(count, expected) * 100 / expected));
              }
            }
          }
        },
        onEnd: resolve
      });
    });
  } catch (e) { pushLog(kind, `⚠ Ошибка: ${e.message}`, true); return; }

  const parsed = parseBatOutput(out);
  if (!parsed) { pushLog(kind, '⚠ Не найдена строка END| в выводе BAT.', true); return; }
  pushLog(kind, '✅ Готово.');
  setAuditProgress(`${parsed.items.length} / ${expected}`, 100);
  applyAuditResult(kind, { stdout: out });
}

export async function tryAutoAudit(kind, onRender) {
  if (autoAuditStarted.has(kind)) return;
  autoAuditStarted.add(kind);

  if (auditCache[kind]) {
    finalizeAuditProgress(kind, { stdout: '' });
    if (onRender) onRender(kind);
    return;
  }

  const preloadP = getPreloadPromise();
  if (preloadP) {
    console.log(`[security/auto] ждём preload для ${kind}`);
    try { await preloadP; } catch { /* ignore */ }
    const after = state.dataCache?.[`audit_${kind}`];
    if (after && after.ok) {
      console.log(`[security/auto] кэш preload для ${kind}`);
      applyAuditResult(kind, after);
      finalizeAuditProgress(kind, after);
      if (onRender) onRender(kind);
      return;
    }
  }

  try { await runAudit(kind); if (onRender) onRender(kind); }
  catch (e) { console.warn('[security] auto-audit failed:', e); autoAuditStarted.delete(kind); }
}

export function markAuditStarted(kind) { autoAuditStarted.add(kind); }