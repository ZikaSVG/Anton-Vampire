const { app, BrowserWindow, ipcMain, dialog, shell } = require('electron');
const path = require('path');
const fs = require('fs');
const os = require('os');
const https = require('https');
const http = require('http');
const { URL } = require('url');
const { execFile, exec, spawnSync, spawn } = require('child_process');
const { ConfigManager } = require('./src/main/config');
const { Logger } = require('./src/main/logger');
const { TweakRunner } = require('./src/main/tweak-runner');
const { StartupManager } = require('./src/main/startup');
const { loadTabsData } = require('./src/main/tabs-data');
const dns = require('dns');

let mainWindow = null;
let config = null;
let logger = null;
let tweakRunner = null;
let startupManager = null;
let rootDir = null;

const isDev = process.argv.includes('--dev');
const IMAGE_EXT_RE = /\.(png|jpe?g|bmp|webp|gif)$/i;
const TEMP_PREFIX = '_extreme_patch_';
const TWEAK_RE = /\.(bat|cmd|exe|ps1|reg|pow)$/i;

let AV_DIR = null;
let CLAM_DIR = null;
let LOKI_DIR = null;
let WATCH_CFG = null;

function resolvePortableDataDir() {
  if (app.isPackaged) {
    return path.join(path.dirname(process.execPath), 'extreme_data');
  }
  return path.join(app.getAppPath(), 'extreme_data');
}

function setupPortableMode() {
  const dataDir = resolvePortableDataDir();
  fs.mkdirSync(dataDir, { recursive: true });

  const userData = path.join(dataDir, 'electron_userdata');
  fs.mkdirSync(userData, { recursive: true });
  app.setPath('userData', userData);

  const sub = {
    sessionData: path.join(userData, 'session'),
    cache:       path.join(userData, 'cache'),
    logs:        path.join(userData, 'chromium_logs'),
    crashDumps:  path.join(userData, 'crashDumps'),
    temp:        path.join(dataDir, 'temp'),
    userCache:   path.join(dataDir, 'userCache')
  };

  for (const [key, dir] of Object.entries(sub)) {
    try {
      fs.mkdirSync(dir, { recursive: true });
      app.setPath(key, dir);
    } catch { /* ignore */ }
  }

  app.commandLine.appendSwitch('disable-gpu-shader-disk-cache');
  app.commandLine.appendSwitch('disable-breakpad');
  app.commandLine.appendSwitch('no-crash-upload');

  return dataDir;
}

const PORTABLE_DATA_DIR = setupPortableMode();

function isRunningAsAdmin() {
  return new Promise((resolve) => {
    exec('fltmc', { windowsHide: true }, (err) => resolve(!err));
  });
}

function relaunchAsAdmin() {
  const exePath = process.execPath;
  const args = process.argv.slice(1).filter((a) => !a.startsWith('--relaunch'));
  const argsString = args.map((a) => `'${a.replace(/'/g, "''")}'`).join(',');
  const psArgs = args.length
    ? `-FilePath '${exePath.replace(/'/g, "''")}' -ArgumentList @(${argsString}) -Verb RunAs`
    : `-FilePath '${exePath.replace(/'/g, "''")}' -Verb RunAs`;

  const result = spawnSync(
    'powershell.exe',
    ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', `Start-Process ${psArgs}`],
    { windowsHide: true, stdio: 'ignore' }
  );

  if (result.error) console.error('[relaunch] spawnSync error:', result.error.message);
}

async function bootstrap() {
  if (process.argv.includes('--relaunch')) return true;

  const isAdmin = await isRunningAsAdmin();
  if (isAdmin) return true;

  const choice = dialog.showMessageBoxSync({
    type: 'warning',
    title: 'Требуются права администратора',
    message:
      'Приложение «Anton Vampire» работает только с правами администратора.\n\n' +
      'Сейчас будет выполнен перезапуск с запросом UAC.',
    buttons: ['Перезапустить', 'Выход'],
    defaultId: 0,
    cancelId: 1,
  });

  if (choice === 0) relaunchAsAdmin();
  app.quit();
  return false;
}

function resolveRootDir() {
  if (app.isPackaged) return process.resourcesPath;
  return app.getAppPath();
}

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 1400,
    height: 860,
    minWidth: 1100,
    minHeight: 700,
    backgroundColor: '#141218',           // тёмный фон вместо прозрачного
    title: 'Anton Vampire',
    autoHideMenuBar: true,
    frame: false,
    roundedCorners: true,
    show: false,                           // показываем после ready-to-show
    fullscreen: !!config.get('Window.fullscreen', false),
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      contextIsolation: true,
      nodeIntegration: false,
      sandbox: false
    }
  });

  mainWindow.once('ready-to-show', () => {
    try {
      if (typeof mainWindow.setBackgroundMaterial === 'function') {
        const effect = config.get('General.visual_effect', 'none');
        if (effect === 'aero') {
          mainWindow.setBackgroundMaterial('acrylic');
        } else if (effect === 'glass') {
          mainWindow.setBackgroundMaterial('mica');
        } else {
          mainWindow.setBackgroundMaterial('none');
        }
      }
    } catch (e) {
      logger.warn('setBackgroundMaterial(init): ' + e.message);
    }
    if (mainWindow && !mainWindow.isDestroyed()) mainWindow.show();
  });

  mainWindow.loadFile('index.html');
  if (isDev) mainWindow.webContents.openDevTools({ mode: 'detach' });

  mainWindow.on('closed', () => { mainWindow = null; });

  const sendMaximized = () => {
    if (!mainWindow || mainWindow.isDestroyed()) return;
    mainWindow.webContents.send('window:maximized-changed', mainWindow.isMaximized());
  };
  mainWindow.on('maximize',   sendMaximized);
  mainWindow.on('unmaximize', sendMaximized);
}

app.whenReady().then(async () => {
  const ok = await bootstrap();
  if (!ok) return;

  const userDataDir = PORTABLE_DATA_DIR;
  fs.mkdirSync(userDataDir, { recursive: true });

  config = new ConfigManager(userDataDir);
  logger = new Logger(userDataDir, config);
  rootDir = resolveRootDir();

  AV_DIR    = path.join(config.dir, 'antivirus');
  CLAM_DIR  = path.join(AV_DIR, 'clamav');
  LOKI_DIR  = path.join(AV_DIR, 'loki');
  WATCH_CFG = path.join(AV_DIR, 'watch.json');
  fs.mkdirSync(CLAM_DIR, { recursive: true });
  fs.mkdirSync(LOKI_DIR, { recursive: true });

  tweakRunner = new TweakRunner({ rootDir, config, logger });
  startupManager = new StartupManager({ rootDir, config, logger });

  logger.logProgramStart();
  logger.info(`appPath:  ${app.getAppPath()}`);
  logger.info(`rootDir:  ${rootDir}`);
  logger.info(`dataDir:  ${PORTABLE_DATA_DIR}`);
  logger.info(`packaged: ${app.isPackaged}`);
  logger.info(`elevated: ${process.argv.includes('--relaunch')}`);
  logger.info(`logs_enabled: ${config.get('General.logs_enabled', false)}`);

  logTweaksTree();
  cleanOrphanTempBats();

  registerIpc();
  createWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', () => {
  try { if (config) config.flush(); } catch { /* ignore */ }
  logger.logProgramExit();
  if (process.platform !== 'darwin') app.quit();
});

process.on('unhandledRejection', (reason) => {
  const msg = reason && reason.stack ? reason.stack : String(reason);
  console.error('[unhandledRejection]', msg);
  logger.error('[unhandledRejection] ' + msg);
});

process.on('uncaughtException', (err) => {
  const msg = err && err.stack ? err.stack : String(err);
  console.error('[uncaughtException]', msg);
  logger.error('[uncaughtException] ' + msg);
});

function logTweaksTree() {
  try {
    const tweaksDir = path.join(rootDir, 'tweaks');
    if (!fs.existsSync(tweaksDir)) {
      logger.warn(`tweaks/ NOT FOUND at ${tweaksDir}`);
      return;
    }
    const entries = fs.readdirSync(tweaksDir, { withFileTypes: true });
    const topFolders = entries.filter(e => e.isDirectory()).map(e => e.name);
    const topFiles   = entries.filter(e => e.isFile()).map(e => e.name);
    logger.info(`tweaks/ folder: ${tweaksDir}`);
    logger.info(`tweaks/ subfolders: ${topFolders.join(' | ') || '(none)'}`);
    if (topFiles.length) logger.info(`tweaks/ files: ${topFiles.join(' | ')}`);
  } catch (e) {
    logger.error('logTweaksTree: ' + e.message);
  }
}

function cleanOrphanTempBats() {
  const removed = [];
  try {
    const tmpDir = os.tmpdir();
    for (const name of fs.readdirSync(tmpDir)) {
      if (!name.startsWith(TEMP_PREFIX)) continue;
      const full = path.join(tmpDir, name);
      try { fs.unlinkSync(full); removed.push(full); } catch {}
    }
  } catch {}

  const tweaksDir = path.join(rootDir, 'tweaks');
  if (fs.existsSync(tweaksDir)) {
    const walk = (dir) => {
      let entries;
      try { entries = fs.readdirSync(dir, { withFileTypes: true }); } catch { return; }
      for (const e of entries) {
        const full = path.join(dir, e.name);
        if (e.isDirectory()) walk(full);
        else if (e.isFile() && e.name.startsWith(TEMP_PREFIX)) {
          try { fs.unlinkSync(full); removed.push(full); } catch {}
        }
      }
    };
    walk(tweaksDir);
  }
}

let descriptionsCache = null;
let descriptionsCacheMtime = 0;

function loadDescriptions() {
  try {
    const file = path.join(rootDir, 'tweaks', 'descriptions.txt');
    if (!fs.existsSync(file)) return {};
    const stat = fs.statSync(file);
    if (descriptionsCache && stat.mtimeMs === descriptionsCacheMtime) return descriptionsCache;
    const raw = fs.readFileSync(file, 'utf8');
    const map = {};
    for (const line of raw.split(/\r?\n/)) {
      if (!line.includes('=')) continue;
      const idx = line.indexOf('=');
      const key = line.slice(0, idx).trim();
      const val = line.slice(idx + 1).trim();
      if (key) map[key] = val;
    }
    descriptionsCache = map;
    descriptionsCacheMtime = stat.mtimeMs;
    return map;
  } catch { return {}; }
}

function findDescription(fileName) {
  const descriptions = loadDescriptions();
  const base = path.basename(fileName);
  if (descriptions[base]) return descriptions[base];
  for (const key of Object.keys(descriptions)) {
    if (!key) continue;
    if (base.includes(key) || key.includes(base)) return descriptions[key];
  }
  return null;
}

function wallpapersUserDir() { return path.join(config.dir, 'wallpapers'); }
function wallpapersBundledDir() {
  const candidates = [
    path.join(rootDir, 'assets', 'wallpapers'),
    path.join(app.getAppPath(), 'assets', 'wallpapers'),
    path.join(process.resourcesPath || '', 'assets', 'wallpapers')
  ];
  for (const p of candidates) { try { if (fs.existsSync(p)) return p; } catch {} }
  return candidates[0];
}
function ensureWallpapersDir() {
  const d = wallpapersUserDir(); fs.mkdirSync(d, { recursive: true }); return d;
}
function listImagesIn(dir, source) {
  if (!fs.existsSync(dir)) return [];
  try {
    return fs.readdirSync(dir, { withFileTypes: true })
      .filter(e => e.isFile()).map(e => e.name)
      .filter(n => IMAGE_EXT_RE.test(n))
      .sort((a, b) => a.localeCompare(b, 'ru'))
      .map(name => ({ name, source, path: path.join(dir, name) }));
  } catch { return []; }
}

function downloadToFile(url, destPath) {
  return new Promise((resolve, reject) => {
    let u; try { u = new URL(url); } catch (e) { return reject(new Error('Некорректный URL')); }
    if (u.protocol !== 'https:' && u.protocol !== 'http:') return reject(new Error('Разрешены только http(s) URL'));
    const mod = u.protocol === 'https:' ? https : http;
    const req = mod.get(url, { timeout: 15000 }, (res) => {
      if (res.statusCode >= 300 && res.statusCode < 400 && res.headers.location) {
        res.resume();
        return downloadToFile(res.headers.location, destPath).then(resolve, reject);
      }
      if (res.statusCode !== 200) { res.resume(); return reject(new Error('HTTP ' + res.statusCode)); }
      const tmp = destPath + '.part';
      const file = fs.createWriteStream(tmp);
      res.pipe(file);
      file.on('finish', () => { file.close(() => { try { fs.renameSync(tmp, destPath); } catch (e) { return reject(e); } resolve(destPath); }); });
      file.on('error', (err) => { try { fs.unlinkSync(tmp); } catch {} reject(err); });
    });
    req.on('timeout', () => { req.destroy(new Error('Timeout')); });
    req.on('error', reject);
  });
}

let cachedCpuName = null;
let cachedGpuName = null;
let lastCpuTimes = null;

function cpuSnapshot() {
  const cpus = os.cpus() || [];
  let idle = 0, total = 0;
  for (const c of cpus) { idle += c.times.idle; total += c.times.user + c.times.nice + c.times.sys + c.times.idle + c.times.irq; }
  return { idle, total };
}
function cpuLoadPercent() {
  const snap = cpuSnapshot();
  if (!lastCpuTimes) { lastCpuTimes = snap; return 0; }
  const idleDiff = snap.idle - lastCpuTimes.idle;
  const totalDiff = snap.total - lastCpuTimes.total;
  lastCpuTimes = snap;
  if (totalDiff <= 0) return 0;
  return Math.max(0, Math.min(100, 100 * (1 - idleDiff / totalDiff)));
}
function getCpuName() {
  if (cachedCpuName) return cachedCpuName;
  try { const cpus = os.cpus(); if (cpus && cpus.length) cachedCpuName = cpus[0].model.trim(); } catch {}
  return cachedCpuName || 'CPU';
}
function runExecFile(cmd, args, timeoutMs = 2500) {
  return new Promise((resolve) => {
    const timer = setTimeout(() => resolve(''), timeoutMs);
    try {
      execFile(cmd, args, { windowsHide: true }, (err, stdout) => {
        clearTimeout(timer);
        if (err) return resolve('');
        resolve(String(stdout || ''));
      });
    } catch { clearTimeout(timer); resolve(''); }
  });
}
async function getGpuName() {
  if (cachedGpuName) return cachedGpuName;
  const smiName = await runExecFile('nvidia-smi', ['--query-gpu=name', '--format=csv,noheader'], 2000);
  if (smiName) { cachedGpuName = smiName.split(/\r?\n/)[0].trim(); return cachedGpuName; }
  const out = await runExecFile('wmic', ['path', 'win32_VideoController', 'get', 'name'], 2500);
  const lines = out.split(/\r?\n/).map(l => l.trim()).filter(Boolean);
  const names = lines.filter(l => !/^name$/i.test(l));
  if (names.length) { cachedGpuName = names[0]; return cachedGpuName; }
  return 'GPU';
}
async function getGpuLoad() {
  const out = await runExecFile('nvidia-smi', ['--query-gpu=utilization.gpu', '--format=csv,noheader,nounits'], 1500);
  if (out) { const n = Number(out.split(/\r?\n/)[0].trim()); if (Number.isFinite(n)) return n; }
  return 0;
}
function getSystemDriveLetter() {
  try { const sysRoot = process.env.SystemRoot || 'C:\\Windows'; const letter = sysRoot.slice(0, 1).toUpperCase(); if (/^[A-Z]$/.test(letter)) return letter; } catch {}
  return 'C';
}
function getDiskStats(letter) {
  const driveLetter = String(letter || getSystemDriveLetter()).replace(/:$/, '');
  const root = driveLetter + ':\\';
  try {
    const st = fs.statfsSync(root);
    const total = st.blocks * st.bsize;
    const free  = st.bfree  * st.bsize;
    if (Number.isFinite(total) && total > 0) {
      const totalGb = total / (1024 ** 3); const freeGb  = free  / (1024 ** 3);
      const usedGb  = totalGb - freeGb; const percent = (usedGb / totalGb) * 100;
      return Promise.resolve({ totalGb, usedGb, freeGb, percent });
    }
  } catch {}
  return new Promise((resolve) => {
    const psCommand = `$d = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='${driveLetter}:'"; if ($d) { "{0}|{1}" -f $d.Size, $d.FreeSpace }`;
    const timer = setTimeout(() => resolve(null), 2500);
    try {
      exec(`powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "${psCommand}"`, { windowsHide: true }, (err, stdout) => {
        clearTimeout(timer);
        if (err) return resolve(null);
        const line = String(stdout || '').trim().split(/\r?\n/).pop() || '';
        const [sizeRaw, freeRaw] = line.split('|');
        const size = Number(sizeRaw); const free = Number(freeRaw);
        if (!Number.isFinite(size) || !Number.isFinite(free) || size <= 0) return resolve(null);
        const totalGb = size / (1024 ** 3); const freeGb  = free / (1024 ** 3);
        const usedGb  = totalGb - freeGb; const percent = (usedGb / totalGb) * 100;
        resolve({ totalGb, usedGb, freeGb, percent });
      });
    } catch { clearTimeout(timer); resolve(null); }
  });
}
async function collectHardwareStats() {
  const totalMem   = os.totalmem();
  const freeMem    = os.freemem();
  const usedMem    = totalMem - freeMem;
  const ramTotalGb = totalMem / (1024 ** 3);
  const ramUsedGb  = usedMem / (1024 ** 3);
  const ramPercent = ramTotalGb > 0 ? (ramUsedGb / ramTotalGb) * 100 : 0;
  const [cpuName, gpuName, gpuLoad, disk] = await Promise.all([
    Promise.resolve(getCpuName()), getGpuName(), getGpuLoad(), getDiskStats(getSystemDriveLetter())
  ]);
  return { cpuName, cpuLoad: cpuLoadPercent(), gpuName, gpuLoad, ramTotalGb, ramUsedGb, ramPercent,
    diskTotalGb: disk ? disk.totalGb : 0, diskUsedGb: disk ? disk.usedGb : 0, diskPercent: disk ? disk.percent : 0 };
}

function parseJsonLoose(out) {
  const s = String(out || '').replace(/^\uFEFF/, '');
  const start = s.search(/[\{\[]/);
  if (start < 0) return null;
  const end = Math.max(s.lastIndexOf('}'), s.lastIndexOf(']'));
  if (end <= start) return null;
  try { return JSON.parse(s.slice(start, end + 1)); } catch { return null; }
}

function isTempPatchName(name) { return String(name).startsWith(TEMP_PREFIX); }
function isTweakFile(name) { return TWEAK_RE.test(name) && !isTempPatchName(name); }

const GITHUB_REPO   = 'anton18-png/Pretty-Cursors';
const GITHUB_BRANCH = 'main';
const GITHUB_RAW    = `https://raw.githubusercontent.com/${GITHUB_REPO}/${GITHUB_BRANCH}/`;
const GITHUB_API    = `https://api.github.com/repos/${GITHUB_REPO}/contents`;
const CURSORS_DIR       = 'C:\\Windows\\Cursors';
const CURSORS_REMOTE_DIR = 'cursors';
const ICONS_REMOTE_DIR   = 'assets/cursor_icons';

function getCursorsCacheDir() { const dir = path.join(config.dir, 'cursors_cache'); fs.mkdirSync(dir, { recursive: true }); return dir; }
function getCursorsTempDir() { const dir = path.join(config.dir, 'cursors_temp'); fs.mkdirSync(dir, { recursive: true }); return dir; }
function getCursorIconsDir() { const dir = path.join(config.dir, 'cursor_icons'); fs.mkdirSync(dir, { recursive: true }); return dir; }

function getCursorIconPath(name) {
  const dirs = [path.join(rootDir, 'assets', 'cursor_icons'), path.join(app.getAppPath(), 'assets', 'cursor_icons'), getCursorIconsDir()];
  const exts = ['.png', '.PNG', '.jpg', '.jpeg', '.webp', '.gif'];
  for (const dir of dirs) {
    if (!fs.existsSync(dir)) continue;
    for (const ext of exts) {
      const p = path.join(dir, `${name}${ext}`);
      try { if (fs.existsSync(p)) return p; } catch {}
    }
  }
  return null;
}
function isCursorInstalled(name) {
  const dir = path.join(CURSORS_DIR, name);
  if (!fs.existsSync(dir)) return false;
  try { return fs.readdirSync(dir).some(f => /\.(cur|ani)$/i.test(f)); } catch { return false; }
}
function isCursorDownloaded(name) { return fs.existsSync(path.join(getCursorsCacheDir(), `${name}.7z`)); }

function downloadFileByUrl(url, dest, redirects = 0) {
  return new Promise((resolve, reject) => {
    if (redirects > 5) return reject(new Error('Too many redirects'));
    const file = fs.createWriteStream(dest);
    const mod = url.startsWith('https') ? https : http;
    const req = mod.get(url, { headers: { 'User-Agent': 'AntonVampire/1.0', 'Accept': 'application/octet-stream' }, timeout: 30000 }, (res) => {
      if ([301, 302, 307, 308].includes(res.statusCode)) { file.close(); try { fs.unlinkSync(dest); } catch {} return downloadFileByUrl(res.headers.location, dest, redirects + 1).then(resolve, reject); }
      if (res.statusCode !== 200) { file.close(); try { fs.unlinkSync(dest); } catch {} return reject(new Error(`HTTP ${res.statusCode}`)); }
      res.pipe(file); file.on('finish', () => file.close(() => resolve(dest)));
    });
    req.on('timeout', () => req.destroy(new Error('Timeout')));
    req.on('error', (err) => { file.close(); try { fs.unlinkSync(dest); } catch {} reject(err); });
  });
}
function downloadStringByUrl(url, redirects = 0) {
  return new Promise((resolve, reject) => {
    if (redirects > 5) return reject(new Error('Too many redirects'));
    const mod = url.startsWith('https') ? https : http;
    const req = mod.get(url, { headers: { 'User-Agent': 'AntonVampire/1.0' }, timeout: 15000 }, (res) => {
      if ([301, 302, 307, 308].includes(res.statusCode)) { res.resume(); return downloadStringByUrl(res.headers.location, redirects + 1).then(resolve, reject); }
      if (res.statusCode !== 200) { res.resume(); return reject(new Error(`HTTP ${res.statusCode}`)); }
      const chunks = []; res.on('data', (c) => chunks.push(c));
      res.on('end', () => resolve(Buffer.concat(chunks).toString('utf8')));
    });
    req.on('timeout', () => req.destroy(new Error('Timeout')));
    req.on('error', reject);
  });
}

let _cursorsListCache = null;
let _cursorsListCacheAt = 0;
const CURSORS_CACHE_TTL = 60 * 1000;

async function fetchCursorsList(force = false) {
  if (!force && _cursorsListCache && (Date.now() - _cursorsListCacheAt) < CURSORS_CACHE_TTL) return _cursorsListCache;
  try {
    const raw = await downloadStringByUrl(`${GITHUB_RAW}assets/cursors.json`);
    const json = JSON.parse(raw);
    if (Array.isArray(json)) {
      const list = json.map(item => {
        const name = String(item.name || '').replace(/\.7z$/i, '').trim();
        if (!name) return null;
        return { name, fileName: `${name}.7z`, size: item.size || 0, downloadUrl: item.downloadUrl || `${GITHUB_RAW}${CURSORS_REMOTE_DIR}/${encodeURIComponent(name)}.7z` };
      }).filter(Boolean);
      if (list.length) { _cursorsListCache = list; _cursorsListCacheAt = Date.now(); return list; }
    }
  } catch {}
  try {
    const raw = await downloadStringByUrl(`${GITHUB_API}/${CURSORS_REMOTE_DIR}?ref=${GITHUB_BRANCH}`);
    const json = JSON.parse(raw);
    if (Array.isArray(json)) {
      const list = json.filter(item => item.type === 'file' && /\.7z$/i.test(item.name)).map(item => {
        const name = item.name.replace(/\.7z$/i, '');
        return { name, fileName: item.name, size: item.size || 0, downloadUrl: item.download_url || `${GITHUB_RAW}${CURSORS_REMOTE_DIR}/${encodeURIComponent(item.name)}` };
      });
      if (list.length) { _cursorsListCache = list; _cursorsListCacheAt = Date.now(); return list; }
    }
  } catch {}
  return [];
}

async function downloadMissingIcons(cursorNames) {
  const dir = getCursorIconsDir();
  const missing = []; for (const name of cursorNames) { if (!getCursorIconPath(name)) missing.push(name); }
  if (!missing.length) return 0;
  let downloaded = 0;
  for (const name of missing) {
    const localPath = path.join(dir, `${name}.png`);
    const remoteUrl = `${GITHUB_RAW}${ICONS_REMOTE_DIR}/${encodeURIComponent(name)}.png`;
    try { await downloadFileByUrl(remoteUrl, localPath); downloaded++; } catch {}
  }
  return downloaded;
}

async function cursorDownload(name) {
  const archivePath = path.join(getCursorsCacheDir(), `${name}.7z`);
  try {
    if (fs.existsSync(archivePath)) return { ok: true, alreadyDownloaded: true, size: fs.statSync(archivePath).size };
    const list = await fetchCursorsList(); const item = list.find(x => x.name === name);
    const url = item?.downloadUrl || `${GITHUB_RAW}${CURSORS_REMOTE_DIR}/${encodeURIComponent(name)}.7z`;
    await downloadFileByUrl(url, archivePath);
    return { ok: true, size: fs.statSync(archivePath).size };
  } catch (e) { try { if (fs.existsSync(archivePath)) fs.unlinkSync(archivePath); } catch {} return { ok: false, error: e.message }; }
}

async function extractCursorArchive(archivePath, destDir) {
  const sevenZip = path.join(rootDir, 'Utils', '7z.exe');
  if (!fs.existsSync(sevenZip)) throw new Error('7z.exe не найден в Utils/');
  return new Promise((resolve, reject) => {
    execFile(sevenZip, ['x', archivePath, `-o${destDir}`, '-y'], { windowsHide: true, maxBuffer: 32 * 1024 * 1024 }, (err, stdout, stderr) => {
      if (err) return reject(new Error(stderr || err.message)); resolve();
    });
  });
}
function copyRecursiveSync(src, dest) {
  const stat = fs.statSync(src);
  if (stat.isDirectory()) {
    if (!fs.existsSync(dest)) fs.mkdirSync(dest, { recursive: true });
    for (const n of fs.readdirSync(src)) copyRecursiveSync(path.join(src, n), path.join(dest, n));
  } else { fs.copyFileSync(src, dest); }
}

async function cursorsListInfo(force = false) {
  const list = await fetchCursorsList(force);
  await downloadMissingIcons(list.map(x => x.name));
  return list.map(item => ({ name: item.name, size: item.size || 0, icon: getCursorIconPath(item.name), installed: isCursorInstalled(item.name), downloaded: isCursorDownloaded(item.name) }));
}

async function cursorInstall(name, roleHints) {
  const archivePath = path.join(getCursorsCacheDir(), `${name}.7z`);
  const tempExtract = path.join(getCursorsTempDir(), name);
  const destDir = path.join(CURSORS_DIR, name);
  try {
    if (!fs.existsSync(archivePath)) { const dl = await cursorDownload(name); if (!dl.ok) throw new Error(dl.error || 'Не удалось скачать архив'); }
    if (fs.existsSync(tempExtract)) fs.rmSync(tempExtract, { recursive: true, force: true });
    fs.mkdirSync(tempExtract, { recursive: true });
    await extractCursorArchive(archivePath, tempExtract);
    let sourceRoot = tempExtract;
    const entries = fs.readdirSync(tempExtract, { withFileTypes: true });
    if (entries.length === 1 && entries[0].isDirectory()) sourceRoot = path.join(tempExtract, entries[0].name);
    if (fs.existsSync(destDir)) fs.rmSync(destDir, { recursive: true, force: true });
    fs.mkdirSync(destDir, { recursive: true });
    for (const f of fs.readdirSync(sourceRoot)) {
      const s = path.join(sourceRoot, f); const d = path.join(destDir, f);
      if (fs.statSync(s).isDirectory()) copyRecursiveSync(s, d); else fs.copyFileSync(s, d);
    }
    const checkFiles = [];
    const walkCheck = (dir, prefix = '') => {
      for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
        const rel = prefix ? `${prefix}/${e.name}` : e.name;
        if (e.isDirectory()) walkCheck(path.join(dir, e.name), rel); else if (/\.(cur|ani)$/i.test(e.name)) checkFiles.push(rel);
      }
    };
    walkCheck(destDir);
    if (checkFiles.length === 0) throw new Error('В архиве нет .cur/.ani файлов');
    const infFile = fs.readdirSync(destDir).find(f => f.toLowerCase().endsWith('.inf'));
    if (infFile) {
      const infPath = path.join(destDir, infFile);
      await new Promise((resolve) => { execFile('rundll32.exe', ['setupapi.dll,InstallHinfSection', 'DefaultInstall', '132', infPath], { windowsHide: true }, () => resolve()); });
    }
    try { fs.rmSync(tempExtract, { recursive: true, force: true }); } catch {}
    return { ok: true, filesCount: checkFiles.length };
  } catch (e) { try { if (fs.existsSync(tempExtract)) fs.rmSync(tempExtract, { recursive: true, force: true }); } catch {} return { ok: false, error: `установка не удалась: ${e.message}` }; }
}

async function cursorActivate(name, roleHints) {
  const cursorDir = path.join(CURSORS_DIR, name);
  if (!fs.existsSync(cursorDir)) throw new Error(`Папка не найдена: ${cursorDir}`);
  const cursorFiles = [];
  const walk = (dir, prefix = '') => {
    for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
      const rel = prefix ? `${prefix}/${e.name}` : e.name;
      if (e.isDirectory()) walk(path.join(dir, e.name), rel); else if (/\.(cur|ani)$/i.test(e.name)) cursorFiles.push(rel);
    }
  };
  walk(cursorDir);
  if (!cursorFiles.length) throw new Error('В папке нет .cur/.ani файлов');
  const hints = roleHints || {}; const commands = []; const used = new Set();
  for (const [role, list] of Object.entries(hints)) {
    let matched = null;
    for (const f of cursorFiles) {
      if (used.has(f)) continue;
      const base = f.toLowerCase().replace(/\.(cur|ani)$/i, '').replace(/[_\-\s]+/g, ' ').trim();
      for (const h of list) { if (base === h || base.startsWith(h + ' ')) { matched = f; break; } }
      if (matched) break;
    }
    if (!matched) { for (const h of list) { matched = cursorFiles.find(f => !used.has(f) && f.toLowerCase().includes(h)); if (matched) break; } }
    if (matched) { used.add(matched); const fullPath = path.join(cursorDir, matched).replace(/\//g, '\\'); commands.push(`reg add "HKCU\\Control Panel\\Cursors" /v "${role}" /t REG_EXPAND_SZ /d "${fullPath}" /f`); }
  }
  if (!commands.length) {
    const roles = Object.keys(hints);
    for (let i = 0; i < Math.min(cursorFiles.length, roles.length); i++) {
      const fullPath = path.join(cursorDir, cursorFiles[i]).replace(/\//g, '\\');
      commands.push(`reg add "HKCU\\Control Panel\\Cursors" /v "${roles[i]}" /t REG_EXPAND_SZ /d "${fullPath}" /f`);
    }
  }
  if (!commands.length) throw new Error('Не удалось сопоставить файлы с ролями');
  commands.push(`reg add "HKCU\\Control Panel\\Cursors" /ve /t REG_SZ /d "${name}" /f`);
  const bat = path.join(getCursorsTempDir(), `activate_${Date.now()}.bat`);
  fs.writeFileSync(bat, ['@echo off', 'chcp 65001 >nul', ...commands, 'exit /b 0'].join('\r\n'), 'utf8');
  await new Promise((resolve, reject) => { execFile('cmd.exe', ['/c', bat], { windowsHide: true }, (err) => { try { fs.unlinkSync(bat); } catch {} if (err) reject(err); else resolve(); }); });
  const ps = `Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, IntPtr pvParam, uint fWinIni);' -Name N -Namespace W -ErrorAction SilentlyContinue; [W.N]::SystemParametersInfo(0x0057, 0, [IntPtr]::Zero, 0x03) | Out-Null`;
  await new Promise((resolve) => { execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', ps], { windowsHide: true }, () => resolve()); });
  return { ok: true, roles: commands.length - 1 };
}

async function cursorUninstall(name) {
  const destDir = path.join(CURSORS_DIR, name);
  const archivePath = path.join(getCursorsCacheDir(), `${name}.7z`);
  try {
    if (fs.existsSync(destDir)) {
      await new Promise((resolve) => {
        const ps = `Remove-Item -LiteralPath '${destDir.replace(/'/g, "''")}' -Recurse -Force -ErrorAction SilentlyContinue`;
        execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', ps], { windowsHide: true }, () => resolve());
      });
    }
    if (fs.existsSync(archivePath)) { try { fs.unlinkSync(archivePath); } catch {} }
    return { ok: true };
  } catch (e) { return { ok: false, error: e.message }; }
}

async function resetCursorsToDefault(defaults) {
  const cmds = Object.entries(defaults || {}).map(([r, p]) => `reg add "HKCU\\Control Panel\\Cursors" /v "${r}" /t REG_EXPAND_SZ /d "${p}" /f`);
  cmds.push(`reg add "HKCU\\Control Panel\\Cursors" /ve /t REG_SZ /d "" /f`);
  const bat = path.join(getCursorsTempDir(), `reset_${Date.now()}.bat`);
  fs.writeFileSync(bat, ['@echo off', 'chcp 65001 >nul', ...cmds, 'exit /b 0'].join('\r\n'), 'utf8');
  await new Promise((resolve) => { execFile('cmd.exe', ['/c', bat], { windowsHide: true }, () => { try { fs.unlinkSync(bat); } catch {} resolve(); }); });
  const ps = `Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, IntPtr pvParam, uint fWinIni);' -Name N -Namespace W -ErrorAction SilentlyContinue; [W.N]::SystemParametersInfo(0x0057, 0, [IntPtr]::Zero, 0x03) | Out-Null`;
  await new Promise((resolve) => { execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', ps], { windowsHide: true }, () => resolve()); });
}

async function cursorUninstallAll(names, defaults) {
  try {
    const removed = [], failed = [], skipped = [];
    await resetCursorsToDefault(defaults);
    for (const name of (names || [])) {
      const dirPath = path.join(CURSORS_DIR, name);
      if (!fs.existsSync(dirPath)) { skipped.push(name); const archivePath = path.join(getCursorsCacheDir(), `${name}.7z`); if (fs.existsSync(archivePath)) try { fs.unlinkSync(archivePath); } catch {} continue; }
      await new Promise((resolve) => {
        const ps = `Remove-Item -LiteralPath '${dirPath.replace(/'/g, "''")}' -Recurse -Force -ErrorAction SilentlyContinue`;
        execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', ps], { windowsHide: true }, () => resolve());
      });
      if (fs.existsSync(dirPath)) failed.push(name); else removed.push(name);
      const archivePath = path.join(getCursorsCacheDir(), `${name}.7z`);
      if (fs.existsSync(archivePath)) try { fs.unlinkSync(archivePath); } catch {}
    }
    return { ok: true, removed, failed, skipped };
  } catch (e) { return { ok: false, error: e.message }; }
}

function registerIpc() {
  ipcMain.handle('config:get',    (_e, key, fallback) => config.get(key, fallback));
  ipcMain.handle('config:set',    (_e, key, value)    => { config.set(key, value); });
  ipcMain.handle('config:getAll', ()                  => config.getAll());
  ipcMain.handle('config:reset',  ()                  => { config.reset(); });

  ipcMain.handle('logger:info',  (_e, msg) => logger.info(msg));
  ipcMain.handle('logger:warn',  (_e, msg) => logger.warn(msg));
  ipcMain.handle('logger:error', (_e, msg) => logger.error(msg));
  ipcMain.handle('logger:setEnabled', (_e, v) => { logger.setEnabled(!!v); logger.info(`logs_enabled → ${!!v}`); return true; });

  ipcMain.handle('tabs:data', () => loadTabsData(rootDir));

  ipcMain.handle('tabs:readJson', (_e, relPath) => {
    try {
      if (!relPath || typeof relPath !== 'string') return { ok: false, error: 'Пустой путь', data: null };
      const abs = path.resolve(rootDir, relPath); const rel = path.relative(rootDir, abs);
      if (rel.startsWith('..') || path.isAbsolute(rel)) return { ok: false, error: 'Недопустимый путь', data: null };
      if (!fs.existsSync(abs)) return { ok: false, error: 'Файл не найден: ' + relPath, data: null };
      const raw = fs.readFileSync(abs, 'utf8'); const data = JSON.parse(raw);
      return { ok: true, data, error: null };
    } catch (e) { return { ok: false, error: e.message || String(e), data: null }; }
  });

  ipcMain.handle('tabs:scanDir', (_e, relPath) => {
    try {
      if (!relPath || typeof relPath !== 'string') return { ok: false, error: 'Пустой путь', data: null };
      const abs = path.resolve(rootDir, relPath); const rel = path.relative(rootDir, abs);
      if (rel.startsWith('..') || path.isAbsolute(rel)) return { ok: false, error: 'Недопустимый путь', data: null };
      if (!fs.existsSync(abs) || !fs.statSync(abs).isDirectory()) return { ok: false, error: 'Папка не найдена: ' + relPath, data: null };
      const data = {};
      for (const entry of fs.readdirSync(abs, { withFileTypes: true })) {
        if (!entry.isDirectory()) continue;
        if (/^отмена$/i.test(entry.name)) continue;
        const sub = path.join(abs, entry.name);
        let files = [];
        try { files = fs.readdirSync(sub, { withFileTypes: true }).filter(e => e.isFile() && isTweakFile(e.name)).map(e => e.name).sort((a, b) => a.localeCompare(b, 'ru')); } catch {}
        if (files.length) data[entry.name] = files;
      }
      return { ok: true, data, error: null };
    } catch (e) { return { ok: false, error: e.message || String(e), data: null }; }
  });

  ipcMain.handle('apps:list', async () => {
    const psDir = path.join(rootDir, 'src', 'renderer', 'tabs'); const script = path.join(psDir, 'appx-list.ps1');
    if (!fs.existsSync(script)) return { ok: false, error: 'appx-list.ps1 not found', data: null };
    return await new Promise((resolve) => {
      execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', script], { windowsHide: true, cwd: psDir, maxBuffer: 16 * 1024 * 1024 }, (err, stdout) => {
        if (err) return resolve({ ok: false, error: err.message, data: null });
        resolve({ ok: true, raw: String(stdout || ''), data: null });
      });
    });
  });

  ipcMain.handle('apps:detect', async () => {
    const psDir = path.join(rootDir, 'src', 'renderer', 'tabs'); const script = path.join(psDir, 'appx-detect.ps1');
    if (!fs.existsSync(script)) return { ok: false, error: 'appx-detect.ps1 not found', data: null };
    return await new Promise((resolve) => {
      execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', script], { windowsHide: true, cwd: psDir, maxBuffer: 16 * 1024 * 1024 }, (err, stdout) => {
        if (err) return resolve({ ok: false, error: err.message, data: null });
        resolve({ ok: true, raw: String(stdout || ''), data: null });
      });
    });
  });

  ipcMain.handle('buildTabs:run', async (event, options = {}) => {
    const sender = event.sender; const scriptPath = path.join(rootDir, 'build_tabs.py');
    if (!fs.existsSync(scriptPath)) return { ok: false, error: 'build_tabs.py не найден в корне проекта' };
    const pythonCandidates = ['python', 'python3', 'py'];
    let pythonExe = null;
    for (const cand of pythonCandidates) {
      try { const r = spawnSync(cand, ['--version'], { windowsHide: true }); if (r.status === 0) { pythonExe = cand; break; } } catch {}
    }
    if (!pythonExe) return { ok: false, error: 'Python не найден в PATH' };
    const args = [scriptPath]; if (options.only) args.push('--only', options.only); if (options.dry) args.push('--dry');
    return await new Promise((resolve) => {
      let stdout = ''; let stderr = '';
      const child = spawn(pythonExe, args, { windowsHide: true, cwd: rootDir, env: { ...process.env, PYTHONIOENCODING: 'utf-8' } });
      const send = (type, chunk) => { if (sender.isDestroyed()) return; sender.send('buildTabs:chunk', { type, chunk: String(chunk) }); };
      child.stdout.on('data', (buf) => { const text = buf.toString('utf8'); stdout += text; send('out', text); });
      child.stderr.on('data', (buf) => { const text = buf.toString('utf8'); stderr += text; send('err', text); });
      child.on('error', (e) => { send('err', 'Ошибка запуска: ' + e.message + '\n'); resolve({ ok: false, error: e.message, stdout, stderr }); });
      child.on('close', (code) => resolve({ ok: code === 0, code, stdout, stderr }));
    });
  });

    /* ============================================================
     Универсальный запуск build-скриптов (Python)
     ============================================================ */
  const ALLOWED_BUILD_SCRIPTS = [
    'build_tabs.py',
    'build_full_tabs.py',
    'build_hardening_json.py',
    'build_apps_json.py',
    'build_drivers_json.py',
    'build_removal_json.py',
    'build_all_tabs.py',
    'audit_tweaks.py'
  ];

  ipcMain.handle('buildTools:list', () => {
    const meta = [
      { id: 'build_all_tabs',  name: 'build_all_tabs.py',        icon: '🚀',
        desc: 'Оркестратор. Запускает все скрипты ниже по очереди.',
        recommended: true },
      { id: 'build_tabs',      name: 'build_tabs.py',            icon: '📋',
        desc: 'tabs.json — сборки ОС-секций (Оптимизация, Электропитание, Кастомизация, …)' },
      { id: 'build_full_tabs', name: 'build_full_tabs.py',       icon: '📑',
        desc: 'tabs.json — твики оптимизации + планы электропитания + твики исправлений (без сборок)' },
      { id: 'build_hardening', name: 'build_hardening_json.py',  icon: '🛡',
        desc: 'Твики для секций Безопасность / Приватность / Удобство / Кастомизация / Электропитание / Оптимизация — по одному JSON на сборку' },
      { id: 'build_apps',      name: 'build_apps_json.py',       icon: '📱',
        desc: 'apps_optimization_tabs.json — твики Браузеры / Игры / Приложения' },
      { id: 'build_drivers',   name: 'build_drivers_json.py',    icon: '🎮',
        desc: 'drivers_tabs.json — NVIDIA / AMD / Intel / DirectX / OpenGL / Память / Звук / Клавиатура / Мышка / Hyper-V / Твики / Сеть' },
      { id: 'build_removal',   name: 'build_removal_json.py',    icon: '🗑',
        desc: 'removal_tabs.json — батники удаления (Defender, Edge, OneDrive, Office, UWP, …)' },
      { id: 'audit_tweaks',    name: 'audit_tweaks.py',          icon: '🔍',
        desc: 'Проверка целостности: все ли файлы из JSON на диске, нет ли «сирот»',
        audit: true }
    ];
    return meta.map(s => {
      const p = path.join(rootDir, s.name);
      return { ...s, exists: fs.existsSync(p) };
    });
  });

  ipcMain.handle('buildTools:run', async (event, scriptName, options = {}) => {
    const sender = event.sender;

    if (!ALLOWED_BUILD_SCRIPTS.includes(scriptName)) {
      return { ok: false, error: `Скрипт не разрешён: ${scriptName}` };
    }

    const scriptPath = path.join(rootDir, scriptName);
    if (!fs.existsSync(scriptPath)) {
      return { ok: false, error: `Скрипт не найден: ${scriptName}` };
    }

    let pythonExe = null;
    for (const cand of ['python', 'python3', 'py']) {
      try {
        const r = spawnSync(cand, ['--version'], { windowsHide: true });
        if (r.status === 0) { pythonExe = cand; break; }
      } catch { /* ignore */ }
    }
    if (!pythonExe) return { ok: false, error: 'Python не найден в PATH' };

    const args = [scriptPath];
    if (options.dry) args.push('--dry');
    if (Array.isArray(options.only)) {
      for (const o of options.only) args.push('--only', String(o));
    } else if (options.only) {
      args.push('--only', String(options.only));
    }
    if (Array.isArray(options.skip)) {
      for (const s of options.skip) args.push('--skip', String(s));
    }
    if (options.json) args.push('--json');

    logger.info(`[buildTools] ${scriptName} ${args.slice(1).join(' ')}`);

    return await new Promise((resolve) => {
      let stdout = '';
      let stderr = '';
      let child;
      try {
        child = spawn(pythonExe, args, {
          windowsHide: true,
          cwd: rootDir,
          env: { ...process.env, PYTHONIOENCODING: 'utf-8' }
        });
      } catch (e) {
        return resolve({ ok: false, error: e.message, stdout: '', stderr: '' });
      }

      const send = (type, chunk) => {
        if (sender.isDestroyed()) return;
        sender.send('buildTabs:chunk', { type, chunk: String(chunk) });
      };

      child.stdout?.on('data', (buf) => {
        const text = buf.toString('utf8');
        stdout += text;
        send('out', text);
      });
      child.stderr?.on('data', (buf) => {
        const text = buf.toString('utf8');
        stderr += text;
        send('err', text);
      });
      child.on('error', (e) => {
        send('err', 'Ошибка запуска: ' + e.message + '\n');
        resolve({ ok: false, error: e.message, stdout, stderr });
      });
      child.on('close', (code) => resolve({ ok: code === 0, code, stdout, stderr }));
    });
  });

  ipcMain.handle('buildTabs:pickPython', async () => {
    const res = await dialog.showOpenDialog(mainWindow, { title: 'Выберите python.exe', filters: [{ name: 'Python', extensions: ['exe'] }], properties: ['openFile'] });
    return res.canceled ? null : res.filePaths[0];
  });

  ipcMain.handle('tweaks:run',        (_e, relPath, options = {}) => tweakRunner.run(relPath, options));
  ipcMain.handle('tweaks:runCommand', (_e, cmd, options = {})     => tweakRunner.runCommand(cmd, options));
  ipcMain.handle('tweaks:runMany', async (_e, relPaths, options = {}) => {
    const results = [];
    for (const p of relPaths) {
      try { const r = await tweakRunner.run(p, options); results.push({ path: p, ok: true, result: r }); }
      catch (err) { results.push({ path: p, ok: false, error: String((err && err.message) || err) }); }
    }
    return results;
  });
  ipcMain.handle('tweaks:probe', (_e, relPath) => tweakRunner.probe(relPath));

  ipcMain.handle('tweaks:runStream', async (e, relPath, id) => {
    const sender = e.sender;
    return tweakRunner.runStream(relPath, (chunk) => { if (!sender.isDestroyed()) sender.send('tweaks:stream-data', { id, chunk }); }, (result) => { if (!sender.isDestroyed()) sender.send('tweaks:stream-end', { id, ...result }); });
  });
  ipcMain.handle('tweaks:runCommandStream', async (e, cmd, id) => {
    const sender = e.sender;
    return tweakRunner.runCommandStream(cmd, (chunk) => { if (!sender.isDestroyed()) sender.send('tweaks:stream-data', { id, chunk }); }, (result) => { if (!sender.isDestroyed()) sender.send('tweaks:stream-end', { id, ...result }); });
  });

  ipcMain.handle('tweaks:listDir', (_e, relPath) => {
    try { const abs = tweakRunner.resolveSafe(relPath); if (!fs.existsSync(abs) || !fs.statSync(abs).isDirectory()) return []; return fs.readdirSync(abs, { withFileTypes: true }).filter(e => e.isFile() && !isTempPatchName(e.name)).map(e => e.name); } catch { return []; }
  });
  ipcMain.handle('tweaks:listDirs', (_e, relPaths) => {
    const result = {}; if (!Array.isArray(relPaths)) return result;
    for (const rel of relPaths) {
      try { const abs = tweakRunner.resolveSafe(rel); if (!fs.existsSync(abs) || !fs.statSync(abs).isDirectory()) { result[rel] = []; continue; } result[rel] = fs.readdirSync(abs, { withFileTypes: true }).filter(e => e.isFile() && !isTempPatchName(e.name)).map(e => e.name); } catch { result[rel] = []; }
    }
    return result;
  });
  ipcMain.handle('tweaks:listDirRecursive', (_e, relPath) => {
    const results = [];
    try {
      const base = tweakRunner.resolveSafe(relPath); if (!fs.existsSync(base) || !fs.statSync(base).isDirectory()) return results;
      const walk = (dir, rel) => { const entries = fs.readdirSync(dir, { withFileTypes: true }); for (const e of entries) { const full = path.join(dir, e.name); const relChild = rel ? `${rel}/${e.name}` : e.name; if (e.isDirectory()) walk(full, relChild); else if (e.isFile() && !isTempPatchName(e.name)) results.push(relChild); } };
      walk(base, '');
    } catch {}
    return results;
  });

  ipcMain.handle('tweaks:describe', (_e, relPath) => { if (!relPath) return null; return findDescription(relPath); });
  ipcMain.handle('tweaks:describeMany', (_e, relPaths) => { const out = {}; if (!Array.isArray(relPaths)) return out; for (const rel of relPaths) out[rel] = findDescription(rel); return out; });

  ipcMain.handle('cursors:list', async (_e, force) => await cursorsListInfo(!!force));
  ipcMain.handle('cursors:download',     (_e, name)          => cursorDownload(name));
  ipcMain.handle('cursors:install',      (_e, name, roleHints) => cursorInstall(name, roleHints));
  ipcMain.handle('cursors:activate',     async (_e, name, roleHints) => { try { return await cursorActivate(name, roleHints); } catch (e) { return { ok: false, error: e.message }; } });
  ipcMain.handle('cursors:uninstall',    (_e, name)           => cursorUninstall(name));
  ipcMain.handle('cursors:uninstallAll', (_e, names, defaults) => cursorUninstallAll(names, defaults));
  ipcMain.handle('cursors:openFolder',   ()                   => shell.openPath(CURSORS_DIR));

  ipcMain.handle('security:audit', async (event, kind) => {
    const sender = event.sender;
    const FILES = { security: 'security-report.ps1', privacy: 'privacy-report.ps1', comfort: 'comfort-report.ps1' };
    const fileName = FILES[kind]; if (!fileName) return { ok: false, error: 'Неизвестный тип аудита: ' + kind };
    const psDir = path.join(rootDir, 'src', 'renderer', 'tabs', 'security'); const scriptPath = path.join(psDir, fileName);
    if (!fs.existsSync(scriptPath)) return { ok: false, error: 'Скрипт не найден: ' + scriptPath };
    return await new Promise((resolve) => {
      let stdout = ''; let stderr = ''; let child;
      try { child = spawn('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', scriptPath], { windowsHide: true, cwd: psDir }); }
      catch (e) { return resolve({ ok: false, error: 'spawn failed: ' + e.message }); }
      const send = (type, chunk) => { if (sender.isDestroyed()) return; sender.send('security:audit-chunk', { kind, type, chunk: String(chunk) }); };
      child.stdout.on('data', (buf) => { const text = buf.toString('utf8'); stdout += text; send('out', text); });
      child.stderr.on('data', (buf) => { const text = buf.toString('utf8'); stderr += text; send('err', text); });
      child.on('error', (e) => { send('err', 'Ошибка запуска PowerShell: ' + e.message + '\n'); resolve({ ok: false, error: e.message, stdout, stderr }); });
      child.on('close', (code) => {
        const parsed = parseJsonLoose(stdout);
        if (!parsed) return resolve({ ok: false, error: 'Не удалось распарсить JSON (код ' + code + ')', stdout, stderr });
        resolve({ ok: true, data: parsed, stdout, stderr, code });
      });
    });
  });

  // === СТАТУС И УПРАВЛЕНИЕ WINDOWS FIREWALL ===
  ipcMain.handle('security:firewallStatus', async () => {
    return new Promise((resolve) => {
      const ps = `
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
try {
  $profiles = Get-NetFirewallProfile -ErrorAction Stop | Select-Object Name, Enabled
  $allEnabled = ($profiles | Where-Object { $_.Enabled }).Count -eq $profiles.Count
  $noneEnabled = ($profiles | Where-Object { -not $_.Enabled }).Count -eq $profiles.Count
  $overall = if ($allEnabled) { 'all' } elseif ($noneEnabled) { 'none' } else { 'partial' }
  $result = @{
    profiles = @($profiles | ForEach-Object { @{ name = $_.Name; enabled = [bool]$_.Enabled } })
    overallEnabled = $overall
  }
  Write-Output (ConvertTo-Json $result -Compress)
} catch {
  Write-Output ('{"error":"' + $_.Exception.Message.Replace('"','\\"') + '"}')
}
`;
      execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand', Buffer.from(ps, 'utf16le').toString('base64')], { windowsHide: true }, (err, stdout) => {
        if (err) return resolve({ profiles: [], overallEnabled: 'none', error: err.message });
        try {
          const s = String(stdout || '').replace(/^\uFEFF/, '').trim();
          if (!s) return resolve({ profiles: [], overallEnabled: 'none', error: 'Пустой ответ' });
          const data = JSON.parse(s);
          if (data.error) resolve({ profiles: [], overallEnabled: 'none', error: data.error });
          else resolve(data);
        } catch (e) {
          resolve({ profiles: [], overallEnabled: 'none', error: 'Ошибка парсинга: ' + e.message });
        }
      });
    });
  });

  ipcMain.handle('security:setFirewallStatus', async (_e, enabled) => {
    return new Promise((resolve) => {
      const action = enabled ? '$true' : '$false';
      const ps = `
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
try {
  Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled ${action} -ErrorAction Stop
  Write-Output 'OK'
} catch {
  Write-Output ('ERR:' + $_.Exception.Message)
}
`;
      execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand', Buffer.from(ps, 'utf16le').toString('base64')], { windowsHide: true }, (err, stdout, stderr) => {
        if (err) return resolve({ ok: false, error: err.message });
        const out = String(stdout || '').trim();
        if (out.includes('OK')) resolve({ ok: true });
        else resolve({ ok: false, error: out.replace(/^ERR:/, '') || 'Неизвестная ошибка' });
      });
    });
  });
  // ============================================

  ipcMain.handle('firewall:pickExe', async () => {
    const res = await dialog.showOpenDialog(mainWindow, { title: 'Выберите .exe для правила брандмауэра', filters: [{ name: 'Программы', extensions: ['exe'] }], properties: ['openFile'] });
    return res.canceled ? null : res.filePaths[0];
  });

  ipcMain.handle('firewall:list', async () => {
    return new Promise((resolve) => {
      const ps = `$ErrorActionPreference='SilentlyContinue'; [Console]::OutputEncoding=[System.Text.Encoding]::UTF8; $rules = Get-NetFirewallRule -Direction Outbound -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -like 'AV Allow:*' -or $_.DisplayName -like 'AV Block:*' }; $result = New-Object System.Collections.ArrayList; foreach ($r in $rules) { $app = ''; try { $app = ($r | Get-NetFirewallApplicationFilter).Program } catch {}; if ([string]::IsNullOrWhiteSpace($app)) { continue }; [void]$result.Add([PSCustomObject]@{ ruleName = $r.DisplayName; program = $app; enabled = [bool]$r.Enabled; action = [string]$r.Action }) }; $result | ConvertTo-Json -Compress -Depth 4`;
      execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand', Buffer.from(ps, 'utf16le').toString('base64')], { windowsHide: true, maxBuffer: 16 * 1024 * 1024 }, (err, stdout) => {
        if (err) return resolve([]);
        try {
          const s = String(stdout || '').replace(/^\uFEFF/, '').trim(); if (!s) return resolve([]);
          const parsed = JSON.parse(s); const arr = Array.isArray(parsed) ? parsed : [parsed];
          const map = new Map();
          for (const r of arr) {
            const prog = r.program; if (!prog) continue;
            if (!map.has(prog)) map.set(prog, { program: prog, name: path.basename(prog), state: 'none' });
            const e = map.get(prog);
            if (r.enabled === true) { if (/^AV Allow:/i.test(r.ruleName)) e.state = 'allow'; if (/^AV Block:/i.test(r.ruleName)) e.state = 'block'; }
          }
          const out = [...map.values()]; out.sort((a, b) => a.name.localeCompare(b.name, 'ru')); resolve(out);
        } catch { resolve([]); }
      });
    });
  });

  ipcMain.handle('firewall:add', async (_e, exePath, action) => { if (!exePath || !fs.existsSync(exePath)) return { ok: false, error: 'Файл не найден: ' + exePath }; return await applyFirewallRule(exePath, action); });
  ipcMain.handle('firewall:set', async (_e, exePath, action) => { if (!exePath) return { ok: false, error: 'Пустой путь' }; return await applyFirewallRule(exePath, action); });

  ipcMain.handle('firewall:remove', async (_e, exePath) => {
    if (!exePath) return { ok: false, error: 'Пустой путь' };
    const safe = String(exePath).replace(/'/g, "''");
    const ps = `$ErrorActionPreference='SilentlyContinue'; Get-NetFirewallRule -Direction Outbound -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -like 'AV Allow:*' -or $_.DisplayName -like 'AV Block:*' } | ForEach-Object { $app = ($_ | Get-NetFirewallApplicationFilter).Program; if ($app -eq '${safe}') { Remove-NetFirewallRule -DisplayName $_.DisplayName -ErrorAction SilentlyContinue } }; Write-Output 'OK'`;
    return new Promise((resolve) => {
      execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand', Buffer.from(ps, 'utf16le').toString('base64')], { windowsHide: true }, (err, stdout) => {
        if (err) return resolve({ ok: false, error: String(err.message).slice(0, 400) });
        resolve({ ok: String(stdout || '').includes('OK') });
      });
    });
  });

  function applyFirewallRule(exePath, action) {
    const base = path.basename(exePath); const act = action === 'allow' ? 'Allow' : 'Block';
    const ruleName = `AV ${act}: ${base}`;
    const safePath = String(exePath).replace(/'/g, "''"); const safeRule = ruleName.replace(/'/g, "''");
    const ps = `$ErrorActionPreference='Stop'; Get-NetFirewallRule -Direction Outbound -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -like 'AV Allow:*' -or $_.DisplayName -like 'AV Block:*' } | ForEach-Object { $app = ($_ | Get-NetFirewallApplicationFilter).Program; if ($app -eq '${safePath}') { Remove-NetFirewallRule -DisplayName $_.DisplayName -ErrorAction SilentlyContinue } }; New-NetFirewallRule -DisplayName '${safeRule}' -Direction Outbound -Program '${safePath}' -Action ${act} -Profile Any -Enabled True -ErrorAction Stop | Out-Null; if ('${act}' -eq 'Block') { Get-NetFirewallRule -Direction Outbound -Action Allow -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -notlike 'AV *' } | ForEach-Object { $app = ($_ | Get-NetFirewallApplicationFilter).Program; if ($app -eq '${safePath}') { Disable-NetFirewallRule -DisplayName $_.DisplayName -ErrorAction SilentlyContinue } } }; Write-Output 'OK'`;
    return new Promise((resolve) => {
      execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand', Buffer.from(ps, 'utf16le').toString('base64')], { windowsHide: true }, (err, stdout, stderr) => {
        if (err) return resolve({ ok: false, error: String(stderr || err.message).slice(0, 500) });
        const out = String(stdout || '').trim();
        if (out.includes('OK')) resolve({ ok: true, rule: ruleName, action: act }); else resolve({ ok: false, error: out || 'Неизвестная ошибка' });
      });
    });
  }

  ipcMain.handle('comfort:getState', async () => {
    const ps = `$ErrorActionPreference='SilentlyContinue'; [Console]::OutputEncoding=[System.Text.Encoding]::UTF8; function Get-Reg($path, $name) { $v = (Get-ItemProperty -Path $path -Name $name -ErrorAction SilentlyContinue).$name; return $v }; $defRT = $null; try { $defRT = (Get-MpComputerStatus).RealTimeProtectionEnabled } catch {}; $uac = Get-Reg 'HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System' 'EnableLUA'; $ss = Get-Reg 'HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\System' 'EnableSmartScreen'; $fw = $false; try { $fwOut = netsh advfirewall show allprofiles state 2>$null; $fw = ($fwOut -match 'ON') } catch {}; $wu = (Get-Service wuauserv -ErrorAction SilentlyContinue).Status; $result = [PSCustomObject]@{ defender = [bool]($defRT -is [bool] -and $defRT); uac = ($uac -eq 1); smartscreen= ($ss -eq 1); firewall = $fw; updates = ($wu -eq 'Running') }; $result | ConvertTo-Json -Compress`;
    return new Promise((resolve) => {
      execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand', Buffer.from(ps, 'utf16le').toString('base64')], { windowsHide: true }, (err, stdout) => {
        if (err) return resolve(null);
        try { const s = String(stdout || '').replace(/^\uFEFF/, '').trim(); if (!s) return resolve(null); resolve(JSON.parse(s)); } catch { resolve(null); }
      });
    });
  });

  ipcMain.handle('comfort:setItem', async (_e, item, enabled) => {
    const on = !!enabled;
    const scripts = {
      defender: on ? `Set-MpPreference -DisableRealtimeMonitoring $false -ErrorAction SilentlyContinue; Write-Output 'OK'` : `Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue; Write-Output 'OK'`,
      uac: on ? `Set-ItemProperty -Path 'HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System' -Name EnableLUA -Value 1 -Type DWord -Force; Write-Output 'OK'` : `Set-ItemProperty -Path 'HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System' -Name EnableLUA -Value 0 -Type DWord -Force; Write-Output 'OK'`,
      smartscreen: on ? `New-Item -Path 'HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\System' -Force | Out-Null; Set-ItemProperty -Path 'HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\System' -Name EnableSmartScreen -Value 1 -Type DWord -Force; Write-Output 'OK'` : `New-Item -Path 'HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\System' -Force | Out-Null; Set-ItemProperty -Path 'HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\System' -Name EnableSmartScreen -Value 0 -Type DWord -Force; Write-Output 'OK'`,
      firewall: on ? `netsh advfirewall set allprofiles state on; Write-Output 'OK'` : `netsh advfirewall set allprofiles state off; Write-Output 'OK'`,
      updates: on ? `Set-Service wuauserv -StartupType Manual -ErrorAction SilentlyContinue; Start-Service wuauserv -ErrorAction SilentlyContinue; Write-Output 'OK'` : `Stop-Service wuauserv -Force -ErrorAction SilentlyContinue; Set-Service wuauserv -StartupType Disabled -ErrorAction SilentlyContinue; Write-Output 'OK'`
    };
    const ps = scripts[item]; if (!ps) return { ok: false, error: 'Неизвестный пункт: ' + item };
    return new Promise((resolve) => {
      execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand', Buffer.from(ps, 'utf16le').toString('base64')], { windowsHide: true }, (err, stdout, stderr) => {
        if (err) return resolve({ ok: false, error: String(stderr || err.message) });
        resolve({ ok: String(stdout || '').includes('OK') });
      });
    });
  });

  ipcMain.handle('netmon:snapshot', async () => {
    const ps = `$ErrorActionPreference='SilentlyContinue'; [Console]::OutputEncoding=[System.Text.Encoding]::UTF8; $conns = Get-NetTCPConnection -State Established -ErrorAction SilentlyContinue; $result = New-Object System.Collections.ArrayList; foreach ($c in $conns) { $procName = ''; try { $procName = (Get-Process -Id $c.OwningProcess -ErrorAction SilentlyContinue).ProcessName } catch {}; [void]$result.Add([PSCustomObject]@{ localPort = $c.LocalPort; remoteIp = $c.RemoteAddress; remotePort = $c.RemotePort; state = [string]$c.State; pid = $c.OwningProcess; process = $procName }) }; $result | ConvertTo-Json -Compress -Depth 4`;
    return new Promise((resolve) => {
      execFile('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand', Buffer.from(ps, 'utf16le').toString('base64')], { windowsHide: true, maxBuffer: 16 * 1024 * 1024 }, (err, stdout) => {
        if (err) return resolve([]);
        try {
          const s = String(stdout || '').replace(/^\uFEFF/, '').trim(); if (!s) return resolve([]);
          const parsed = JSON.parse(s); const arr = Array.isArray(parsed) ? parsed : [parsed];
          const map = new Map();
          for (const c of arr) {
            const ip = c.remoteIp || '?'; if (ip === '127.0.0.1' || ip === '::1') continue;
            if (!map.has(ip)) map.set(ip, { ip, port: c.remotePort, connections: 0, processes: new Set() });
            const e = map.get(ip); e.connections++; if (c.process) e.processes.add(c.process);
          }
          const out = [...map.values()].map(x => ({ ip: x.ip, port: x.port, connections: x.connections, processes: [...x.processes].slice(0, 4) }));
          out.sort((a, b) => b.connections - a.connections); resolve(out.slice(0, 100));
        } catch { resolve([]); }
      });
    });
  });

  ipcMain.handle('netmon:ports', async () => {
    const ps = `
$ErrorActionPreference='SilentlyContinue'
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
$ports = Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue
$result = New-Object System.Collections.ArrayList
foreach ($p in $ports) {
  $procName = ''
  try { $procName = (Get-Process -Id $p.OwningProcess -ErrorAction SilentlyContinue).ProcessName } catch {}
  [void]$result.Add([PSCustomObject]@{
    localPort = $p.LocalPort
    localIp   = $p.LocalAddress
    process   = $procName
    pid       = $p.OwningProcess
  })
}
$result | ConvertTo-Json -Compress -Depth 4
`;
    return new Promise((resolve) => {
      execFile('powershell.exe',
        ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand',
          Buffer.from(ps, 'utf16le').toString('base64')],
        { windowsHide: true, maxBuffer: 16 * 1024 * 1024 },
        (err, stdout) => {
          if (err) return resolve([]);
          try {
            const s = String(stdout || '').replace(/^\uFEFF/, '').trim();
            if (!s) return resolve([]);
            const parsed = JSON.parse(s);
            const arr = Array.isArray(parsed) ? parsed : [parsed];
            const out = arr.map(x => ({
              port: x.localPort,
              ip: x.localIp,
              process: x.process,
              pid: x.pid
            })).filter(x => x.port > 0);
            out.sort((a, b) => a.port - b.port);
            resolve(out);
          } catch { resolve([]); }
        });
    });
  });

  const ipApiCache = new Map();
  ipcMain.handle('netmon:resolveHost', async (_e, ip, mode) => {
    if (mode === 'none') return null;
    const cacheKey = `${ip}_${mode}`;
    if (ipApiCache.has(cacheKey)) return ipApiCache.get(cacheKey);
    let result = null;
    const ptr = await new Promise((resolve) => {
      dns.reverse(ip, (err, hostnames) => {
        if (err || !hostnames || !hostnames.length) resolve(null);
        else resolve(hostnames[0]);
      });
    });

    if (mode === 'ptr') {
      result = ptr;
    } else if (mode === 'brand') {
      if (ptr) {
        const lower = ptr.toLowerCase();
        if (lower.includes('1e100.net'))               result = `Google / YouTube (${ptr})`;
        else if (lower.includes('googleusercontent'))  result = `Google (Контент) (${ptr})`;
        else if (lower.includes('cloudfront.net'))     result = `Amazon CloudFront (${ptr})`;
        else if (lower.includes('akamai'))             result = `Akamai CDN (${ptr})`;
        else if (lower.includes('fastly'))             result = `Fastly CDN (${ptr})`;
        else if (lower.includes('discord'))            result = `Discord (${ptr})`;
        else if (lower.includes('cloudflare'))         result = `Cloudflare (${ptr})`;
        else if (lower.includes('microsoft'))          result = `Microsoft (${ptr})`;
        else if (lower.includes('amazonaws'))          result = `AWS (${ptr})`;
        else if (lower.includes('hetzner'))            result = `Hetzner (${ptr})`;
        else if (lower.includes('digitalocean'))       result = `DigitalOcean (${ptr})`;
        else result = ptr;
      }
      if (!result) {
        try {
          const res = await new Promise((resolve) => {
            const req = https.get(`https://ip-api.com/json/${ip}?fields=status,isp,org,as`, { timeout: 3000 }, (r) => {
              let data = '';
              r.on('data', chunk => data += chunk);
              r.on('end', () => {
                try { resolve(JSON.parse(data)); } catch { resolve(null); }
              });
            });
            req.on('error', () => resolve(null));
            req.on('timeout', () => { req.destroy(); resolve(null); });
          });
          if (res && res.status === 'success') {
            const name = res.org || res.isp || res.as;
            if (name) {
              if (name.includes('Telegram')) result = 'Telegram Messenger Inc.';
              else if (name.includes('Amazon'))   result = 'Amazon AWS';
              else if (name.includes('Google'))   result = 'Google';
              else if (name.includes('Microsoft'))result = 'Microsoft';
              else if (name.includes('Discord'))  result = 'Discord';
              else result = name;
            }
          }
        } catch { /* ignore */ }
      }
    }
    ipApiCache.set(cacheKey, result);
    return result;
  });

  ipcMain.handle('startup:list', (_e, force) => { try { return startupManager.list(!!force); } catch (e) { return { folders: { user: [], common: [] }, registry: [], tasks: [], services: [], counts: { folders: 0, registry: 0, tasks: 0, services: 0 }, error: e.message }; } });
  ipcMain.handle('startup:describe', (_e, id) => { try { return startupManager.describe(id); } catch { return null; } });
  ipcMain.handle('startup:enable', async (_e, id) => { try { return await startupManager.enable(id); } catch (e) { return { ok: false, error: e.message }; } });
  ipcMain.handle('startup:disable', async (_e, id) => { try { return await startupManager.disable(id); } catch (e) { return { ok: false, error: e.message }; } });
  ipcMain.handle('startup:delete', async (_e, id) => { try { return await startupManager.delete(id); } catch (e) { return { ok: false, error: e.message }; } });

  ipcMain.handle('shell:openExternal', (_e, url) => { try { const u = new URL(url); if (u.protocol !== 'https:' && u.protocol !== 'http:') return false; shell.openExternal(url); return true; } catch { return false; } });
  ipcMain.handle('shell:openPath', (_e, p) => shell.openPath(p));
  
  ipcMain.handle('shell:deleteFile', (_e, p) => {
    try {
      if (fs.existsSync(p)) fs.unlinkSync(p);
      return true;
    } catch { return false; }
  });

  ipcMain.handle('shell:saveHtmlReport', async (_e, htmlContent, defaultName) => {
    const res = await dialog.showSaveDialog(mainWindow, {
      title: 'Сохранить отчет',
      defaultPath: defaultName || 'report.html',
      filters: [{ name: 'HTML', extensions: ['html'] }]
    });
    if (res.canceled || !res.filePath) return { ok: false, canceled: true };
    try {
      fs.writeFileSync(res.filePath, htmlContent, 'utf8');
      shell.openPath(res.filePath);
      return { ok: true, path: res.filePath };
    } catch (err) {
      return { ok: false, error: err.message };
    }
  });

  ipcMain.handle('dialog:pickFile', async (_e, opts) => { const res = await dialog.showOpenDialog(mainWindow, opts || {}); return res.canceled ? null : res.filePaths[0]; });
  ipcMain.handle('dialog:pickFiles', async (_e, opts) => { const res = await dialog.showOpenDialog(mainWindow, opts || {}); return res.canceled ? [] : res.filePaths; });
  ipcMain.handle('dialog:pickFolder', async (_e, opts) => { const res = await dialog.showOpenDialog(mainWindow, { ...(opts || {}), properties: ['openDirectory', 'createDirectory'] }); return res.canceled ? null : res.filePaths[0]; });

  ipcMain.handle('window:minimize', () => { if (mainWindow && !mainWindow.isDestroyed()) mainWindow.minimize(); });
  ipcMain.handle('window:maximize', () => { if (!mainWindow || mainWindow.isDestroyed()) return false; if (mainWindow.isMaximized()) mainWindow.unmaximize(); else mainWindow.maximize(); return mainWindow.isMaximized(); });
  ipcMain.handle('window:isMaximized', () => !!(mainWindow && !mainWindow.isDestroyed() && mainWindow.isMaximized()));
  ipcMain.handle('window:toggleFullscreen', () => { if (!mainWindow || mainWindow.isDestroyed()) return false; const cur = mainWindow.isFullScreen(); const next = !cur; try { mainWindow.setFullScreen(next); config.set('Window.fullscreen', next); return next; } catch { return false; } });
  ipcMain.handle('window:close', () => { if (mainWindow && !mainWindow.isDestroyed()) mainWindow.close(); });
  ipcMain.handle('window:setBackgroundMaterial', (_e, material) => { if (!mainWindow || mainWindow.isDestroyed()) return false; try { if (typeof mainWindow.setBackgroundMaterial === 'function') { mainWindow.setBackgroundMaterial(material || 'none'); return true; } return false; } catch { return false; } });

  ipcMain.handle('app:version',      () => app.getVersion());
  ipcMain.handle('app:userDataPath', () => config.dir);
  ipcMain.handle('app:rootDir',      () => rootDir);
  ipcMain.handle('app:portableDir',  () => PORTABLE_DATA_DIR);
  ipcMain.handle('app:isAdmin',      () => isRunningAsAdmin());
  ipcMain.handle('app:username', () => { try { return os.userInfo().username || 'user'; } catch { return 'user'; } });
  ipcMain.handle('app:icon', () => {
    const candidates = [path.join(rootDir, 'assets', 'icon.png'), path.join(app.getAppPath(), 'assets', 'icon.png'), path.join(process.resourcesPath || '', 'assets', 'icon.png'), path.join(__dirname, 'assets', 'icon.png')];
    for (const p of candidates) { try { if (p && fs.existsSync(p)) return p; } catch {} } return null;
  });
  ipcMain.handle('hardware:stats', async () => { try { return await collectHardwareStats(); } catch { return null; } });

  ipcMain.handle('background:save', async (_e, srcPath) => {
    try {
      if (!srcPath || !fs.existsSync(srcPath)) return null; if (!IMAGE_EXT_RE.test(srcPath)) return null;
      const bgDir = path.join(config.dir, 'backgrounds'); fs.mkdirSync(bgDir, { recursive: true });
      try { for (const f of fs.readdirSync(bgDir)) fs.unlinkSync(path.join(bgDir, f)); } catch {}
      const ext = (path.extname(srcPath).toLowerCase() || '.png'); const dest = path.join(bgDir, 'background' + ext);
      fs.copyFileSync(srcPath, dest); return dest;
    } catch { return null; }
  });
  ipcMain.handle('background:clear', () => { try { const bgDir = path.join(config.dir, 'backgrounds'); if (fs.existsSync(bgDir)) { for (const f of fs.readdirSync(bgDir)) fs.unlinkSync(path.join(bgDir, f)); } return true; } catch { return false; } });
  ipcMain.handle('background:get', () => { try { const bgDir = path.join(config.dir, 'backgrounds'); if (!fs.existsSync(bgDir)) return null; const files = fs.readdirSync(bgDir); return files.length ? path.join(bgDir, files[0]) : null; } catch { return null; } });
  ipcMain.handle('background:default', () => {
    const tryPaths = [path.join(rootDir, 'assets', 'background.png'), path.join(app.getAppPath(), 'assets', 'background.png'), path.join(process.resourcesPath || '', 'assets', 'background.png'), path.join(__dirname, 'assets', 'background.png')];
    for (const p of tryPaths) { try { if (p && fs.existsSync(p)) return p; } catch {} } return null;
  });

  ipcMain.handle('wallpapers:list', () => { const bundled = listImagesIn(wallpapersBundledDir(), 'bundled'); const user = listImagesIn(ensureWallpapersDir(), 'user'); return { bundled, user, userDir: wallpapersUserDir() }; });
  ipcMain.handle('wallpapers:addFromFile', async (_e, srcPath) => {
    try {
      if (!srcPath || !fs.existsSync(srcPath)) return null; if (!IMAGE_EXT_RE.test(srcPath)) return null;
      const dir = ensureWallpapersDir(); const base = path.basename(srcPath); let dest = path.join(dir, base); let i = 1;
      while (fs.existsSync(dest)) { const ext = path.extname(base); const stem = path.basename(base, ext); dest = path.join(dir, `${stem}_${i++}${ext}`); }
      fs.copyFileSync(srcPath, dest); return dest;
    } catch { return null; }
  });
  ipcMain.handle('wallpapers:addFromUrl', async (_e, url, nameHint) => {
    try {
      const dir = ensureWallpapersDir();
      const guessedExt = (() => { try { const u = new URL(url); const m = /\.(png|jpe?g|bmp|webp|gif)$/i.exec(u.pathname); return m ? m[0] : '.jpg'; } catch { return '.jpg'; } })();
      const safe = String(nameHint || 'wallpaper').replace(/[^a-zA-Z0-9_.-]/g, '_').slice(0, 60); const stem = safe.replace(/\.[^.]+$/, '');
      let dest = path.join(dir, stem + guessedExt); let i = 1;
      while (fs.existsSync(dest)) dest = path.join(dir, `${stem}_${i++}${guessedExt}`);
      await downloadToFile(url, dest); return dest;
    } catch { return null; }
  });
  ipcMain.handle('wallpapers:remove', async (_e, fullPath) => {
    try {
      if (!fullPath) return false; const dir = path.resolve(wallpapersUserDir()); const abs = path.resolve(fullPath);
      if (!abs.startsWith(dir)) return false; if (fs.existsSync(abs)) fs.unlinkSync(abs); return true;
    } catch { return false; }
  });
  ipcMain.handle('wallpapers:openFolder', () => { const dir = ensureWallpapersDir(); shell.openPath(dir); return dir; });
}