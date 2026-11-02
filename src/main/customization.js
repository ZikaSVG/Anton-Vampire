const fs = require('fs');
const path = require('path');
const os = require('os');
const { spawn } = require('child_process');
const { nativeImage } = require('electron');

/* ============================================================
   МОДУЛЬ «КАСТОМИЗАЦИЯ»
   ============================================================ */

const CUSTOMIZATION_DIR_REL = 'tweaks/Кастомизация';
const THEMES_DIR_REL        = `${CUSTOMIZATION_DIR_REL}/Темы`;
const TOOLS_DIR_REL         = `${CUSTOMIZATION_DIR_REL}/Установщики`;
const CONFIGS_DIR_REL       = `${CUSTOMIZATION_DIR_REL}/Конфиги`;
const CONFIG_DESCRIPTIONS_REL = `${CONFIGS_DIR_REL}/descriptions.txt`;
const CURSORS_DIR_REL       = `${CUSTOMIZATION_DIR_REL}/Курсоры`;

const WIN_THEMES_DIR  = 'C:\\Windows\\Resources\\Themes';
const WIN_CURSORS_DIR = 'C:\\Windows\\Cursors';
const UXTP_CHECK      = 'C:\\Program Files (x86)\\UltraUXThemePatcher\\Uninstall.exe';

const SKIP_DIRS = new Set(['Установщики', 'Конфиги', '_backups']);

const CONFIG_TARGETS = {
  'Yasb':    '%USERPROFILE%\\.config\\yasb',
  'GlazeWM': '%USERPROFILE%\\.glzr\\glazewm',
  'Nexus':   '%APPDATA%\\Winstep\\Nexus',
  'cava':    '%USERPROFILE%\\.config\\cava'
};

const MAX_BACKUPS_PER_APP = 0;
const CURSOR_EXT_RE = /\.(cur|ani)$/i;

/* Имя для ярлыка/записи автозагрузки WindowCenteringHelper */
const WCH_AUTOSTART_NAME = 'WindowCenteringHelper';

class Customization {
  constructor({ rootDir, config, logger }) {
    this.rootDir = path.resolve(rootDir);
    this.config = config;
    this.logger = logger;
    this.backupRoot = path.join(config.dir, 'config_backups');
    this.cursorsInstallDir = WIN_CURSORS_DIR;
    this._previewCache = new Map();
  }

  _log(msg) {
    if (this.logger) this.logger.info('[customization] ' + msg);
  }

  _resolveSafe(relPath) {
    const abs = path.resolve(this.rootDir, relPath);
    const rel = path.relative(this.rootDir, abs);
    if (rel.startsWith('..') || path.isAbsolute(rel)) {
      throw new Error(`Недопустимый путь: ${relPath}`);
    }
    return abs;
  }

  _expandVars(p) {
    return String(p).replace(/%([^%]+)%/g, (m, name) => process.env[name] || m);
  }

  /* ============================================================
     ТЕМЫ
     ============================================================ */
  listThemes() {
    const baseDir = path.join(this.rootDir, THEMES_DIR_REL);
    if (!fs.existsSync(baseDir)) {
      return { themes: [], uxtpInstalled: false, winThemesDir: WIN_THEMES_DIR };
    }
    let families;
    try {
      families = fs.readdirSync(baseDir, { withFileTypes: true })
        .filter(e => e.isDirectory())
        .filter(e => !SKIP_DIRS.has(e.name))
        .map(e => e.name);
    } catch {
      return { themes: [], uxtpInstalled: false, winThemesDir: WIN_THEMES_DIR };
    }
    const themes = [];
    for (const family of families) {
      const familyDir = path.join(baseDir, family);
      let files;
      try { files = fs.readdirSync(familyDir); } catch { continue; }
      const themeFiles = files.filter(f => /\.theme$/i.test(f));
      if (!themeFiles.length) continue;
      const subDirs = files.filter(f => {
        if (SKIP_DIRS.has(f)) return false;
        try { return fs.statSync(path.join(familyDir, f)).isDirectory(); } catch { return false; }
      });
      for (const tFile of themeFiles) {
        const stem = tFile.replace(/\.theme$/i, '');
        const preview = this._findPreview(familyDir, subDirs, stem);
        themes.push({
          id: `${family}::${tFile}`,
          family, fileName: tFile, displayName: stem,
          themePath: path.join(familyDir, tFile),
          familyDir, subDirs, preview
        });
      }
    }
    themes.sort((a, b) => {
      if (a.family !== b.family) return a.family.localeCompare(b.family, 'ru');
      return a.displayName.localeCompare(b.displayName, 'ru');
    });
    return { themes, uxtpInstalled: this.checkUXTP(), winThemesDir: WIN_THEMES_DIR };
  }

  _findPreview(familyDir, subDirs, stem) {
    const ext = ['png', 'jpg', 'jpeg', 'bmp', 'webp'];
    const tryFind = (dir) => {
      for (const e of ext) {
        const p = path.join(dir, `${stem}.${e}`);
        try { if (fs.existsSync(p) && fs.statSync(p).isFile()) return p; } catch { /* ignore */ }
      }
      for (const e of ext) {
        const p = path.join(dir, `${stem} NA.${e}`);
        try { if (fs.existsSync(p) && fs.statSync(p).isFile()) return p; } catch { /* ignore */ }
      }
      return null;
    };
    const tryFirstImage = (dir) => {
      try {
        for (const f of fs.readdirSync(dir)) {
          if (/\.(png|jpe?g|bmp|webp)$/i.test(f)) return path.join(dir, f);
        }
      } catch { /* ignore */ }
      return null;
    };
    const rootPrev = path.join(familyDir, 'Previews');
    if (fs.existsSync(rootPrev)) { const h = tryFind(rootPrev); if (h) return h; }
    for (const sd of subDirs) {
      const sdPrev = path.join(familyDir, sd, 'Previews');
      if (fs.existsSync(sdPrev)) { const h = tryFind(sdPrev); if (h) return h; }
    }
    if (fs.existsSync(rootPrev)) { const f = tryFirstImage(rootPrev); if (f) return f; }
    for (const sd of subDirs) {
      const sdPrev = path.join(familyDir, sd, 'Previews');
      if (fs.existsSync(sdPrev)) { const f = tryFirstImage(sdPrev); if (f) return f; }
    }
    return null;
  }

  checkUXTP() {
    try { return fs.existsSync(UXTP_CHECK); } catch { return false; }
  }

  async installTheme(themeId) {
    const { family, fileName } = this._parseThemeId(themeId);
    const familyDir = path.join(this.rootDir, THEMES_DIR_REL, family);
    if (!fs.existsSync(familyDir)) throw new Error(`Папка семейства не найдена: ${familyDir}`);
    if (!fs.existsSync(path.join(familyDir, fileName))) throw new Error(`Файл темы не найден`);

    const files = fs.readdirSync(familyDir);
    const subDirs = files.filter(f => {
      if (SKIP_DIRS.has(f)) return false;
      try { return fs.statSync(path.join(familyDir, f)).isDirectory(); } catch { return false; }
    });

    const bat = path.join(os.tmpdir(), `_install_theme_${Date.now()}.bat`);
    const lines = [
      '@echo off', 'chcp 65001 >nul',
      `set SRC=${familyDir}`,
      `set DST=${WIN_THEMES_DIR}`,
      'if not exist "%DST%" mkdir "%DST%"',
      'for %%F in ("%SRC%\\*.theme") do copy /Y "%%F" "%DST%\\" >nul',
    ];
    for (const sd of subDirs) {
      lines.push(`if exist "%SRC%\\${sd}" xcopy /E /I /Y "%SRC%\\${sd}" "%DST%\\${sd}\\" >nul`);
    }
    lines.push(`if exist "%DST%\\${fileName}" rundll32.exe themecpl.dll,OpenThemeAction "%DST%\\${fileName}"`);
    lines.push('exit /b 0');
    fs.writeFileSync(bat, lines.join('\r\n'), 'utf8');

    this._log(`установка темы "${family}/${fileName}"`);
    try {
      const result = await this._runElevated(bat);
      return { ok: result.code === 0, code: result.code, family, fileName, cancelled: !!result.cancelled };
    } finally {
      try { fs.unlinkSync(bat); } catch { /* ignore */ }
    }
  }

  async uninstallTheme(themeId) {
    const { family, fileName } = this._parseThemeId(themeId);
    const bat = path.join(os.tmpdir(), `_uninstall_theme_${Date.now()}.bat`);
    fs.writeFileSync(bat, [
      '@echo off', 'chcp 65001 >nul',
      `set DST=${WIN_THEMES_DIR}`,
      'if not exist "%DST%" exit /b 0',
      `if exist "%DST%\\${fileName}" del /F /Q "%DST%\\${fileName}" >nul 2>&1`,
      'exit /b 0'
    ].join('\r\n'), 'utf8');
    this._log(`удаление темы "${family}/${fileName}"`);
    try {
      const result = await this._runElevated(bat);
      return { ok: result.code === 0, code: result.code, family, fileName, cancelled: !!result.cancelled };
    } finally {
      try { fs.unlinkSync(bat); } catch { /* ignore */ }
    }
  }

  _parseThemeId(themeId) {
    if (!themeId) throw new Error('themeId пуст');
    const idx = String(themeId).indexOf('::');
    if (idx < 0) {
      const familyDir = path.join(this.rootDir, THEMES_DIR_REL, themeId);
      if (!fs.existsSync(familyDir)) throw new Error(`Тема не найдена: ${themeId}`);
      const files = fs.readdirSync(familyDir).filter(f => /\.theme$/i.test(f));
      if (!files.length) throw new Error(`В папке нет .theme: ${themeId}`);
      return { family: themeId, fileName: files[0] };
    }
    return { family: String(themeId).slice(0, idx), fileName: String(themeId).slice(idx + 2) };
  }

  /* ============================================================
     КОНФИГИ
     ============================================================ */
  listConfigs() {
    const baseDir = path.join(this.rootDir, CONFIGS_DIR_REL);
    if (!fs.existsSync(baseDir)) return { apps: [] };

    const descriptions = this._loadConfigDescriptions();
    const apps = [];

    let appNames;
    try {
      appNames = fs.readdirSync(baseDir, { withFileTypes: true })
        .filter(e => e.isDirectory()).map(e => e.name);
    } catch { return { apps: [] }; }

    for (const appName of appNames) {
      const appDir = path.join(baseDir, appName);
      const target = CONFIG_TARGETS[appName] || null;
      const expandedTarget = target ? this._expandVars(target) : null;

      let entries;
      try { entries = fs.readdirSync(appDir, { withFileTypes: true }); } catch { continue; }

      const configs = [];
      for (const entry of entries) {
        if (!entry.isDirectory()) continue;
        if (entry.name.startsWith('_')) continue;
        if (entry.name === 'Установщики') continue;

        const cfgDir = path.join(appDir, entry.name);
        const files = this._listFilesRecursive(cfgDir);
        if (!files.length) continue;

        const key = `${appName}/${entry.name}`;
        const description = descriptions[key] || descriptions[`${appName}\\${entry.name}`] || null;

        configs.push({
          id: `${appName}::${entry.name}`,
          appName, name: entry.name, dir: cfgDir,
          files, fileCount: files.length, description
        });
      }

      configs.sort((a, b) => a.name.localeCompare(b.name, 'ru'));
      apps.push({
        name: appName, target, expandedTarget, configs,
        backups: this.listBackups(appName)
      });
    }

    apps.sort((a, b) => a.name.localeCompare(b.name, 'ru'));
    return { apps };
  }

  _listFilesRecursive(dir, base = '') {
    const out = [];
    let entries;
    try { entries = fs.readdirSync(dir, { withFileTypes: true }); } catch { return out; }
    for (const e of entries) {
      const rel = base ? `${base}/${e.name}` : e.name;
      if (e.isDirectory()) out.push(...this._listFilesRecursive(path.join(dir, e.name), rel));
      else if (e.isFile()) out.push(rel);
    }
    return out;
  }

  _loadConfigDescriptions() {
    const file = path.join(this.rootDir, CONFIG_DESCRIPTIONS_REL);
    if (!fs.existsSync(file)) return {};
    try {
      const map = {};
      for (const line of fs.readFileSync(file, 'utf8').split(/\r?\n/)) {
        if (!line.includes('=')) continue;
        const idx = line.indexOf('=');
        const key = line.slice(0, idx).trim();
        const val = line.slice(idx + 1).trim();
        if (key && val) map[key] = val;
      }
      return map;
    } catch { return {}; }
  }

  async deployConfig(configId, opts = {}) {
    if (!configId) throw new Error('configId пуст');
    const { appName, configName } = this._parseConfigId(configId);

    const srcDir = path.join(this.rootDir, CONFIGS_DIR_REL, appName, configName);
    if (!fs.existsSync(srcDir)) throw new Error(`Папка конфига не найдена: ${srcDir}`);

    const target = CONFIG_TARGETS[appName];
    if (!target) throw new Error(`Не задан target для "${appName}"`);
    const expanded = this._expandVars(target);

    let autoBackupName = null;
    if (opts.autoBackup !== false && fs.existsSync(expanded)) {
      try {
        const r = await this.backupConfig(appName, `auto-before-deploy-${configName}`);
        autoBackupName = r.name;
      } catch { /* ignore */ }
    }

    const bat = path.join(os.tmpdir(), `_deploy_config_${Date.now()}.bat`);
    fs.writeFileSync(bat, [
      '@echo off', 'chcp 65001 >nul',
      `set SRC=${srcDir}`,
      `set DST=${expanded}`,
      'if not exist "%DST%" mkdir "%DST%"',
      'xcopy /E /I /Y "%SRC%\\*" "%DST%\\" >nul',
      'exit /b 0'
    ].join('\r\n'), 'utf8');

    try {
      const result = await this._runElevated(bat);
      return {
        ok: result.code === 0, code: result.code, target: expanded,
        autoBackup: autoBackupName,
        cancelled: !!result.cancelled,
        error: result.code === 0 ? null : (result.cancelled ? 'UAC отменён' : `exit ${result.code}`)
      };
    } finally {
      try { fs.unlinkSync(bat); } catch { /* ignore */ }
    }
  }

  _parseConfigId(configId) {
    const idx = String(configId).indexOf('::');
    if (idx < 0) throw new Error(`Некорректный configId: ${configId}`);
    return { appName: String(configId).slice(0, idx), configName: String(configId).slice(idx + 2) };
  }

  /* ============================================================
     БЭКАПЫ
     ============================================================ */
  async backupConfig(appName, label = '') {
    if (!appName) throw new Error('appName пуст');
    const target = CONFIG_TARGETS[appName];
    if (!target) throw new Error(`Не задан target для "${appName}"`);
    const expanded = this._expandVars(target);
    if (!fs.existsSync(expanded)) throw new Error(`Папка не существует: ${expanded}`);

    const timestamp = this._timestamp();
    const safeLabel = String(label || '').replace(/[^\w\-]+/g, '_').slice(0, 40);
    const folderName = safeLabel ? `${timestamp}__${safeLabel}` : timestamp;
    const destDir = path.join(this.backupRoot, appName, folderName);

    const bat = path.join(os.tmpdir(), `_backup_config_${Date.now()}.bat`);
    fs.writeFileSync(bat, [
      '@echo off', 'chcp 65001 >nul',
      `set SRC=${expanded}`,
      `set DST=${destDir}`,
      'if exist "%DST%" rmdir /S /Q "%DST%"',
      'mkdir "%DST%"',
      'xcopy /E /I /Y "%SRC%\\*" "%DST%\\" >nul',
      'exit /b 0'
    ].join('\r\n'), 'utf8');

    try {
      const result = await this._runElevated(bat);
      if (result.code !== 0) throw new Error(`бэкап не удался (exit ${result.code})`);
      if (MAX_BACKUPS_PER_APP > 0) this._pruneBackups(appName, MAX_BACKUPS_PER_APP);
      return { ok: true, name: folderName, path: destDir };
    } finally {
      try { fs.unlinkSync(bat); } catch { /* ignore */ }
    }
  }

  listBackups(appName) {
    const appBackupDir = path.join(this.backupRoot, appName);
    if (!fs.existsSync(appBackupDir)) return [];
    try {
      return fs.readdirSync(appBackupDir, { withFileTypes: true })
        .filter(e => e.isDirectory())
        .map(e => {
          const dir = path.join(appBackupDir, e.name);
          let size = 0, fileCount = 0;
          try {
            const files = this._listFilesRecursive(dir);
            fileCount = files.length;
            for (const f of files) {
              try { size += fs.statSync(path.join(dir, f)).size; } catch { /* ignore */ }
            }
          } catch { /* ignore */ }
          const [tsPart, ...labelParts] = e.name.split('__');
          return {
            name: e.name, timestamp: tsPart,
            label: labelParts.join('__') || null,
            dir, fileCount, sizeBytes: size, sizeText: this._formatSize(size)
          };
        })
        .sort((a, b) => b.timestamp.localeCompare(a.timestamp));
    } catch { return []; }
  }

  async restoreBackup(appName, backupName) {
    if (!appName || !backupName) throw new Error('appName/backupName пуст');
    const target = CONFIG_TARGETS[appName];
    if (!target) throw new Error(`Не задан target для "${appName}"`);
    const expanded = this._expandVars(target);

    const srcDir = path.join(this.backupRoot, appName, backupName);
    if (!fs.existsSync(srcDir)) throw new Error(`Бэкап не найден: ${srcDir}`);

    const bat = path.join(os.tmpdir(), `_restore_backup_${Date.now()}.bat`);
    fs.writeFileSync(bat, [
      '@echo off', 'chcp 65001 >nul',
      `set SRC=${srcDir}`,
      `set DST=${expanded}`,
      'if not exist "%DST%" mkdir "%DST%"',
      'xcopy /E /I /Y "%SRC%\\*" "%DST%\\" >nul',
      'exit /b 0'
    ].join('\r\n'), 'utf8');

    try {
      const result = await this._runElevated(bat);
      return { ok: result.code === 0, code: result.code, target: expanded, cancelled: !!result.cancelled };
    } finally {
      try { fs.unlinkSync(bat); } catch { /* ignore */ }
    }
  }

  async deleteBackup(appName, backupName) {
    if (!appName || !backupName) throw new Error('appName/backupName пуст');
    const dir = path.join(this.backupRoot, appName, backupName);
    if (!fs.existsSync(dir)) return { ok: true, notFound: true };
    try {
      fs.rmSync(dir, { recursive: true, force: true });
      return { ok: true };
    } catch (e) { return { ok: false, error: e.message }; }
  }

  _pruneBackups(appName, keep) {
    const list = this.listBackups(appName);
    if (list.length <= keep) return;
    for (const b of list.slice(keep)) {
      try { fs.rmSync(b.dir, { recursive: true, force: true }); } catch { /* ignore */ }
    }
  }

  _timestamp() {
    const d = new Date();
    const pad = n => String(n).padStart(2, '0');
    return (
      d.getFullYear() + '-' + pad(d.getMonth() + 1) + '-' + pad(d.getDate()) + '_' +
      pad(d.getHours()) + '-' + pad(d.getMinutes()) + '-' + pad(d.getSeconds())
    );
  }

  _formatSize(bytes) {
    if (!bytes) return '0 B';
    const units = ['B', 'KB', 'MB', 'GB'];
    let i = 0, n = bytes;
    while (n >= 1024 && i < units.length - 1) { n /= 1024; i++; }
    return `${n.toFixed(n < 10 && i > 0 ? 1 : 0)} ${units[i]}`;
  }

  /* ============================================================
     КУРСОРЫ — с ПРЕВЬЮ через icon.ico
     ============================================================ */

  listCursors() {
    const baseDir = path.join(this.rootDir, CURSORS_DIR_REL);
    if (!fs.existsSync(baseDir)) return { cursors: [], activeScheme: null };

    let entries;
    try {
      entries = fs.readdirSync(baseDir, { withFileTypes: true })
        .filter(e => e.isDirectory()).map(e => e.name);
    } catch { return { cursors: [], activeScheme: null }; }

    const installedDir = this.cursorsInstallDir;
    let installed = [];
    try {
      installed = fs.existsSync(installedDir)
        ? fs.readdirSync(installedDir, { withFileTypes: true })
            .filter(e => e.isDirectory()).map(e => e.name)
        : [];
    } catch { /* ignore */ }

    const cursors = [];

    for (const name of entries) {
      const dir = path.join(baseDir, name);

      let files = [];
      try {
        files = fs.readdirSync(dir, { withFileTypes: true })
          .filter(e => e.isFile()).map(e => e.name);
      } catch { /* ignore */ }

      const cursorFiles = files.filter(f => CURSOR_EXT_RE.test(f));
      const infName = this._findInfFile(files);

      const preview = this._cursorPreviewDataUrl(name, dir, files, cursorFiles);

      const isInstalled = installed.some(i => i.toLowerCase() === name.toLowerCase());

      cursors.push({
        id: name, name, dir,
        preview,
        fileCount: cursorFiles.length,
        hasInf: !!infName,
        infFile: infName ? path.join(dir, infName) : null,
        installed: isInstalled,
        active: false
      });
    }

    cursors.sort((a, b) => a.name.localeCompare(b.name, 'ru'));
    return { cursors, activeScheme: null };
  }

  _cursorPreviewDataUrl(cursorId, dir, allFiles, cursorFiles) {
    if (this._previewCache.has(cursorId)) {
      return this._previewCache.get(cursorId);
    }

    const priorityOrder = [];

    const icoFile = allFiles.find(f => /^icon\.ico$/i.test(f));
    if (icoFile) priorityOrder.push(icoFile);

    if (cursorFiles) {
      const normalCur = cursorFiles.find(f => /^normal\.cur$/i.test(f));
      const normalAni = cursorFiles.find(f => /^normal\.ani$/i.test(f));
      const arrowCur  = cursorFiles.find(f => /^arrow\.cur$/i.test(f));
      const arrowAni  = cursorFiles.find(f => /^arrow\.ani$/i.test(f));
      if (normalCur) priorityOrder.push(normalCur);
      if (normalAni) priorityOrder.push(normalAni);
      if (arrowCur)  priorityOrder.push(arrowCur);
      if (arrowAni)  priorityOrder.push(arrowAni);

      for (const f of cursorFiles) if (/\.cur$/i.test(f)) priorityOrder.push(f);
      for (const f of cursorFiles) if (/\.ani$/i.test(f)) priorityOrder.push(f);
    }

    for (const fileName of priorityOrder) {
      const srcPath = path.join(dir, fileName);
      try {
        const img = nativeImage.createFromPath(srcPath);
        if (img && !img.isEmpty()) {
          const dataUrl = img.toDataURL();
          if (dataUrl && dataUrl.length > 100) {
            this._previewCache.set(cursorId, dataUrl);
            return dataUrl;
          }
        }
      } catch { /* ignore */ }
    }

    this._previewCache.set(cursorId, null);
    return null;
  }

  _findInfFile(files) {
    const lower = files.map(f => ({ orig: f, lc: f.toLowerCase() }));
    const priority = ['install.inf', 'installer.inf', '.install.inf', 'setup.inf'];
    for (const p of priority) {
      const hit = lower.find(x => x.lc === p);
      if (hit) return hit.orig;
    }
    const any = lower.find(x => x.lc.endsWith('.inf'));
    return any ? any.orig : null;
  }

  _hasCursorFiles(dir) {
    try {
      if (!fs.existsSync(dir) || !fs.statSync(dir).isDirectory()) return false;
      return fs.readdirSync(dir).some(f => CURSOR_EXT_RE.test(f));
    } catch { return false; }
  }

  async installCursor(cursorId) {
    if (!cursorId) throw new Error('cursorId пуст');
    const srcDir = path.join(this.rootDir, CURSORS_DIR_REL, cursorId);
    if (!fs.existsSync(srcDir) || !fs.statSync(srcDir).isDirectory()) {
      throw new Error(`Папка курсора не найдена: ${srcDir}`);
    }

    const files = fs.readdirSync(srcDir);
    const infName = this._findInfFile(files);
    const destDir = path.join(this.cursorsInstallDir, cursorId);
    const infPath = infName ? path.join(srcDir, infName) : null;

    const bat = path.join(os.tmpdir(), `_install_cursor_${Date.now()}.bat`);
    const lines = [
      '@echo off', 'chcp 65001 >nul',
      `set SRC=${srcDir}`,
      `set DST=${destDir}`,
      'if not exist "%DST%" mkdir "%DST%"',
      'xcopy /E /I /Y "%SRC%\\*" "%DST%\\" >nul'
    ];
    if (infName) {
      const infInDest = path.join(destDir, infName);
      lines.push(`if exist "${infInDest}" rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 "${infInDest}"`);
    }
    lines.push('exit /b 0');
    fs.writeFileSync(bat, lines.join('\r\n'), 'utf8');

    this._log(`установка курсора "${cursorId}" → ${destDir}`);
    try {
      const result = await this._runElevated(bat);
      const filesCopied = this._hasCursorFiles(destDir);
      if (!filesCopied) {
        return {
          ok: false, code: result.code, cursorId, destDir,
          fallbackOpen: infPath || srcDir,
          error: result.error || `Файлы не скопировались в ${destDir}`
        };
      }
      return { ok: true, code: 0, cursorId, destDir, infRegistered: !!infName, fallbackOpen: null };
    } finally {
      try { fs.unlinkSync(bat); } catch { /* ignore */ }
    }
  }

  async activateCursor(cursorId) {
    if (!cursorId) throw new Error('cursorId пуст');
    const installDir = path.join(this.cursorsInstallDir, cursorId);

    if (!fs.existsSync(installDir)) {
      throw new Error(
        `Курсор "${cursorId}" не установлен.\nОжидаемая папка: ${installDir}\nСначала нажми «📥 Установить».`
      );
    }

    const files = fs.readdirSync(installDir).filter(f => CURSOR_EXT_RE.test(f));
    if (!files.length) throw new Error(`В ${installDir} нет .cur/.ani`);

    const roleMap = this._mapRolesToFiles(files);
    if (!roleMap || Object.keys(roleMap).length === 0) {
      throw new Error(`Не удалось сопоставить файлы в ${installDir}`);
    }

    const bat = path.join(os.tmpdir(), `_activate_cursor_${Date.now()}.bat`);
    const lines = ['@echo off', 'chcp 65001 >nul'];

    for (const role of Object.keys(roleMap)) {
      const p = `%SYSTEMROOT%\\Cursors\\${cursorId}\\${roleMap[role]}`;
      lines.push(`reg add "HKCU\\Control Panel\\Cursors" /v "${role}" /t REG_EXPAND_SZ /d "${p}" /f >nul`);
    }
    lines.push(`reg add "HKCU\\Control Panel\\Cursors" /ve /t REG_SZ /d "${cursorId}" /f >nul`);

    const psLine =
      `powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "` +
      `Add-Type -MemberDefinition '[DllImport(\\"user32.dll\\")] public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, IntPtr pvParam, uint fWinIni);' -Name N -Namespace W -ErrorAction SilentlyContinue; ` +
      `[W.N]::SystemParametersInfo(0x0057, 0, [IntPtr]::Zero, 0x03) | Out-Null"`;
    lines.push(psLine);

    lines.push('exit /b 0');
    fs.writeFileSync(bat, lines.join('\r\n'), 'utf8');

    this._log(`активация курсора "${cursorId}" (${Object.keys(roleMap).length} ролей)`);

    try {
      const result = await this._runElevated(bat);
      return {
        ok: result.code === 0,
        cursorId,
        roles: Object.keys(roleMap).length,
        code: result.code,
        cancelled: !!result.cancelled
      };
    } finally {
      try { fs.unlinkSync(bat); } catch { /* ignore */ }
    }
  }

  _mapRolesToFiles(files) {
    const lower = files.map(f => ({
      orig: f,
      lc: f.toLowerCase(),
      stem: f.toLowerCase().replace(/\.(cur|ani)$/i, '').replace(/[_\-\s]+/g, ' ').trim()
    }));

    const HINTS = {
      Arrow:       ['normal', 'default', 'arrow', 'pointer', 'cursor', '01-normal', 'normal select'],
      Help:        ['help', 'helpsel', '04-help'],
      AppStarting: ['working', 'work', 'wait', 'working in background', '03-loading'],
      Wait:        ['busy', 'load', 'loading', '02-busy'],
      Crosshair:   ['precision', 'precise', 'cross', 'crosshair', '07-precision'],
      IBeam:       ['text', 'ibeam', 'beam', 'text select', '05-text select'],
      NWPen:       ['handwriting', 'hand', 'pen', '06-handwriting'],
      No:          ['unavailable', 'unavail', 'no', '08-unavailable'],
      SizeNS:      ['vertical', 'vert', 'size ns', 'ns', '11-vertical resize'],
      SizeWE:      ['horizontal', 'horz', 'size we', 'we', '12-horizontal resize'],
      SizeNWSE:    ['diagonal1', 'diagonal 1', 'dgn1', '13-diagonal resize 1'],
      SizeNESW:    ['diagonal2', 'diagonal 2', 'dgn2', '14-diagonal resize 2'],
      SizeAll:     ['move', 'sizeall', '15-move'],
      UpArrow:     ['uparrow', 'arrow up', 'alternate', 'altselect', '16-alternate select'],
      Hand:        ['link', 'select', 'pointer', '09-location select'],
      Person:      ['person', 'location', '10-person select']
    };

    const result = {};
    const used = new Set();

    for (const role of Object.keys(HINTS)) {
      const hints = HINTS[role];
      for (const hint of hints) {
        const h = hint.toLowerCase();
        const hit = lower.find(x => !used.has(x.orig) && (
          x.stem === h || x.stem.includes(h) || x.lc.includes(h)
        ));
        if (hit) {
          used.add(hit.orig);
          result[role] = hit.orig;
          break;
        }
      }
    }

    return result;
  }

  async openMouseSettings() {
    this._log('открытие свойств мыши');
    return new Promise((resolve) => {
      try {
        const child = spawn('rundll32.exe',
          ['shell32.dll,Control_RunDLL', 'main.cpl'],
          { windowsHide: false, detached: true, stdio: 'ignore' });
        child.on('error', () => resolve({ ok: false }));
        child.unref();
        resolve({ ok: true });
      } catch (e) { resolve({ ok: false, error: e.message }); }
    });
  }

  async openInExplorer(filePath) {
    if (!filePath) throw new Error('filePath пуст');
    const abs = path.resolve(filePath);
    return new Promise((resolve) => {
      try {
        const isFile = fs.existsSync(abs) && fs.statSync(abs).isFile();
        const args = isFile ? ['/select,', abs] : [abs];
        const child = spawn('explorer.exe', args, {
          windowsHide: true, detached: true, stdio: 'ignore'
        });
        child.on('error', () => resolve({ ok: false }));
        child.unref();
        resolve({ ok: true });
      } catch (e) { resolve({ ok: false, error: e.message }); }
    });
  }

  async uninstallCursor(cursorId) {
    if (!cursorId) throw new Error('cursorId пуст');
    const destDir = path.join(this.cursorsInstallDir, cursorId);

    const bat = path.join(os.tmpdir(), `_uninstall_cursor_${Date.now()}.bat`);
    fs.writeFileSync(bat, [
      '@echo off', 'chcp 65001 >nul',
      `reg delete "HKCU\\Control Panel\\Cursors\\Schemes" /v "${cursorId}" /f >nul 2>&1`,
      `if exist "${destDir}" rmdir /S /Q "${destDir}" >nul 2>&1`,
      'exit /b 0'
    ].join('\r\n'), 'utf8');

    try {
      const result = await this._runElevated(bat);
      return { ok: result.code === 0, code: result.code, cursorId, cancelled: !!result.cancelled };
    } finally {
      try { fs.unlinkSync(bat); } catch { /* ignore */ }
    }
  }

  /* ============================================================
     УСТАНОВЩИКИ
     ============================================================ */

  async installTool(fileName, opts = {}) {
    if (!fileName) throw new Error('fileName пуст');
    const abs = path.join(this.rootDir, TOOLS_DIR_REL, fileName);
    if (!fs.existsSync(abs)) throw new Error(`Установщик не найден: ${abs}`);

    let result;

    if (/\.msi$/i.test(abs)) {
      const ps = `Start-Process msiexec.exe -ArgumentList '/i','"${abs}"' -Verb RunAs -Wait`;
      result = await this._runPowerShellElevated(ps);
    } else {
      const ps = `Start-Process -FilePath "${abs}" -Verb RunAs -Wait`;
      result = await this._runPowerShellElevated(ps);
    }

    // Если установщик успешно завершился и требуется автозагрузка — добавляем
    if (result && result.code === 0 && opts.autoStart) {
      try {
        await this._addToAutostart(abs);
      } catch (e) {
        this._log(`autostart failed: ${e.message}`);
      }
    }

    return result;
  }

  /**
   * Добавляет указанный exe в автозагрузку текущего пользователя.
   * Использует реестр HKCU\...\Run — самый надёжный и не требует админа.
   */
  async _addToAutostart(exePath) {
    if (!exePath) return { ok: false, error: 'exePath пуст' };
    const safe = String(exePath).replace(/'/g, "''");

    // Определяем имя значения реестра
    let valueName = WCH_AUTOSTART_NAME;
    const base = path.basename(exePath, path.extname(exePath));
    if (base && !/^[a-z0-9_.-]+$/i.test(base.replace(/[^a-z0-9_.-]/gi, ''))) {
      // если имя слишком «грязное» — оставляем стандартное
    } else if (base) {
      valueName = base;
    }

    const safeName = valueName.replace(/'/g, "''");

    const ps = `
$ErrorActionPreference = 'Stop'
$key = 'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Run'
if (-not (Test-Path $key)) { New-Item -Path $key -Force | Out-Null }
New-ItemProperty -Path $key -Name '${safeName}' -Value '"${safe}"' -PropertyType String -Force | Out-Null
Write-Output 'OK'
`;
    this._log(`добавление в автозагрузку: "${valueName}" → ${exePath}`);

    return new Promise((resolve) => {
      const child = spawn('powershell.exe',
        ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand',
          Buffer.from(ps, 'utf16le').toString('base64')],
        { windowsHide: true });

      let out = '';
      child.stdout.on('data', (d) => { out += d.toString(); });
      child.on('error', (e) => resolve({ ok: false, error: e.message }));
      child.on('close', () => {
        resolve({ ok: out.includes('OK') });
      });
    });
  }

  async uninstallUXTP() {
    if (!this.checkUXTP()) throw new Error('UltraUXThemePatcher не установлен');
    const ps = `Start-Process -FilePath "${UXTP_CHECK}" -Verb RunAs -Wait`;
    return this._runPowerShellElevated(ps);
  }

  /**
   * Запускает bat-файл с повышением прав.
   */
  _runElevated(batPath) {
    return new Promise((resolve) => {
      const psCommand = `Start-Process -FilePath "${batPath}" -Verb RunAs -Wait -WindowStyle Hidden`;
      const args = ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', psCommand];
      this._log(`_runElevated (UAC): powershell.exe ${args.join(' ')}`);

      let stderr = '';
      let stdout = '';
      const child = spawn('powershell.exe', args, { windowsHide: true });

      child.stdout?.on('data', (d) => { stdout += d.toString(); });
      child.stderr?.on('data', (d) => { stderr += d.toString(); });

      child.on('error', (e) => resolve({ code: -1, error: e.message }));

      child.on('exit', (code) => {
        const c = (code == null) ? -1 : code;

        const cancelled = (
          c !== 0 && (
            /The operation was canceled by the user/i.test(stderr) ||
            /Операция была отменена пользователем/i.test(stderr) ||
            /cannot find the file specified/i.test(stderr) ||
            /указанный файл не найден/i.test(stderr)
          )
        );

        if (cancelled) {
          this._log(`_runElevated: UAC отменён пользователем (code ${c})`);
        } else if (c !== 0) {
          this._log(`_runElevated: exit ${c}, stderr="${stderr.slice(0, 300)}"`);
        }

        resolve({ code: c, cancelled, error: cancelled ? 'UAC отменён' : (stderr || undefined) });
      });
    });
  }

  _runPowerShellElevated(psCommand) {
    return new Promise((resolve) => {
      let stderr = '';
      const child = spawn('powershell.exe',
        ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', psCommand],
        { windowsHide: true });

      child.stdout?.on('data', () => { /* ignore */ });
      child.stderr?.on('data', (d) => { stderr += d.toString(); });

      child.on('error', (e) => resolve({ code: -1, error: e.message }));
      child.on('exit', (code) => {
        const c = (code == null) ? -1 : code;
        const cancelled = (
          c !== 0 && (
            /The operation was canceled by the user/i.test(stderr) ||
            /Операция была отменена пользователем/i.test(stderr)
          )
        );
        resolve({ code: c, cancelled, error: cancelled ? 'UAC отменён' : (stderr || undefined) });
      });
    });
  }
}

module.exports = { Customization };