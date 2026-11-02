import { auditCache, runAudit, tryAutoAudit, markAuditStarted } from './audit-shared.js';
import { docCard, bigScoreCard, placeholder } from './ui.js';
import { buildNetMonPanel } from './netmon.js';
import { renderTweaksFor } from './tweaks.js';
import { PRIVACY_SOURCES } from './sources-config.js';

const DOCS = {
  title: '🕵 Приватность',
  paragraphs: [
    { h: 'Приватность', t: 'Какие данные Windows отправляет в Microsoft.' },
    { h: 'Конфиденциальность', t: 'Что остаётся на устройстве.' },
    { h: 'Анонимность', t: 'Насколько вас можно отследить.' },
    { h: 'Сетевой монитор', t: 'Живой снимок TCP-соединений.' }
  ]
};

export function buildPrivacyPanel(panel) {
  panel.innerHTML = '';

  const scoreWrap = document.createElement('div');
  scoreWrap.id = 'sec-privacy-result';
  panel.appendChild(scoreWrap);

  panel.appendChild(docCard(DOCS));
  buildNetMonPanel(panel);

  const tw = document.createElement('div');
  tw.id = 'sec-privacy-tweaks';
  panel.appendChild(tw);
  renderTweaksFor(tw, PRIVACY_SOURCES, 'privacy', 'Приватность');
  renderResult();
}

export function renderResult() {
  const wrap = document.getElementById('sec-privacy-result');
  if (!wrap) return;
  wrap.innerHTML = '';

  if (!auditCache.privacy) {
    wrap.appendChild(placeholder('Нажми «▶ Запустить аудит», чтобы увидеть результат'));
    return;
  }

  const p = auditCache.privacy;
  wrap.appendChild(bigScoreCard({
    title: 'Уровень приватности',
    subtitle: 'Чем выше — тем меньше Windows собирает о вас данные',
    score: (p.percent / 100) * 6, // Для текста 6.00
    scoreMax: 6,
    percent: p.percent,
    grade: p.grade,
    stats: [
      { label: 'Приватность', value: p.privacy, weight: '%', cls: p.privacy >= 80 ? 'good' : p.privacy >= 50 ? 'warn' : 'bad' },
      { label: 'Конфиденциальность', value: p.confidential, weight: '%', cls: p.confidential >= 80 ? 'good' : p.confidential >= 50 ? 'warn' : 'bad' },
      { label: 'Анонимность', value: p.anonymous, weight: '%', cls: p.anonymous >= 80 ? 'good' : p.anonymous >= 50 ? 'warn' : 'bad' },
      { label: 'Утечек', value: (p.leaks || []).length, weight: '', cls: (p.leaks || []).length === 0 ? 'good' : 'bad' }
    ]
  }));
}

export async function autoAuditPrivacy(isAutoEnabled) {
  if (!isAutoEnabled) return;
  await tryAutoAudit('privacy', () => renderResult());
}

export async function manualAuditPrivacy() {
  auditCache.privacy = null;
  auditCache.log.privacy = '';
  markAuditStarted('privacy');
  await runAudit('privacy');
  renderResult();
}