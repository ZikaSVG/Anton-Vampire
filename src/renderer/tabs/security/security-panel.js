import { auditCache, runAudit, tryAutoAudit, markAuditStarted } from './audit-shared.js';
import { docCard, bigScoreCard, ratingTable, placeholder } from './ui.js';
import { buildFirewallPanel } from './firewall.js';
import { renderTweaksFor } from './tweaks.js';
import { SECURITY_SOURCES } from './sources-config.js';

const DOCS = {
  title: '🛡 Безопасность',
  paragraphs: [
    { h: 'Что проверяет аудит', t: '21 параметр защиты Windows: брандмауэр, антивирус, UAC, BitLocker, SMBv1, подпись SMB, политика паролей, автозапуск, WDigest, LSA Protection, LLMNR, Remote Registry, PowerShell v2, DEP, ASLR, SmartScreen, анонимный доступ к SMB, гостевую SMB-аутентификацию и NetBIOS over TCP/IP.' },
    { h: 'Формула Score', t: 'Score = (Набрано / Максимум) × 5 + 1. Passed = 4 балла, Low = 2, Medium = 1, High = 0. Итоговый Score — от 1.00 до 6.00.' },
    { h: 'Рейтинг', t: '6 — 😹 Excellent, 5 — 😻 Well done, 4 — 😺 Sufficient, 3 — 🙀 You should do better, 2 — 😿 Weak, 1 — 😾 Bogus.' }
  ]
};

export function buildSecurityPanel(panel) {
  panel.innerHTML = '';

  const scoreWrap = document.createElement('div');
  scoreWrap.id = 'sec-security-result';
  panel.appendChild(scoreWrap);

  panel.appendChild(docCard(DOCS));
  buildFirewallPanel(panel);

  const tw = document.createElement('div');
  tw.id = 'sec-security-tweaks';
  panel.appendChild(tw);
  renderTweaksFor(tw, SECURITY_SOURCES, 'security', 'Безопасность');
  renderResult();
}

export function renderResult() {
  const wrap = document.getElementById('sec-security-result');
  if (!wrap) return;
  wrap.innerHTML = '';

  if (!auditCache.security) {
    wrap.appendChild(placeholder('Нажми «▶ Запустить аудит», чтобы увидеть результат'));
    return;
  }

  const s = auditCache.security;
  wrap.appendChild(bigScoreCard({
    title: 'Уровень защиты системы',
    subtitle: 'Score = (Набрано / Максимум) × 5 + 1',
    score: s.score,
    scoreMax: 6,
    percent: s.percent,
    grade: s.grade,
    stats: [
      { label: 'Пройдено', value: s.stats.passed, weight: '4 балла', cls: 'good' },
      { label: 'Низкий риск', value: s.stats.low, weight: '2 балла', cls: 'warn' },
      { label: 'Средний риск', value: s.stats.medium, weight: '1 балл', cls: 'warn' },
      { label: 'Высокий риск', value: s.stats.high, weight: '0 баллов', cls: 'bad' },
      { label: 'Всего', value: s.stats.total, weight: '', cls: '' }
    ]
  }));
  wrap.appendChild(ratingTable(s.score));
}

export async function autoAuditSecurity(isAutoEnabled) {
  if (!isAutoEnabled) return;
  await tryAutoAudit('security', () => renderResult());
}

export async function manualAuditSecurity() {
  auditCache.security = null;
  auditCache.log.security = '';
  markAuditStarted('security');
  await runAudit('security');
  renderResult();
}