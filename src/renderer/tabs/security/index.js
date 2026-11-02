import { state, clearCheckboxes, toast, Sound } from '../../app.js';
import {
  auditCache, bindAuditConsole, updateAuditLog, syncCacheFromPreload
} from './audit-shared.js';
import {
  buildSecurityPanel, renderResult as renderSecurityResult,
  autoAuditSecurity, manualAuditSecurity
} from './security-panel.js';
import {
  buildPrivacyPanel, renderResult as renderPrivacyResult,
  autoAuditPrivacy, manualAuditPrivacy
} from './privacy-panel.js';
import {
  buildComfortPanel, renderResult as renderComfortResult,
  autoAuditComfort, manualAuditComfort
} from './comfort-panel.js';
import { exportSingleReport, exportAllReports } from './reporter.js';

const SUBTABS = [
  { id: 'security', label: '🛡 Безопасность' },
  { id: 'privacy',  label: '🕵 Приватность' },
  { id: 'comfort',  label: ' Удобство' }
];

let currentSub = 'security';

function isAutoAuditEnabled() {
  return state.config?.General?.security_auto_audit !== false;
}

export async function renderSecurity() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = '';
  content.innerHTML = '';
  clearCheckboxes();

  const wrap = document.createElement('div');
  wrap.className = 'security-page';
  content.appendChild(wrap);

  /* HEADER */
  const header = document.createElement('div');
  header.className = 'm3-header';
  header.innerHTML = `
    <div class="m3-header-title">
      <span class="m3-header-icon">🛡️</span>
      <span>Безопасность и приватность</span>
    </div>
    <div class="m3-header-actions">
      <button class="m3-btn m3-btn-primary" id="sec-run">▶ Запустить аудит</button>
      <button class="m3-btn m3-btn-ghost" id="sec-export-all">📄 Все отчёты</button>
    </div>
  `;
  wrap.appendChild(header);

  /* SUB-TABS */
  const subNav = document.createElement('div');
  subNav.className = 'm3-subtabs';
  wrap.appendChild(subNav);

  const panelsWrap = document.createElement('div');
  panelsWrap.className = 'm3-panels';
  wrap.appendChild(panelsWrap);

  const panels = {};
  for (const st of SUBTABS) {
    const p = document.createElement('div');
    p.className = 'm3-panel';
    p.dataset.tab = st.id;
    p.style.display = 'none';
    panelsWrap.appendChild(p);
    panels[st.id] = p;
  }

  for (const st of SUBTABS) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'm3-subtab-btn' + (st.id === currentSub ? ' active' : '');
    btn.textContent = st.label;
    btn.addEventListener('click', () => {
      Sound.click();
      subNav.querySelectorAll('.m3-subtab-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      currentSub = st.id;
      showPanel(st.id);
    });
    subNav.appendChild(btn);
  }

  /* Audit console */
  const auditSection = document.createElement('div');
  auditSection.className = 'm3-audit-panel';
  auditSection.innerHTML = `
    <div class="m3-audit-head">
      <span class="m3-audit-title" id="sec-audit-title">🔍 Консоль аудита</span>
      <span class="m3-audit-progress" id="sec-audit-progress"></span>
    </div>
    <div class="m3-audit-bar"><div class="m3-audit-fill" id="sec-audit-fill" style="width:0%"></div></div>
    <div class="m3-audit-actions">
      <button class="m3-btn m3-btn-primary" id="sec-run-inline">▶ Запустить аудит</button>
      <button class="m3-btn m3-btn-ghost" id="sec-clear-log">✕ Очистить</button>
      <button class="m3-btn m3-btn-ghost" id="sec-export-one" title="Скачать отчёт в HTML">📄 Экспорт</button>
    </div>
    <pre class="m3-audit-log" id="sec-audit-log"></pre>
  `;
  wrap.appendChild(auditSection);
  bindAuditConsole(auditSection);

  syncCacheFromPreload();

  buildSecurityPanel(panels.security);
  buildPrivacyPanel(panels.privacy);
  buildComfortPanel(panels.comfort);

  showPanel(currentSub);
  updateAuditLog(currentSub, isAutoAuditEnabled());

  document.getElementById('sec-run')?.addEventListener('click', () => runCurrentAudit());
  document.getElementById('sec-run-inline')?.addEventListener('click', () => runCurrentAudit());

  document.getElementById('sec-export-one')?.addEventListener('click', async () => {
    Sound.click();
    await exportSingleReport(currentSub);
  });

  document.getElementById('sec-export-all')?.addEventListener('click', async () => {
    Sound.click();
    await exportAllReports();
  });

  document.getElementById('sec-clear-log')?.addEventListener('click', () => {
    Sound.click();
    auditCache.log[currentSub] = '';
    updateAuditLog(currentSub, isAutoAuditEnabled());
  });

  autoAuditCurrent();

  function showPanel(id) {
    for (const st of SUBTABS) {
      panels[st.id].style.display = (st.id === id) ? '' : 'none';
    }
    updateAuditLog(id, isAutoAuditEnabled());
    if (id === 'security') renderSecurityResult();
    if (id === 'privacy')  renderPrivacyResult();
    if (id === 'comfort')  renderComfortResult();
    autoAuditCurrent();
  }

  async function autoAuditCurrent() {
    if (!isAutoAuditEnabled()) return;
    if (currentSub === 'security') await autoAuditSecurity(true);
    else if (currentSub === 'privacy') await autoAuditPrivacy(true);
    else if (currentSub === 'comfort') await autoAuditComfort(true);
  }

  async function runCurrentAudit() {
    Sound.click();
    if (currentSub === 'security') await manualAuditSecurity();
    else if (currentSub === 'privacy')  await manualAuditPrivacy();
    else if (currentSub === 'comfort')  await manualAuditComfort();
    toast('Аудит завершён', 'success', 1500);
  }
}