import { state, Sound } from '../../app.js';

const cache = {
  data: null,
  ports: null,
  promise: null,
  hostCache: new Map()
};

let refs = { tbody: null, status: null, portsTbody: null };

function escapeHtml(s) {
  return String(s || '').replace(/[&<>"']/g, c => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;'
  }[c]));
}

async function resolveHostname(ip, mode) {
  if (mode === 'none') return null;
  if (cache.hostCache.has(ip)) return cache.hostCache.get(ip);
  try {
    const host = await window.api.netmon.resolveHost(ip, mode);
    cache.hostCache.set(ip, host);
    return host;
  } catch { return null; }
}

function copyToClipboard(text) {
  navigator.clipboard.writeText(text).then(() => {
    const toast = document.createElement('div');
    toast.className = 'm3-toast';
    toast.textContent = 'Скопировано';
    document.body.appendChild(toast);
    setTimeout(() => toast.remove(), 1500);
  });
}

function makeRow(row, mode, showHost, isBrand) {
  const tr = document.createElement('tr');

  const ip = row.ip || '—';

  const ipTd = document.createElement('td');
  ipTd.className = 'mono';
  ipTd.textContent = ip;
  if (showHost && ip !== '—') {
    ipTd.title = 'Кликните, чтобы скопировать';
    ipTd.style.cursor = 'pointer';
    ipTd.addEventListener('click', () => copyToClipboard(ip));
  }
  tr.appendChild(ipTd);

  if (showHost) {
    const hostTd = document.createElement('td');
    hostTd.innerHTML = `<span class="nm-host-loading">…</span>`;
    resolveHostname(ip, mode).then((host) => {
      hostTd.innerHTML = '';
      if (host) {
        const span = document.createElement('span');
        span.textContent = host;
        span.className = isBrand ? 'nm-host-empty' : 'nm-host';
        hostTd.appendChild(span);
        hostTd.className = 'mono nm-cell-copy';
        hostTd.title = 'Кликните, чтобы скопировать';
        hostTd.addEventListener('click', () => copyToClipboard(host));
      } else {
        const span = document.createElement('span');
        span.textContent = '—';
        span.className = 'nm-host-empty';
        hostTd.appendChild(span);
      }
    });
    tr.appendChild(hostTd);
  }

  const portTd = document.createElement('td');
  portTd.className = 'mono';
  portTd.textContent = String(row.port || '');
  tr.appendChild(portTd);

  const connTd = document.createElement('td');
  connTd.textContent = row.connections;
  tr.appendChild(connTd);

  const procTd = document.createElement('td');
  procTd.className = 'mono';
  procTd.textContent = (row.processes || []).join(', ');
  tr.appendChild(procTd);

  return tr;
}

function renderRows() {
  const tbody = refs.tbody;
  const status = refs.status;
  if (!tbody) return;

  const data = cache.data || [];
  const mode = state.config?.General?.netmon_host_mode || 'ptr';
  const showHost = mode !== 'none';
  const isBrand = mode === 'brand';

  const thead = tbody.closest('table')?.querySelector('thead');
  if (thead) {
    thead.innerHTML = `<tr>
      <th>Удалённый IP</th>
      ${showHost ? `<th>${isBrand ? 'Сайт / Хостинг' : 'Сайт (hostname)'}</th>` : ''}
      <th>Порт</th>
      <th>Соединений</th>
      <th>Процессы</th>
    </tr>`;
  }

  if (!data.length) {
    tbody.innerHTML = `<tr><td colspan="${showHost ? 5 : 4}" class="muted">Активных соединений нет.</td></tr>`;
    if (status) status.textContent = 'Всего: 0';
    return;
  }

  tbody.innerHTML = '';
  for (const row of data) {
    tbody.appendChild(makeRow(row, mode, showHost, isBrand));
  }
  if (status) status.textContent = `Всего: ${data.length}`;
}

function renderPorts() {
  const tbody = refs.portsTbody;
  if (!tbody) return;

  const data = cache.ports || [];
  if (!data.length) {
    tbody.innerHTML = `<tr><td colspan="4" class="muted">Открытых портов не найдено.</td></tr>`;
    return;
  }

  tbody.innerHTML = '';
  for (const row of data) {
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td class="mono"><b>${row.port}</b></td>
      <td class="mono">${row.ip || '0.0.0.0'}</td>
      <td>${row.process || '—'}</td>
      <td class="mono" style="color: #888;">${row.pid}</td>
    `;
    tbody.appendChild(tr);
  }
}

async function loadNetmon(force = false) {
  if (!force && cache.data) { renderRows(); return; }
  if (cache.promise) return cache.promise;

  if (refs.tbody) refs.tbody.innerHTML = `<tr><td colspan="5" class="muted">Загрузка…</td></tr>`;
  if (refs.status) refs.status.textContent = 'Загрузка…';

  cache.promise = (async () => {
    try {
      const data = await window.api.netmon.snapshot();
      cache.data = data || [];
    } catch (e) {
      cache.data = [];
      console.error('[netmon] error:', e);
    } finally { cache.promise = null; }
    renderRows();
  })();
  return cache.promise;
}

async function loadPorts(force = false) {
  if (!force && cache.ports) { renderPorts(); return; }
  if (refs.portsTbody) refs.portsTbody.innerHTML = `<tr><td colspan="4" class="muted">Загрузка…</td></tr>`;
  try {
    const data = await window.api.netmon.ports();
    cache.ports = data || [];
  } catch (e) {
    cache.ports = [];
    console.error('[netmon] ports error:', e);
  }
  renderPorts();
}

export function buildNetMonPanel(panel) {
  const section = document.createElement('section');
  section.className = 'm3-section';
  section.innerHTML = `
    <div class="m3-section-head">
      <div class="m3-section-title">🌐 Сетевой монитор</div>
      <div class="m3-section-actions">
        <button class="m3-btn m3-btn-ghost" id="nm-refresh">🔄 Обновить</button>
      </div>
    </div>
    <p class="m3-note">Живой снимок TCP-соединений ПК. Клик по IP — копирование.</p>
    <div class="m3-toolbar">
      <span class="muted" id="nm-status"></span>
    </div>
    <div class="m3-table-wrap">
      <table class="m3-table">
        <thead id="nm-thead"></thead>
        <tbody id="nm-tbody"></tbody>
      </table>
    </div>

    <!-- Порты скрыты по умолчанию (без атрибута open) -->
    <details class="m3-details" style="margin-top: 16px;">
      <summary class="m3-details-summary">
        🛡 Локальные порты (Listen)
        <span class="muted" style="font-weight: 400; font-size: 12px; margin-left: 8px;">— нажмите, чтобы раскрыть</span>
      </summary>
      <div class="m3-table-wrap" style="margin-top: 8px;">
        <table class="m3-table">
          <thead>
            <tr><th>Порт</th><th>IP-адрес</th><th>Процесс</th><th>PID</th></tr>
          </thead>
          <tbody id="nm-ports-tbody">
            <tr><td colspan="4" class="muted">Нажмите, чтобы раскрыть</td></tr>
          </tbody>
        </table>
      </div>
    </details>
  `;
  panel.appendChild(section);

  refs.tbody = section.querySelector('#nm-tbody');
  refs.status = section.querySelector('#nm-status');
  refs.portsTbody = section.querySelector('#nm-ports-tbody');

  section.querySelector('#nm-refresh').addEventListener('click', () => {
    Sound.click();
    cache.data = null;
    cache.ports = null;
    cache.promise = null;
    cache.hostCache.clear();
    loadNetmon(true);
    loadPorts(true);
  });

  const details = section.querySelector('.m3-details');
  details.addEventListener('toggle', (e) => {
    if (e.target.open && !cache.ports) loadPorts();
  });

  if (cache.data) renderRows();
  else loadNetmon();
}