import { toast, Sound } from '../app.js';

/* ============================================================
   Раздел «Утилиты» для вкладки Настройки.

   Показывает все build_*.py + audit_tweaks.py с описаниями
   и возможностью запуска. Стримит stdout/stderr в лог.
   ============================================================ */

export function buildToolsSection() {
  const frag = document.createElement('div');

  /* ─── Введение ─── */
  const intro = document.createElement('section');
  intro.className = 'settings-section';
  intro.innerHTML = `
    <h3 class="settings-section-title">🛠 Что это за скрипты</h3>
    <div class="settings-section-body" style="font-size:12px;line-height:1.6">
      <p style="margin:0 0 10px 0">
        Это <b>Python-скрипты</b>, которые автоматически генерируют JSON-файлы для интерфейса.
        Каждый сканирует папки в <code>tweaks/</code> и создаёт <code>*_tabs.json</code> —
        список файлов, категорий и пар «твик ↔ отмена».
      </p>
      <p style="margin:0 0 8px 0"><b>Зачем это нужно:</b></p>
      <ul style="margin:0 0 10px 20px;padding:0">
        <li>Добавил новые твики в папку → запустил скрипт → появились в программе</li>
        <li>Переименовал папку сборки → скрипт обновит пути</li>
        <li>Форкнул проект → одна кнопка пересоберёт всё под твою ФС</li>
        <li>Нашёл баг в твике → исправил .bat → запустил скрипт → готово</li>
      </ul>
      <p style="margin:0 0 6px 0">
        <b>Требования:</b> <b>Python 3.8+</b> в <code>PATH</code>
        (<code>python</code>, <code>python3</code> или <code>py</code>).
      </p>
      <p style="margin:0">
        <b>Аудит</b> — отдельный скрипт: проверяет, что все твики из JSON существуют на диске,
        и находит файлы, которых нет ни в одном JSON (возможно, забыл добавить).
      </p>
    </div>
  `;
  frag.appendChild(intro);

  /* ─── Список скриптов ─── */
  const listSection = document.createElement('section');
  listSection.className = 'settings-section';
  listSection.innerHTML = `<h3 class="settings-section-title">📋 Скрипты</h3>`;

  const listBody = document.createElement('div');
  listBody.className = 'settings-section-body';
  listBody.innerHTML = '<div class="muted" style="padding:8px 0">Загрузка списка…</div>';
  listSection.appendChild(listBody);
  frag.appendChild(listSection);

  /* ─── Лог ─── */
  const logSection = document.createElement('section');
  logSection.className = 'settings-section';

  const logHead = document.createElement('h3');
  logHead.className = 'settings-section-title';
  logHead.textContent = '📟 Лог выполнения';
  logSection.appendChild(logHead);

  const bar = document.createElement('div');
  bar.style.cssText = 'display:flex;align-items:center;gap:6px;margin-bottom:8px';
  bar.innerHTML = `<span class="muted" style="flex:1;font-size:11px" data-role="status">Готово</span>`;

  const clearBtn = document.createElement('button');
  clearBtn.type = 'button';
  clearBtn.className = 'btn';
  clearBtn.style.fontSize = '11px';
  clearBtn.style.padding = '4px 10px';
  clearBtn.textContent = '✕ Очистить';
  bar.appendChild(clearBtn);
  logSection.appendChild(bar);

  const logEl = document.createElement('pre');
  logEl.className = 'fixes-log-body';
  logEl.style.maxHeight = '380px';
  logEl.style.minHeight = '100px';
  logEl.style.borderRadius = '8px';
  logEl.textContent = 'Запусти скрипт — вывод появится здесь…';
  logSection.appendChild(logEl);

  frag.appendChild(logSection);

  /* ─── State ─── */
  let unsub = null;
  let running = false;

  const setStatus = (text) => {
    const el = bar.querySelector('[data-role="status"]');
    if (el) el.textContent = text;
  };

  const appendLog = (text, isErr = false) => {
    if (logEl.textContent.startsWith('Запусти')) logEl.textContent = '';
    logEl.textContent += (isErr ? '⚠ ' : '') + text;
    logEl.scrollTop = logEl.scrollHeight;
  };

  clearBtn.addEventListener('click', () => {
    logEl.textContent = '';
    Sound.click();
  });

  /* ─── Загрузка ─── */
  async function loadScripts() {
    try {
      const list = await window.api.buildTools.list();
      listBody.innerHTML = '';
      for (const s of list) listBody.appendChild(makeRow(s));
    } catch (e) {
      listBody.innerHTML = `<div class="muted" style="padding:8px 0">Ошибка: ${escapeHtml(e.message)}</div>`;
    }
  }

  function makeRow(script) {
    const row = document.createElement('div');
    row.style.cssText = `
      display: flex;
      align-items: flex-start;
      gap: 12px;
      padding: 12px 14px;
      background: color-mix(in srgb, var(--card) 60%, transparent);
      border: 1px solid color-mix(in srgb, var(--border) 30%, transparent);
      border-radius: 10px;
      margin-bottom: 8px;
    `;

    const icon = document.createElement('div');
    icon.textContent = script.icon || '📄';
    icon.style.cssText = 'font-size:24px;line-height:1;flex-shrink:0';

    const info = document.createElement('div');
    info.style.cssText = 'flex:1;min-width:0';

    const badges = [];
    if (script.recommended) {
      badges.push('<span style="background:color-mix(in srgb,var(--success) 20%,transparent);color:var(--success);font-size:9px;padding:1px 6px;border-radius:6px;margin-left:6px;font-weight:700">★ Рекомендуется</span>');
    }
    if (script.audit) {
      badges.push('<span style="background:color-mix(in srgb,var(--warn) 20%,transparent);color:var(--warn);font-size:9px;padding:1px 6px;border-radius:6px;margin-left:6px;font-weight:700">🔍 Проверка</span>');
    }
    if (!script.exists) {
      badges.push('<span style="background:color-mix(in srgb,var(--danger) 20%,transparent);color:var(--danger);font-size:9px;padding:1px 6px;border-radius:6px;margin-left:6px;font-weight:700">⚠ Не найден</span>');
    }

    info.innerHTML = `
      <div style="font-weight:700;font-size:13px;margin-bottom:3px">
        <code style="font-family:var(--font-mono,monospace);font-size:12px">${escapeHtml(script.name)}</code>
        ${badges.join('')}
      </div>
      <div class="muted" style="font-size:11px;line-height:1.5">${escapeHtml(script.desc || '')}</div>
    `;

    const actions = document.createElement('div');
    actions.style.cssText = 'display:flex;flex-direction:column;gap:4px;flex-shrink:0';

    const runBtn = document.createElement('button');
    runBtn.type = 'button';
    runBtn.className = 'btn success';
    runBtn.style.cssText = 'font-size:11px;padding:5px 12px';
    runBtn.textContent = '▶ Запустить';
    runBtn.disabled = !script.exists;
    runBtn.addEventListener('click', () => runScript(script, runBtn));
    actions.appendChild(runBtn);

    // Dry-run для build-скриптов (не для audit, не для all_tabs)
    if (!script.audit && script.id !== 'build_all_tabs') {
      const dryBtn = document.createElement('button');
      dryBtn.type = 'button';
      dryBtn.className = 'btn';
      dryBtn.style.cssText = 'font-size:10px;padding:3px 8px';
      dryBtn.textContent = '🔍 Dry';
      dryBtn.title = 'Показать, что будет записано, без записи';
      dryBtn.disabled = !script.exists;
      dryBtn.addEventListener('click', () => runScript(script, dryBtn, { dry: true }));
      actions.appendChild(dryBtn);
    }

    row.append(icon, info, actions);
    return row;
  }

  async function runScript(script, btn, options = {}) {
    if (running) {
      toast('Уже выполняется другой скрипт', 'warning', 2500);
      return;
    }
    running = true;
    Sound.click();

    const allBtns = listBody.querySelectorAll('button');
    allBtns.forEach(b => { b.disabled = true; });

    const oldText = btn.textContent;
    btn.textContent = '⏳ …';
    setStatus(`▶ ${script.name}${options.dry ? ' (dry-run)' : ''}…`);
    appendLog(`\n=== ${script.name}${options.dry ? ' (dry-run)' : ''} ===\n`);

    try {
      const r = await window.api.buildTools.run(script.name, options);
      if (r.ok) {
        appendLog(`\n✅ Готово\n`);
        toast(`${script.name} — OK`, 'success', 2500);
        Sound.success();
        setStatus(`✅ ${script.name} — OK`);
      } else {
        appendLog(`\n❌ Ошибка (exit ${r.code ?? '?'}): ${r.error || 'неизвестно'}\n`);
        toast(`Ошибка ${script.name}: ` + (r.error || 'exit ' + r.code), 'error', 5000);
        Sound.error();
        setStatus(`❌ ${script.name} — ошибка`);
      }
    } catch (e) {
      appendLog(`\n❌ ${e.message}\n`);
      toast('Ошибка: ' + e.message, 'error', 5000);
      Sound.error();
      setStatus(`❌ ${script.name} — ошибка`);
    } finally {
      running = false;
      btn.textContent = oldText;
      listBody.querySelectorAll('button').forEach(b => { b.disabled = false; });
    }
  }

  /* ─── Стриминг вывода ─── */
  if (typeof window.api.buildTools?.onChunk === 'function') {
    unsub = window.api.buildTools.onChunk((payload) => {
      appendLog(payload.chunk, payload.type === 'err');
    });
  }

  /* ─── Отписка при уходе со вкладки ─── */
  const observer = new MutationObserver(() => {
    if (!document.body.contains(frag)) {
      if (unsub) unsub();
      observer.disconnect();
    }
  });
  setTimeout(() => {
    const parent = frag.parentElement;
    if (parent) observer.observe(parent, { childList: true });
  }, 0);

  loadScripts();
  return frag;
}

function escapeHtml(s) {
  return String(s || '')
    .replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
}