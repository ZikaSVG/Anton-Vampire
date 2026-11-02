import { state } from './app.js';

/* ============================================================
   Глобальный лог на все вкладки.
   Пишет в #log-body, автопрокрутка вниз, хранит N последних строк.
   ============================================================ */

const MAX_LINES = 2000;

let panelEl = null;
let bodyEl = null;
let toggleBtn = null;
let clearBtn = null;
let collapsed = true;
let buffer = [];

function ensureRefs() {
  if (panelEl) return;
  panelEl  = document.getElementById('log-panel');
  bodyEl   = document.getElementById('log-body');
  toggleBtn = document.getElementById('log-toggle');
  clearBtn  = document.getElementById('log-clear');

  if (toggleBtn) {
    toggleBtn.addEventListener('click', () => {
      collapsed = !collapsed;
      panelEl.classList.toggle('collapsed', collapsed);
      toggleBtn.textContent = collapsed ? '▴' : '▾';
    });
  }
  if (clearBtn) {
    clearBtn.addEventListener('click', () => {
      buffer = [];
      if (bodyEl) bodyEl.textContent = '';
    });
  }
}

export function logWrite(text, opts = {}) {
  ensureRefs();
  if (!bodyEl) return;

  const { newline = false, expand = true } = opts;
  const chunk = newline ? text + '\n' : text;

  // Если вкладка лога свёрнута — разворачиваем при новой записи
  if (expand && collapsed) {
    collapsed = false;
    panelEl?.classList.remove('collapsed');
    if (toggleBtn) toggleBtn.textContent = '▾';
  }

  buffer.push(chunk);
  if (buffer.length > MAX_LINES) {
    buffer.splice(0, buffer.length - MAX_LINES);
  }

  bodyEl.textContent = buffer.join('');
  bodyEl.scrollTop = bodyEl.scrollHeight;
}

export function logLine(text) {
  logWrite(text, { newline: true });
}

export function logClear() {
  ensureRefs();
  buffer = [];
  if (bodyEl) bodyEl.textContent = '';
}

export function logSeparator(title) {
  logLine('');
  logLine('═══════════════════════════════════════════════');
  if (title) logLine('▶ ' + title);
  logLine('═══════════════════════════════════════════════');
}

/* ============================================================
   Обёртки над window.api.tweaks.* — сами пишут в лог.
   ============================================================ */

function shortPath(p) {
  if (!p) return '';
  return String(p).split(/[\\/]/).slice(-1)[0];
}

/**
 * Запуск твика в фоне (без вывода в лог). Пишем только факт.
 */
export async function loggedRun(relPath, options = {}) {
  const name = shortPath(relPath);
  logLine(`▶ Запуск: ${name}`);
  try {
    const r = await window.api.tweaks.run(relPath, options);
    logLine(`✅ Готово: ${name}`);
    return r;
  } catch (e) {
    logLine(`❌ Ошибка: ${name} — ${e.message}`);
    throw e;
  }
}

/**
 * Запуск команды в фоне.
 */
export async function loggedRunCommand(cmd, options = {}) {
  logLine(`▶ Команда: ${cmd}`);
  try {
    const r = await window.api.tweaks.runCommand(cmd, options);
    logLine(`✅ Команда выполнена: ${cmd}`);
    return r;
  } catch (e) {
    logLine(`❌ Ошибка команды: ${cmd} — ${e.message}`);
    throw e;
  }
}

/**
 * Массовый запуск — по одному через стрим, каждый пишет в лог.
 * Всегда через runStream (без окон). Если батник содержит `start`,
 * main сам запатчит его в `start /b ""`, чтобы не открывалось окно.
 */
export async function loggedRunMany(paths, options = {}) {
  if (!paths || !paths.length) return [];
  logSeparator(`Массовый запуск: ${paths.length} твиков`);

  const results = [];
  for (const p of paths) {
    const name = shortPath(p);
    logLine(`▶ ${name}`);

    const r = await new Promise((resolve) => {
      window.api.tweaks.runStream(p, {
        onData: (chunk) => logWrite(chunk),
        onEnd: (res) => resolve(res),
      });
    });

    if (r?.code === 0) {
      logLine(`✅ ${name}`);
      results.push({ path: p, ok: true });
    } else {
      logLine(`❌ ${name} (exit ${r?.code ?? '?'})`);
      results.push({ path: p, ok: false, error: r?.error || `exit ${r?.code ?? '?'}` });
    }
  }

  logLine(`Итого: ${results.filter(r => r.ok).length} / ${paths.length}`);
  return results;
}

/**
 * Стриминговый запуск файла — построчно в лог, без окон.
 * Если в батнике есть `start`, main патчит его в `start /b ""`,
 * чтобы команда не зависла в безоконном cmd.exe.
 */
export function loggedRunStream(relPath, opts = {}) {
  const name = shortPath(relPath);
  logSeparator(`Стрим: ${name}  (${relPath})`);

  return window.api.tweaks.runStream(relPath, {
    onData: (chunk) => logWrite(chunk),
    onEnd: (r) => {
      logLine('');
      logLine(`✅ Завершено: ${name} (exit ${r.code ?? '?'})`);
      if (typeof opts.onEnd === 'function') opts.onEnd(r);
    }
  });
}

/**
 * Стриминговый запуск команды — построчно в лог, без окон.
 */
export function loggedRunCommandStream(cmd, opts = {}) {
  logSeparator(`Стрим команды: ${cmd}`);

  return window.api.tweaks.runCommandStream(cmd, {
    onData: (chunk) => logWrite(chunk),
    onEnd: (r) => {
      logLine('');
      logLine(`✅ Команда завершена (exit ${r.code ?? '?'})`);
      if (typeof opts.onEnd === 'function') opts.onEnd(r);
    }
  });
}