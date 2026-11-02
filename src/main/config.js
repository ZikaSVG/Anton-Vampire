const fs = require('fs');
const path = require('path');

const DEFAULTS = {
  General: {
    /* --- Основное --- */
    theme: 'cyberpunk_2077',
    ui_style: 'cyberpunk',   // 'default' | 'pixel' | 'material3' | 'kitty'
    font_family: 'Segoe UI',
    font_size: 13,
    checkbox_font_size: 13,
    quick_button_font_size: 16,
    tooltips_enabled: true,
    checkbox_display_mode: 'regular',
    first_run_completed: false,
    ad_enabled: false,
    offer_backup_enabled: false,
    confirm_switch_tab_enabled: false,
    initial_tab: 'main',
    tweak_execution_mode: 'nsudolg',
    frames_instead_of_tabs: true,
    show_checkbox_full_path: true,
    sidebar_opacity: 40,
    unified_button_color: true,
    visual_effect: 'none',
    tweak_timeout_ms: 300000,
    wallpaper_last_dir: '',
    logs_enabled: false,
    show_cancel_buttons: true,

    /* ---------- ШРИФТЫ ---------- */
    font_heading_latin: 'IBM Plex Mono',
    font_heading_cyr: 'IBM Plex Mono',
    font_body_latin: 'IBM Plex Mono',
    font_body_cyr: 'IBM Plex Mono',
    font_mono: 'JetBrains Mono',
    ui_density: 'comfortable',
    corner_radius: 12,
    body_font_size: 13,
    heading_font_size: 15,
    heading_font_weight: 700,
    body_font_weight: 400,

    /* ---------- ЗАГРУЗКА ---------- */
    lazy_tabs: true,
    show_splash: true,
    preload_heavy_tabs: false,
    preload_audits: false,

    /* ---------- БЕЗОПАСНОСТЬ ---------- */
    security_auto_audit: true,

    /* ---------- СЕТЕВОЙ МОНИТОР ---------- */
    netmon_host_mode: 'none',

    /* ---------- РАЗРАБОТКА ---------- */
    create_bat_config: false,
    developer_mode: true,
    novice_mode: false
  },
  Window: { fullscreen: false },
  Columns: { default: 3 }
};

class ConfigManager {
  constructor(dir) {
    this.dir = dir;
    this.file = path.join(dir, 'settings.json');
    this.data = this._load();

    this._saveTimer = null;
    this._pendingSave = false;
  }

  _load() {
    let raw = null;
    try {
      if (fs.existsSync(this.file)) {
        raw = JSON.parse(fs.readFileSync(this.file, 'utf8'));
      }
    } catch (e) {
      console.error('config load:', e);
    }
    const merged = mergeDeep(structuredClone(DEFAULTS), raw || {});
    coerceToDefaults(merged, DEFAULTS);
    return merged;
  }

  _save() {
    if (this._saveTimer) clearTimeout(this._saveTimer);
    this._saveTimer = setTimeout(() => {
      this._saveTimer = null;
      this._saveNow();
    }, 250);
  }

  _saveNow() {
    try {
      fs.writeFileSync(this.file, JSON.stringify(this.data, null, 2), 'utf8');
    } catch (e) {
      console.error('config save:', e);
    }
  }

  flush() {
    if (this._saveTimer) {
      clearTimeout(this._saveTimer);
      this._saveTimer = null;
    }
    this._saveNow();
  }

  get(key, fallback = undefined) {
    const parts = String(key).split('.');
    let cur = this.data;
    for (const p of parts) {
      if (cur === undefined || cur === null) return fallback;
      cur = cur[p];
    }
    return cur === undefined ? fallback : cur;
  }

  set(key, value) {
    const parts = String(key).split('.');
    if (!parts.length) return;

    if (parts.length === 1) {
      this.data[parts[0]] = value;
      this._save();
      return;
    }

    let cur = this.data;
    for (let i = 0; i < parts.length - 1; i++) {
      const p = parts[i];
      if (!cur[p] || typeof cur[p] !== 'object') cur[p] = {};
      cur = cur[p];
    }
    const last = parts[parts.length - 1];
    const def = getNested(DEFAULTS, parts);
    cur[last] = coerceValue(value, def);
    this._save();
  }

  reset() {
    this.data = structuredClone(DEFAULTS);
    this._saveNow();
  }

  getAll() { return this.data; }
}

function getNested(obj, parts) {
  let cur = obj;
  for (const p of parts) {
    if (cur === undefined || cur === null) return undefined;
    cur = cur[p];
  }
  return cur;
}

function coerceValue(value, def) {
  if (def === undefined) return value;
  if (typeof def === 'boolean') return value === true || value === 'true';
  if (typeof def === 'number') {
    const n = Number(value);
    return Number.isFinite(n) ? n : def;
  }
  if (typeof def === 'string') return value === undefined ? def : String(value);
  return value;
}

function mergeDeep(target, src) {
  for (const k of Object.keys(src)) {
    if (src[k] && typeof src[k] === 'object' && !Array.isArray(src[k])) {
      target[k] = mergeDeep(target[k] || {}, src[k]);
    } else {
      target[k] = src[k];
    }
  }
  return target;
}

function coerceToDefaults(target, defaults) {
  for (const k of Object.keys(defaults)) {
    const def = defaults[k];
    if (def !== null && typeof def === 'object' && !Array.isArray(def)) {
      if (!target[k] || typeof target[k] !== 'object') target[k] = {};
      coerceToDefaults(target[k], def);
    } else {
      if (target[k] === undefined) continue;
      target[k] = coerceValue(target[k], def);
    }
  }
}

module.exports = { ConfigManager, DEFAULTS };