import { state, toast, Sound } from '../../app.js';

const cache = {
  list: null,
  loaded: false,
  promise: null,
  status: null
};

let refs = { tbody: null, status: null, toggleBtn: null, reportBtn: null };

function basename(p) {
  if (!p) return '';
  return String(p).split(/[\\/]/).pop();
}

async function loadFirewallStatus() {
  try {
    const status = await window.api.security.firewallStatus();
    cache.status = status;
    return status;
  } catch (e) {
    console.error('[firewall] status error:', e);
    return null;
  }
}

function renderFirewallStatus() {
  const status = cache.status;
  const btn = refs.toggleBtn;
  if (!btn) return;

  if (!status) {
    btn.textContent = '⚠ Не удалось получить статус';
    btn.disabled = true;
    return;
  }

  const { profiles, overallEnabled } = status;

  let text = '';
  let action = '';
  let cls = '';

  if (overallEnabled === 'all') {
    text = '✅ Брандмауэр включён';
    action = 'disable';
    cls = 'm3-fw-btn-off';
  } else if (overallEnabled === 'none') {
    text = ' Брандмауэр выключен';
    action = 'enable';
    cls = 'm3-fw-btn-on';
  } else {
    text = '⚠ Включён частично';
    action = 'enable';
    cls = 'm3-fw-btn-on';
  }

  btn.textContent = text;
  btn.className = 'm3-fw-toggle ' + cls;
  btn.dataset.action = action;
  btn.disabled = false;
}

export function buildFirewallPanel(panel) {
  const section = document.createElement('section');
  section.className = 'm3-section';
  section.innerHTML = `
    <div class="m3-section-head">
      <div class="m3-section-title">🔥 Брандмауэр Windows</div>
      <div class="m3-section-actions">
        <button class="m3-btn" id="fw-toggle">Загрузка…</button>
        <button class="m3-btn m3-btn-ghost" id="fw-report"> Отчёт</button>
        <button class="m3-btn m3-btn-ghost" id="fw-refresh">🔄</button>
      </div>
    </div>
    <p class="m3-note">Для каждой программы — два правила: «Разрешить» и «Запретить».</p>
    <div class="m3-toolbar">
      <button class="m3-btn m3-btn-primary" id="fw-add">➕ Добавить программу</button>
      <span class="muted" id="fw-status"></span>
    </div>
    <div class="m3-table-wrap">
      <table class="m3-table">
        <thead>
          <tr>
            <th style="width:40px"></th>
            <th>Программа</th>
            <th>Путь</th>
            <th style="width:140px;text-align:center">Разрешить</th>
            <th style="width:140px;text-align:center">Запретить</th>
            <th style="width:50px"></th>
          </tr>
        </thead>
        <tbody id="fw-tbody"></tbody>
      </table>
    </div>
  `;
  panel.appendChild(section);

  refs.tbody = section.querySelector('#fw-tbody');
  refs.status = section.querySelector('#fw-status');
  refs.toggleBtn = section.querySelector('#fw-toggle');
  refs.reportBtn = section.querySelector('#fw-report');

  section.querySelector('#fw-refresh').addEventListener('click', () => {
    Sound.click();
    cache.loaded = false;
    cache.promise = null;
    delete state.dataCache.firewall;
    loadFirewall(true);
  });

  section.querySelector('#fw-add').addEventListener('click', async () => {
    Sound.click();
    const target = await window.api.firewall.pickExe();
    if (!target) return;
    const action = 'allow';
    const r = await window.api.firewall.add(target, action);
    if (r && r.ok) {
      toast('Разрешено: ' + basename(target), 'success', 1800);
      cache.loaded = false;
      cache.promise = null;
      delete state.dataCache.firewall;
      loadFirewall(true);
    } else {
      toast('Ошибка: ' + (r?.error || 'неизвестно'), 'error', 4000);
    }
  });

  /* Toggle firewall */
  refs.toggleBtn.addEventListener('click', async () => {
    Sound.click();
    const btn = refs.toggleBtn;
    const action = btn.dataset.action;
    if (!action) return;
    btn.disabled = true;
    btn.textContent = 'Применение…';
    try {
      const result = await window.api.security.setFirewallStatus(action === 'enable');
      if (result.ok) {
        Sound.success();
        toast(`Брандмауэр ${action === 'enable' ? 'включён' : 'выключен'}`, 'success', 2000);
        await loadFirewallStatus();
        renderFirewallStatus();
      } else {
        Sound.error();
        toast('Ошибка: ' + (result.error || 'неизвестно'), 'error', 4000);
        btn.disabled = false;
      }
    } catch (e) {
      Sound.error();
      toast('Ошибка: ' + e.message, 'error', 4000);
      btn.disabled = false;
    }
  });

  /* Отчёт по firewall */
  refs.reportBtn.addEventListener('click', async () => {
    Sound.click();
    try {
      const list = cache.list || await window.api.firewall.list();
      const status = cache.status || await loadFirewallStatus();
      const html = generateFirewallReport(list, status);
      if (window.api?.shell?.saveHtmlReport) {
        await window.api.shell.saveHtmlReport(html, 'firewall_report.html');
      } else {
        const blob = new Blob([html], { type: 'text/html' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'firewall_report.html';
        a.click();
        URL.revokeObjectURL(url);
      }
    } catch (e) {
      toast('Ошибка отчёта: ' + e.message, 'error', 4000);
    }
  });

  loadFirewallStatus().then(renderFirewallStatus);
  loadFirewall();
}

async function loadFirewall(force = false) {
  if (!force && cache.loaded && cache.list) {
    renderFirewallRows();
    return;
  }
  if (cache.promise) return cache.promise;

  if (force) {
    cache.loaded = false;
    cache.list = null;
    delete state.dataCache.firewall;
  }
  if (refs.tbody) refs.tbody.innerHTML = `<tr><td colspan="6" class="muted">Загрузка…</td></tr>`;
  if (refs.status) refs.status.textContent = 'Загрузка…';

  cache.promise = (async () => {
    try {
      const list = await window.api.firewall.list();
      cache.list = list || [];
      cache.loaded = true;
      state.dataCache.firewall = cache.list;
    } catch (e) {
      cache.list = [];
      cache.loaded = true;
      toast('Ошибка firewall: ' + e.message, 'error', 4000);
    } finally {
      cache.promise = null;
    }
    renderFirewallRows();
  })();
  return cache.promise;
}

function renderFirewallRows() {
  const tbody = refs.tbody;
  const status = refs.status;
  if (!tbody) return;

  const list = cache.list || [];
  if (!list.length) {
    tbody.innerHTML = `<tr><td colspan="6" class="muted">Правил нет. Нажмите «➕ Добавить программу».</td></tr>`;
    if (status) status.textContent = 'Всего: 0';
    return;
  }

  tbody.innerHTML = '';
  for (const item of list) tbody.appendChild(makeFwRow(item));
  if (status) status.textContent = `Всего: ${list.length}`;
}

function makeFwRow(item) {
  const tr = document.createElement('tr');

  const iconTd = document.createElement('td');
  iconTd.innerHTML = `<div class="fw-icon">📦</div>`;
  tr.appendChild(iconTd);

  const nameTd = document.createElement('td');
  nameTd.className = 'fw-name';
  nameTd.textContent = item.name;
  tr.appendChild(nameTd);

  const pathTd = document.createElement('td');
  pathTd.className = 'fw-path';
  pathTd.textContent = item.program;
  pathTd.title = item.program;
  tr.appendChild(pathTd);

  const allowTd = document.createElement('td');
  allowTd.style.textAlign = 'center';
  const allowBtn = document.createElement('button');
  allowBtn.type = 'button';
  allowBtn.className = 'm3-btn-sm ' + (item.state === 'allow' ? 'm3-btn-active' : '');
  allowBtn.textContent = item.state === 'allow' ? '✓ Разрешено' : 'Разрешить';
  allowBtn.addEventListener('click', async () => {
    Sound.click();
    allowBtn.disabled = true;
    const r = await window.api.firewall.set(item.program, 'allow');
    allowBtn.disabled = false;
    if (r && r.ok) {
      Sound.success();
      toast('Разрешено: ' + item.name, 'success', 1500);
      cache.loaded = false;
      cache.promise = null;
      delete state.dataCache.firewall;
      loadFirewall(true);
    } else {
      Sound.error();
      toast('Ошибка: ' + (r?.error || 'неизвестно'), 'error', 4000);
    }
  });
  allowTd.appendChild(allowBtn);
  tr.appendChild(allowTd);

  const blockTd = document.createElement('td');
  blockTd.style.textAlign = 'center';
  const blockBtn = document.createElement('button');
  blockBtn.type = 'button';
  blockBtn.className = 'm3-btn-sm ' + (item.state === 'block' ? 'm3-btn-active-danger' : '');
  blockBtn.textContent = item.state === 'block' ? '✓ Запрещено' : 'Запретить';
  blockBtn.addEventListener('click', async () => {
    Sound.click();
    blockBtn.disabled = true;
    const r = await window.api.firewall.set(item.program, 'block');
    blockBtn.disabled = false;
    if (r && r.ok) {
      Sound.success();
      toast('Запрещено: ' + item.name, 'success', 1500);
      cache.loaded = false;
      cache.promise = null;
      delete state.dataCache.firewall;
      loadFirewall(true);
    } else {
      Sound.error();
      toast('Ошибка: ' + (r?.error || 'неизвестно'), 'error', 4000);
    }
  });
  blockTd.appendChild(blockBtn);
  tr.appendChild(blockTd);

  const delTd = document.createElement('td');
  const delBtn = document.createElement('button');
  delBtn.type = 'button';
  delBtn.className = 'm3-btn-sm m3-btn-ghost-danger';
  delBtn.textContent = '✕';
  delBtn.title = 'Удалить правила';
  delBtn.addEventListener('click', async () => {
    Sound.click();
    if (!confirm(`Удалить правила для «${item.name}»?`)) return;
    delBtn.disabled = true;
    const r = await window.api.firewall.remove(item.program);
    if (r && r.ok) {
      toast('Удалено: ' + item.name, 'success', 1500);
      cache.loaded = false;
      cache.promise = null;
      delete state.dataCache.firewall;
      loadFirewall(true);
    } else {
      toast('Ошибка: ' + (r?.error || 'неизвестно'), 'error', 4000);
    }
  });
  delTd.appendChild(delBtn);
  tr.appendChild(delTd);

  return tr;
}

function generateFirewallReport(list, status) {
  const esc = (s) => String(s || '').replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));

  let statusHtml = '';
  if (status) {
    const { profiles, overallEnabled } = status;
    const statusText = overallEnabled === 'all' ? '✅ Включён для всех профилей'
      : overallEnabled === 'none' ? '⛔ Выключен для всех профилей'
      : '⚠ Включён частично';
    statusHtml = `
      <div class="fw-status">
        <div class="fw-status-title">Статус Windows Firewall</div>
        <div class="fw-status-text">${statusText}</div>
        <div class="fw-profiles">
          ${profiles.map(p => `
            <div class="fw-profile">
              <div class="fw-profile-name">${esc(p.name)}</div>
              <div class="fw-profile-state ${p.enabled ? 'on' : 'off'}">${p.enabled ? 'Включён' : 'Выключен'}</div>
            </div>
          `).join('')}
        </div>
      </div>
    `;
  }

  const rows = (list || []).map(item => `
    <tr>
      <td>${esc(item.name)}</td>
      <td class="mono">${esc(item.program)}</td>
      <td class="fw-state-${item.state}">${item.state === 'allow' ? 'Разрешено' : item.state === 'block' ? 'Запрещено' : 'Нет правила'}</td>
    </tr>
  `).join('');

  return `<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<title>Anton Vampire — Отчёт по брандмауэру</title>
<style>
  body { font-family: 'Segoe UI', system-ui, sans-serif; background: #0d0d0d; color: #e0e0e0; padding: 40px; max-width: 900px; margin: 0 auto; }
  h1 { color: #7c4dff; font-size: 28px; margin-bottom: 8px; }
  .subtitle { color: #888; font-size: 13px; margin-bottom: 32px; }
  .fw-status { background: #1a1a1a; border-radius: 16px; padding: 20px; margin-bottom: 24px; border: 1px solid #333; }
  .fw-status-title { font-size: 16px; font-weight: 700; color: #7c4dff; margin-bottom: 8px; }
  .fw-status-text { font-size: 14px; margin-bottom: 16px; }
  .fw-profiles { display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; }
  .fw-profile { background: #222; padding: 10px; border-radius: 8px; }
  .fw-profile-name { font-weight: 700; font-size: 13px; margin-bottom: 4px; }
  .fw-profile-state.on { color: #31ff83; font-size: 12px; }
  .fw-profile-state.off { color: #ff5c5c; font-size: 12px; }
  table { width: 100%; border-collapse: collapse; font-size: 13px; }
  th { background: #1a1a1a; color: #7c4dff; text-align: left; padding: 10px; font-size: 11px; text-transform: uppercase; }
  td { padding: 10px; border-bottom: 1px solid #222; }
  tr:hover { background: #1a1a1a; }
  .mono { font-family: 'Consolas', monospace; font-size: 11px; color: #aaa; }
  .fw-state-allow { color: #31ff83; font-weight: 700; }
  .fw-state-block { color: #ff5c5c; font-weight: 700; }
  .fw-state-none { color: #888; }
  .footer { margin-top: 40px; font-size: 11px; color: #666; text-align: center; border-top: 1px dashed #333; padding-top: 20px; }
</style>
</head>
<body>
  <h1>🔥 Отчёт по брандмауэру Windows</h1>
  <div class="subtitle">Anton Vampire · ${new Date().toLocaleString('ru-RU')}</div>
  ${statusHtml}
  <table>
    <thead><tr><th>Программа</th><th>Путь</th><th>Состояние</th></tr></thead>
    <tbody>${rows || '<tr><td colspan="3">Правил нет</td></tr>'}</tbody>
  </table>
  <div class="footer">Сгенерировано Anton Vampire</div>
</body>
</html>`;
}