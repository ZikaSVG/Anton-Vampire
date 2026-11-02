// Все темы проекта — вынесены в assets/themes.json
// Здесь только загрузка + генерация -dark вариантов + утилиты.

import themesData from '../../assets/themes.json' with { type: 'json' };

/* ============================================================
   ТЕМЫ
   ============================================================ */
export const THEMES = { ...themesData.themes };
export const THEMES_META = themesData.meta;

/* ---------- Утилиты для генерации -dark вариантов ---------- */
function hexToRgb(hex) {
  const m = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  if (!m) return { r: 0, g: 0, b: 0 };
  return { r: parseInt(m[1], 16), g: parseInt(m[2], 16), b: parseInt(m[3], 16) };
}
function rgbToHex(r, g, b) {
  const c = (v) => Math.max(0, Math.min(255, Math.round(v))).toString(16).padStart(2, '0');
  return '#' + c(r) + c(g) + c(b);
}
function mix(hex1, hex2, t) {
  const a = hexToRgb(hex1), b = hexToRgb(hex2);
  return rgbToHex(a.r + (b.r - a.r) * t, a.g + (b.g - a.g) * t, a.b + (b.b - a.b) * t);
}
function makeDark(c) {
  return {
    bg:        mix('#0a0a0a', c.accent, 0.05),
    bgAlt:     mix('#111111', c.accent, 0.06),
    card:      mix('#181818', c.accent, 0.08),
    cardHover: mix('#222222', c.accent, 0.10),
    border:    c.accent,
    fg:        '#f4f6f8',
    fgMuted:   mix('#8a8f9d', c.accent, 0.15),
    accent:    c.accent,
    accent2:   mix(c.accent, '#000000', 0.25),
    accentText:'#ffffff',
    success:   c.success,
    warning:   c.warning,
    danger:    c.danger,
    info:      c.info
  };
}

/* ---------- Генерация -dark вариантов светлых тем ---------- */
const LIGHT_THEME_KEYS = themesData.meta.lightThemeKeys || [];
for (const name of LIGHT_THEME_KEYS) {
  const src = THEMES[name];
  if (src) THEMES[name + '-dark'] = makeDark(src);
}

export const THEME_NAMES = Object.keys(THEMES);

/* ============================================================
   СПИСКИ ШРИФТОВ
   ============================================================ */
export const FONT_HEADING_LATIN_OPTIONS = [
  { id: 'Jersey 10',        label: 'Jersey 10 (пиксельный)' },
  { id: 'Pixelify Sans',    label: 'Pixelify Sans (пиксельный)' },
  { id: 'Press Start 2P',   label: 'Press Start 2P (пиксельный)' },
  { id: 'VT323',            label: 'VT323 (терминальный)' },
  { id: 'Silkscreen',       label: 'Silkscreen (пиксельный)' },
  { id: 'Inter',            label: '★ Inter (variable 100-900)' },
  { id: 'JetBrains Mono',   label: '★ JetBrains Mono (variable 100-800)' },
  { id: 'Ubuntu',           label: '★ Ubuntu Sans (variable 100-900)' },
  { id: 'IBM Plex Mono',    label: 'IBM Plex Mono' }
];

export const FONT_HEADING_CYR_OPTIONS = [
  { id: 'IBM Plex Mono',    label: 'IBM Plex Mono (моно)' },
  { id: 'JetBrains Mono',   label: '★ JetBrains Mono (моно)' },
  { id: 'Ubuntu',           label: '★ Ubuntu Sans' },
  { id: 'Inter',            label: '★ Inter' },
  { id: 'system-ui',        label: 'System UI' },
  { id: 'Segoe UI',         label: 'Segoe UI (системный)' }
];

export const FONT_BODY_LATIN_OPTIONS = [
  { id: 'Pixelify Sans',    label: 'Pixelify Sans (пиксельный)' },
  { id: 'Inter',            label: '★ Inter (variable 100-900)' },
  { id: 'JetBrains Mono',   label: '★ JetBrains Mono (variable)' },
  { id: 'Ubuntu',           label: '★ Ubuntu Sans (variable)' },
  { id: 'IBM Plex Mono',    label: 'IBM Plex Mono' },
  { id: 'system-ui',        label: 'System UI' }
];

export const FONT_BODY_CYR_OPTIONS = [
  { id: 'IBM Plex Mono',    label: 'IBM Plex Mono' },
  { id: 'JetBrains Mono',   label: '★ JetBrains Mono' },
  { id: 'Ubuntu',           label: '★ Ubuntu Sans' },
  { id: 'Inter',            label: '★ Inter' },
  { id: 'Segoe UI',         label: 'Segoe UI (системный)' },
  { id: 'system-ui',        label: 'System UI' }
];

export const FONT_MONO_OPTIONS = [
  { id: 'JetBrains Mono',   label: '★ JetBrains Mono (variable)' },
  { id: 'IBM Plex Mono',    label: 'IBM Plex Mono' },
  { id: 'Ubuntu',           label: '★ Ubuntu Sans Mono' },
  { id: 'Consolas',         label: 'Consolas (системный)' },
  { id: 'Cascadia Mono',    label: 'Cascadia Mono' },
  { id: 'monospace',        label: 'monospace' }
];

export const DENSITY_OPTIONS = [
  { id: 'compact',     label: 'Компактная' },
  { id: 'comfortable', label: 'Обычная' },
  { id: 'spacious',    label: 'Просторная' }
];

export const FONT_SIZE_OPTIONS = [
  { id: '11', label: '11 px' },
  { id: '12', label: '12 px' },
  { id: '13', label: '13 px (по умолчанию)' },
  { id: '14', label: '14 px' },
  { id: '15', label: '15 px' },
  { id: '16', label: '16 px' }
];

/* ============================================================
   ПРИМЕНЕНИЕ ТЕМЫ
   ============================================================ */
export function applyTheme(name, unifiedButtons = false, sidebarOpacity = undefined) {
  const t = THEMES[name] || THEMES.material3;
  const root = document.documentElement.style;

  root.setProperty('--bg',          t.bg);
  root.setProperty('--bg-alt',      t.bgAlt);
  root.setProperty('--card',        t.card);
  root.setProperty('--card-hover',  t.cardHover);
  root.setProperty('--border',      t.border);
  root.setProperty('--fg',          t.fg);
  root.setProperty('--fg-muted',    t.fgMuted);
  root.setProperty('--accent',      t.accent);
  root.setProperty('--accent-2',    t.accent2);
  root.setProperty('--accent-text', t.accentText);
  root.setProperty('--info',        t.info);

  if (unifiedButtons) {
    root.setProperty('--success', t.accent);
    root.setProperty('--warning', t.accent);
    root.setProperty('--danger',  t.accent);
  } else {
    root.setProperty('--success', t.success);
    root.setProperty('--warning', t.warning);
    root.setProperty('--danger',  t.danger);
  }

  document.body.dataset.theme = name;
  document.body.classList.toggle('unified-buttons', !!unifiedButtons);

  if (sidebarOpacity !== undefined) applySidebarOpacity(sidebarOpacity);
}

export function applySidebarOpacity(opacityPercent) {
  const v = Math.max(0, Math.min(100, Number(opacityPercent))) / 100;
  document.documentElement.style.setProperty('--sidebar-alpha', String(v));
}

/* ============================================================
   ПРИМЕНЕНИЕ ШРИФТОВ (с весами для Variable Fonts)
   ============================================================ */
export function applyFonts(cfg = {}) {
  const root = document.documentElement.style;

  const hLatin = cfg.font_heading_latin || 'Jersey 10';
  const hCyr   = cfg.font_heading_cyr   || 'IBM Plex Mono';
  const bLatin = cfg.font_body_latin    || 'Pixelify Sans';
  const bCyr   = cfg.font_body_cyr      || 'IBM Plex Mono';
  const mono   = cfg.font_mono          || 'JetBrains Mono';
  const bodySz = Number(cfg.body_font_size) || 13;
  const headSz = Number(cfg.heading_font_size) || 15;
  const headWt = Number(cfg.heading_font_weight) || 700;
  const bodyWt = Number(cfg.body_font_weight) || 400;

  const headingStack = `'${hLatin}', '${hCyr}', 'IBM Plex Mono', system-ui, monospace`;
  const bodyStack    = `'${bLatin}', '${bCyr}', 'IBM Plex Mono', 'Segoe UI', system-ui, sans-serif`;
  const monoStack    = `'${mono}', 'IBM Plex Mono', Consolas, 'Cascadia Mono', monospace`;

  root.setProperty('--font-heading', headingStack);
  root.setProperty('--font-body',    bodyStack);
  root.setProperty('--font-mono',    monoStack);
  root.setProperty('--body-font-size', bodySz + 'px');
  root.setProperty('--heading-font-size', headSz + 'px');
  root.setProperty('--heading-font-weight', String(headWt));
  root.setProperty('--body-font-weight',    String(bodyWt));

  document.documentElement.style.fontFamily = bodyStack;
  document.documentElement.style.fontSize = bodySz + 'px';
  document.body.style.fontFamily = bodyStack;
  document.body.style.fontSize = bodySz + 'px';

  let styleTag = document.getElementById('__dynamic_fonts__');
  if (!styleTag) {
    styleTag = document.createElement('style');
    styleTag.id = '__dynamic_fonts__';
    document.head.appendChild(styleTag);
  }

  styleTag.textContent = `
    h1, h2, h3, h4, h5, h6,
    .logo-title, .logo-sub, .brand h1, .apps-title,
    .section-title, .fixes-hero-title, .home-nav-name,
    .hh-hi, .security-score-title, .security-doc-title,
    .settings-section-title, .game-title, .opt-extra-title,
    .startup-group-title, .detected-title, .security-audit-title,
    .log-title, .comfort-tile-title, .apps-name,
    .hh-stat-label, .hh-stat-pct, .startup-name, .fw-name,
    .home-welcome-title, .tab-btn, .sub-tab-btn, .settings-subtab-btn,
    .sb-txt, .btn, .toggle-title, .field-label, .dd-value,
    .startup-badge, .startup-scope, .apps-count, .badge,
    .security-check-name, .security-stat-label, .security-stat-value,
    .security-summary-label, .security-summary-sub, .security-score-sub,
    .security-score-grade, .startup-summary-label, .startup-summary-value,
    .detected-panel-desc, .detected-tab-label, .opt-src-lbl,
    .vendor-select-all, .vendor-dropdown-title, .comfort-tile-state,
    .fixes-hero-sub, .fixes-hero-tile-title, .fixes-hero-tile-text,
    .hh-tag, .hh-stat-name, .home-nav-desc, .startup-details,
    .startup-status, .effect-card-label, .theme-name,
    .startup-mode-switch .mode-btn, .apps-run, .cbx-hone-run,
    .cbx-cancel, .fw-btn, .startup-btn {
      font-family: ${headingStack} !important;
      font-weight: ${headWt};
    }

    body, p, span, div, label, button, input, select, textarea,
    .muted, .apps-sub, .cbx-hone-desc, .cbx-at-label,
    .detected-desc, .toggle-desc, .field-desc,
    .security-note, .security-doc-t, .startup-details,
    .opt-extra-desc, .fixes-hero-sub {
      font-family: ${bodyStack};
      font-weight: ${bodyWt};
    }

    code, pre, .log-body, .security-audit-log,
    .fixes-log-body, .av-results-pre, .security-check-meta,
    .wallpaper-name, .cmd-row code, .mono, .startup-details {
      font-family: ${monoStack} !important;
    }

    body, p, span, div, label, input, select, textarea {
      font-size: ${bodySz}px;
    }
    h1, h2, h3, h4, h5, h6,
    .section-title, .apps-title, .logo-title,
    .brand h1, .fixes-hero-title, .home-nav-name, .hh-hi {
      font-size: ${headSz}px;
    }
  `;
}

/* ============================================================
   ПЛОТНОСТЬ
   ============================================================ */
export function applyDensity(density = 'comfortable') {
  const root = document.documentElement.style;
  const map = {
    compact:     { gap: '4px',  pad: '8px',  row: '28px', cardPad: '6px 10px',  btnPad: '4px 10px',  btnFs: '11px' },
    comfortable: { gap: '8px',  pad: '12px', row: '36px', cardPad: '10px 12px', btnPad: '5px 12px',  btnFs: '12px' },
    spacious:    { gap: '12px', pad: '16px', row: '44px', cardPad: '14px 16px', btnPad: '8px 18px',  btnFs: '13px' }
  };
  const d = map[density] || map.comfortable;
  root.setProperty('--ui-gap',  d.gap);
  root.setProperty('--ui-pad',  d.pad);
  root.setProperty('--ui-row',  d.row);
  root.setProperty('--ui-card-pad', d.cardPad);
  root.setProperty('--ui-btn-pad',  d.btnPad);
  root.setProperty('--ui-btn-fs',   d.btnFs);
}

/* ============================================================
   СКРУГЛЕНИЕ
   ============================================================ */
export function applyCornerRadius(px = 12) {
  const root = document.documentElement.style;
  const p = Math.max(0, Math.min(28, Number(px) || 12));
  root.setProperty('--radius-xs',   Math.max(2, Math.round(p * 0.25)) + 'px');
  root.setProperty('--radius-sm',   Math.max(4, Math.round(p * 0.5)) + 'px');
  root.setProperty('--radius-md',   p + 'px');
  root.setProperty('--radius-lg',   Math.round(p * 1.33) + 'px');
  root.setProperty('--radius-xl',   Math.round(p * 2) + 'px');
  root.setProperty('--radius-full', '9999px');
}

/* ============================================================
   ВИЗУАЛЬНЫЙ ЭФФЕКТ
   ============================================================ */
export function applyVisualEffect(effect = 'none') {
  const body = document.body;
  body.classList.remove('effect-glass', 'effect-aero');
  if (effect === 'glass') body.classList.add('effect-glass');
  else if (effect === 'aero') body.classList.add('effect-aero');

  try {
    if (window.api?.window?.setBackgroundMaterial) {
      let material = 'none';
      if (effect === 'aero') material = 'acrylic';
      else if (effect === 'glass') material = 'mica';
      window.api.window.setBackgroundMaterial(material);
    }
  } catch { /* ignore */ }
}