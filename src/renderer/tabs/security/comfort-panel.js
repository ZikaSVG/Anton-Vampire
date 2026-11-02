import { auditCache, runAudit, tryAutoAudit, markAuditStarted } from './audit-shared.js';
import { docCard, bigScoreCard, placeholder } from './ui.js';
import { buildComfortToggles } from './comfort-toggles.js';
import { renderTweaksFor } from './tweaks.js';
import { COMFORT_SOURCES } from './sources-config.js';

const DOCS = {
  title: '🛋 Удобство',
  paragraphs: [
    { h: 'Что это', t: 'Антагонист «Безопасности».' },
    { h: 'Тумблеры', t: 'Defender, UAC, SmartScreen, Windows Update, Брандмауэр.' }
  ]
};

export function buildComfortPanel(panel) {
  panel.innerHTML = '';

  const scoreWrap = document.createElement('div');
  scoreWrap.id = 'sec-comfort-result';
  panel.appendChild(scoreWrap);

  panel.appendChild(docCard(DOCS));
  buildComfortToggles(panel);

  const tw = document.createElement('div');
  tw.id = 'sec-comfort-tweaks';
  panel.appendChild(tw);
  renderTweaksFor(tw, COMFORT_SOURCES, 'comfort', 'Удобство');

  renderResult();
}

export function renderResult() {
  const wrap = document.getElementById('sec-comfort-result');
  if (!wrap) return;
  wrap.innerHTML = '';

  if (!auditCache.comfort) {
    wrap.appendChild(placeholder('Нажми «▶ Запустить аудит», чтобы увидеть результат'));
    return;
  }

  const c = auditCache.comfort;
  wrap.appendChild(bigScoreCard({
    title: 'Уровень удобства',
    subtitle: 'Чем выше — тем больше защит отключено ради удобства',
    score: (c.percent / 100) * 6, // Для текста 6.00
    scoreMax: 6,
    percent: c.percent,
    grade: c.grade,
    stats: [
      { label: 'Отключено защит', value: c.disabled, weight: 'ради удобства', cls: 'bad' },
      { label: 'Работает защит', value: c.enabled, weight: 'включены', cls: 'good' },
      { label: 'Всего', value: c.total, weight: '', cls: '' }
    ]
  }));
}

export async function autoAuditComfort(isAutoEnabled) {
  if (!isAutoEnabled) return;
  await tryAutoAudit('comfort', () => renderResult());
}

export async function manualAuditComfort() {
  auditCache.comfort = null;
  auditCache.log.comfort = '';
  markAuditStarted('comfort');
  await runAudit('comfort');
  renderResult();
}