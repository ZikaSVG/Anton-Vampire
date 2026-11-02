import { auditCache } from './audit-shared.js';

const CSS = `
  body { font-family: 'Segoe UI', system-ui, sans-serif; background: #0d0d0d; color: #e0e0e0; padding: 40px; max-width: 900px; margin: 0 auto; }
  h1 { color: #7c4dff; font-size: 28px; margin-bottom: 8px; text-align: center; }
  h2 { color: #7c4dff; font-size: 20px; margin: 32px 0 16px 0; border-bottom: 1px solid #333; padding-bottom: 8px; }
  .subtitle { color: #888; font-size: 13px; text-align: center; margin-bottom: 32px; }
  .stats { display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px; margin-bottom: 24px; }
  .stat-box { background: #1a1a1a; padding: 16px; border-radius: 12px; text-align: center; border: 1px solid #333; }
  .stat-label { font-size: 11px; color: #888; text-transform: uppercase; margin-bottom: 6px; }
  .stat-val { font-size: 24px; font-weight: 700; }
  .stat-val.green { color: #31ff83; } .stat-val.yellow { color: #ffbd05; } .stat-val.orange { color: #ff8b3d; } .stat-val.red { color: #d93b3b; }
  table { width: 100%; border-collapse: collapse; font-size: 13px; margin-bottom: 24px; }
  th { background: #1a1a1a; color: #7c4dff; text-align: left; padding: 10px; font-size: 11px; text-transform: uppercase; }
  td { padding: 10px; border-bottom: 1px solid #222; }
  tr:hover { background: #1a1a1a; }
  .mono { font-family: 'Consolas', monospace; font-size: 11px; color: #aaa; }
  .text-muted { color: #888; }
  .status-icon { font-weight: bold; text-align: center; width: 30px; }
  .status-icon.passed { color: #31ff83; } .status-icon.high { color: #d93b3b; } .status-icon.medium { color: #ffbd05; } .status-icon.low { color: #aaa; }
  .fw-status { background: #1a1a1a; border-radius: 16px; padding: 20px; margin-bottom: 24px; border: 1px solid #333; }
  .fw-status-title { font-size: 16px; font-weight: 700; color: #7c4dff; margin-bottom: 8px; }
  .fw-profiles { display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; margin-top: 12px; }
  .fw-profile { background: #222; padding: 10px; border-radius: 8px; }
  .fw-profile-name { font-weight: 700; font-size: 13px; margin-bottom: 4px; }
  .fw-profile-state.on { color: #31ff83; font-size: 12px; } .fw-profile-state.off { color: #ff5c5c; font-size: 12px; }
  .fw-state-allow { color: #31ff83; font-weight: 700; } .fw-state-block { color: #ff5c5c; font-weight: 700; } .fw-state-none { color: #888; }
  .footer { margin-top: 40px; font-size: 11px; color: #666; text-align: center; border-top: 1px dashed #333; padding-top: 20px; }
`;

function escape(s) { return String(s || '').replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c])); }

function generateSingleReportBody(data, kind) {
  const titles = { security: 'УРОВЕНЬ ЗАЩИТЫ', privacy: 'АНАЛИЗ УТЕЧЕК', comfort: 'УРОВЕНЬ УДОБСТВА' };
  const subtitle = titles[kind] || 'АУДИТ';

  let statsHtml = '';
  let checksHtml = '';

  if (kind === 'security') {
    const s = data;
    statsHtml = `
      <div class="stat-box"><span class="stat-label">ПРОЙДЕНО</span><span class="stat-val green">${s.stats.passed}</span></div>
      <div class="stat-box"><span class="stat-label">НИЗКИЙ РИСК</span><span class="stat-val yellow">${s.stats.low}</span></div>
      <div class="stat-box"><span class="stat-label">СРЕДНИЙ РИСК</span><span class="stat-val orange">${s.stats.medium}</span></div>
      <div class="stat-box"><span class="stat-label">ВЫСОКИЙ РИСК</span><span class="stat-val red">${s.stats.high}</span></div>
    `;
    // В HTML отчёте список проверок ОСТАЁТСЯ
    checksHtml = s.checks.map(c => {
      const cls = c.severity.toLowerCase();
      return `<tr>
        <td class="status-icon ${cls}">${c.severity === 'Passed' ? '✔' : '✖'}</td>
        <td>${escape(c.name)}</td>
        <td class="mono">${escape(c.result)}</td>
        <td class="mono text-muted">${escape(c.expected)}</td>
      </tr>`;
    }).join('');
  } else if (kind === 'privacy') {
    const p = data;
    statsHtml = `
      <div class="stat-box"><span class="stat-label">ПРИВАТНОСТЬ</span><span class="stat-val green">${p.privacy}%</span></div>
      <div class="stat-box"><span class="stat-label">КОНФИДЕНЦИАЛЬНОСТЬ</span><span class="stat-val green">${p.confidential}%</span></div>
      <div class="stat-box"><span class="stat-label">АНОНИМНОСТЬ</span><span class="stat-val green">${p.anonymous}%</span></div>
    `;
    const allChecks = p.details.privacy.concat(p.details.confidential, p.details.anonymous);
    checksHtml = allChecks.map(c => {
      const cls = c.severity.toLowerCase();
      return `<tr>
        <td class="status-icon ${cls}">${c.severity === 'Passed' ? '✔' : '✖'}</td>
        <td>${escape(c.name)}</td>
        <td class="mono">${escape(c.result)}</td>
        <td class="mono text-muted">${escape(c.expected)}</td>
      </tr>`;
    }).join('');
  } else if (kind === 'comfort') {
    const c = data;
    statsHtml = `
      <div class="stat-box"><span class="stat-label">ОТКЛЮЧЕНО (УДОБСТВО)</span><span class="stat-val red">${c.disabled}</span></div>
      <div class="stat-box"><span class="stat-label">РАБОТАЕТ (ЗАЩИТА)</span><span class="stat-val green">${c.enabled}</span></div>
    `;
    checksHtml = c.details.map(item => {
      const cls = item.severity.toLowerCase();
      return `<tr>
        <td class="status-icon ${cls}">${item.severity === 'Passed' ? '✔' : '✖'}</td>
        <td>${escape(item.name)}</td>
        <td class="mono">${escape(item.result)}</td>
        <td class="mono text-muted">${escape(item.expected)}</td>
      </tr>`;
    }).join('');
  }

  return `
    <h2>${subtitle}</h2>
    <div class="stats">${statsHtml}</div>
    <table>
      <thead><tr><th style="width:40px"></th><th>Проверка</th><th>Результат</th><th>Ожидается</th></tr></thead>
      <tbody>${checksHtml}</tbody>
    </table>
  `;
}

function generateFirewallReportBody(list, status) {
  let statusHtml = '';
  if (status) {
    const { profiles, overallEnabled } = status;
    const statusText = overallEnabled === 'all' ? '✅ Включён для всех профилей' : overallEnabled === 'none' ? '⛔ Выключен для всех профилей' : '⚠ Включён частично';
    statusHtml = `
      <div class="fw-status">
        <div class="fw-status-title">Статус Windows Firewall</div>
        <div>${statusText}</div>
        <div class="fw-profiles">
          ${profiles.map(p => `
            <div class="fw-profile">
              <div class="fw-profile-name">${escape(p.name)}</div>
              <div class="fw-profile-state ${p.enabled ? 'on' : 'off'}">${p.enabled ? 'Включён' : 'Выключен'}</div>
            </div>
          `).join('')}
        </div>
      </div>
    `;
  }
  const rows = (list || []).map(item => `
    <tr>
      <td>${escape(item.name)}</td>
      <td class="mono">${escape(item.program)}</td>
      <td class="fw-state-${item.state}">${item.state === 'allow' ? 'Разрешено' : item.state === 'block' ? 'Запрещено' : 'Нет правила'}</td>
    </tr>
  `).join('');
  return `
    <h2>🔥 БРАНДМАУЭР WINDOWS</h2>
    ${statusHtml}
    <table>
      <thead><tr><th>Программа</th><th>Путь</th><th>Состояние</th></tr></thead>
      <tbody>${rows || '<tr><td colspan="3">Правил нет</td></tr>'}</tbody>
    </table>
  `;
}

export async function exportSingleReport(kind) {
  const data = auditCache[kind];
  if (!data) { alert('Нет данных аудита. Запустите аудит сначала.'); return; }
  const bodyContent = generateSingleReportBody(data, kind);
  const html = `<!DOCTYPE html><html lang="ru"><head><meta charset="UTF-8"><title>Anton Vampire — Отчет</title><style>${CSS}</style></head><body>
    <h1>Anton Vampire — Отчет</h1><div class="subtitle">${new Date().toLocaleString('ru-RU')}</div>${bodyContent}
    <div class="footer">Сгенерировано Anton Vampire</div></body></html>`;
  if (window.api?.shell?.saveHtmlReport) { await window.api.shell.saveHtmlReport(html, `audit_${kind}.html`); } 
  else { const blob = new Blob([html], { type: 'text/html' }); const url = URL.createObjectURL(blob); const a = document.createElement('a'); a.href = url; a.download = `audit_${kind}.html`; a.click(); URL.revokeObjectURL(url); }
}

export async function exportFirewallReport() {
  try {
    const list = await window.api.firewall.list();
    const status = await window.api.security.firewallStatus();
    const bodyContent = generateFirewallReportBody(list, status);
    const html = `<!DOCTYPE html><html lang="ru"><head><meta charset="UTF-8"><title>Anton Vampire — Отчет по Firewall</title><style>${CSS}</style></head><body>
      <h1>Anton Vampire — Отчет по брандмауэру</h1><div class="subtitle">${new Date().toLocaleString('ru-RU')}</div>${bodyContent}
      <div class="footer">Сгенерировано Anton Vampire</div></body></html>`;
    if (window.api?.shell?.saveHtmlReport) { await window.api.shell.saveHtmlReport(html, 'firewall_report.html'); }
    else { const blob = new Blob([html], { type: 'text/html' }); const url = URL.createObjectURL(blob); const a = document.createElement('a'); a.href = url; a.download = 'firewall_report.html'; a.click(); URL.revokeObjectURL(url); }
  } catch (e) { alert('Ошибка отчёта: ' + e.message); }
}

export async function exportAllReports() {
  const kinds = ['security', 'privacy', 'comfort'];
  let hasData = false;
  let reportsHtml = '';
  for (const kind of kinds) {
    const data = auditCache[kind];
    if (data) { hasData = true; reportsHtml += generateSingleReportBody(data, kind); }
  }
  if (!hasData) { alert('Нет данных ни по одному аудиту.'); return; }
  const html = `<!DOCTYPE html><html lang="ru"><head><meta charset="UTF-8"><title>Anton Vampire — Полный отчет</title><style>${CSS}</style></head><body>
    <h1>ПОЛНЫЙ ОТЧЕТ СИСТЕМЫ</h1><div class="subtitle">${new Date().toLocaleString('ru-RU')}</div>${reportsHtml}
    <div class="footer">Сгенерировано Anton Vampire</div></body></html>`;
  if (window.api?.shell?.saveHtmlReport) { await window.api.shell.saveHtmlReport(html, 'audit_full.html'); }
  else { const blob = new Blob([html], { type: 'text/html' }); const url = URL.createObjectURL(blob); const a = document.createElement('a'); a.href = url; a.download = 'audit_full.html'; a.click(); URL.revokeObjectURL(url); }
}