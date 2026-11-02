const fs = require('fs');
const path = require('path');
const os = require('os');
const { execFile } = require('child_process');
const { app } = require('electron');

/* ============================================================
   МОДУЛЬ «АВТОЗАГРУЗКА»
   ============================================================ */

const DISABLED_SUFFIX = '.disabled';
const LEGACY_DISABLED_SUBFOLDER = '_disabled';

/* ------------------------------------------------------------
   КРИТИЧНЫЕ СЛУЖБЫ (ядро Windows) — не показываем вообще
   ------------------------------------------------------------ */
const CRITICAL_SERVICES = new Set([
  'rpcss', 'rpcrt4', 'dcomlaunch', 'lsm', 'plugplay', 'power', 'profsvc',
  'brokerinfrastructure', 'systemeventsbroker', 'themes', 'winmgmt',
  'samss', 'seclogon', 'lmhsvc', 'cryptsvc', 'keyiso', 'ngcksvc',
  'certpropsvc', 'policyagent', 'gpsvc',
  'eventlog', 'diagsvc',
  'disk', 'partmgr', 'volsnap', 'storahci', 'storufs', 'storvsc', 'ufx01000',
  'nsi', 'netman', 'nlasvc', 'netprofm',
  'coremessaging', 'dusmsvc', 'dsmsvc', 'wcmvcsvc',
  'staterepository', 'appxsvc', 'clipsvc', 'tokenbroker',
  'usermgr', 'userdatasvc',
  'trustedinstaller', 'msiserver'
].map(s => s.toLowerCase()));

/* ------------------------------------------------------------
   Категория «Антивирус» — по имени/пути
   ------------------------------------------------------------ */
const ANTIVIRUS_PATTERNS = [
  /defender/i, /msmpeng/i, /securityhealth/i, /windefend/i,
  /avast/i, /avg/i, /kaspersky/i, /eset/i, /norton/i,
  /bitdefender/i, /mcafee/i, /malwarebytes/i, /sophos/i,
  /trend\s?micro/i, /f-?secure/i, /comodo/i, /zonealarm/i,
  /360/i, /avira/i, /kavfs/i, /klif/i, /ekrn/i
];

/* ------------------------------------------------------------
   Категория «Телеметрия»
   ------------------------------------------------------------ */
const TELEMETRY_PATTERNS = [
  /diagtrack/i, /dmwappush/i, /autotimesvc/i,
  /telemetry/i, /diagnostic/i, /compattelrunner/i,
  /wdiservicehost/i, /wdisystemhost/i,
  /\bpca(svc)?\b/i
];

/* ------------------------------------------------------------
   Категория «Office»
   ------------------------------------------------------------ */
const OFFICE_PATTERNS = [
  /\boffice\b/i, /clicktorun/i, /osppsvc/i,
  /winword/i, /excel\.exe/i, /powerpnt/i, /outlook/i,
  /msoffice/i
];

/* ------------------------------------------------------------
   Категория «Edge»
   ------------------------------------------------------------ */
const EDGE_PATTERNS = [
  /\bedge\b/i, /msedge/i, /microsoftedge/i, /edgeupdate/i
];

/* ------------------------------------------------------------
   Категория «MS» — пользовательские программы Microsoft и прочих
   ------------------------------------------------------------ */
const MS_PROGRAM_PATTERNS = [
  /* Microsoft-экосистема */
  /onedrive/i,
  /teams/i,
  /\bxbox\b/i, /xboxgip/i, /xbl/i, /gaming\s?services/i,
  /windows\s?store/i, /winstore/i, /microsoft\.windowsstore/i,
  /cortana/i, /searchui/i,
  /your\s?phone/i, /phoneexperience/i, /crossdevice/i,
  /widgets/i, /widgetservice/i,
  /people/i, /peopleexperience/i,
  /skype/i,
  /mspaint/i,
  /notepad/i,
  /terminal/i, /windowsterminal/i,
  /snippingtool/i, /screenclip/i,
  /photos/i, /yourphotos/i,
  /camera/i, /windowscamera/i,
  /mail/i, /outlookforwindows/i,
  /calendar/i, /windowscommunicationsapps/i,
  /todo/i,
  /feedback/i, /feedbackhub/i,
  /maps/i, /windowsmaps/i,
  /weather/i, /bingweather/i,
  /news/i, /bingnews/i,
  /solitaire/i, /microsoftsolitaire/i,
  /mixedreality/i,
  /3d\s?viewer/i, /3dviewer/i,
  /windowssecurity/i, /windowsdefender/i,

  /* Сторонние популярные программы */
  /spotify/i, /itunes/i, /applemusic/i,
  /discord/i, /telegram/i, /slack/i, /zoom/i,
  /steam/i, /epic\s?games/i, /epic/i, /gog/i, /galaxyclient/i,
  /battle\.?net/i, /agent/i, /ubisoft/i, /uplay/i, /origin/i, /ea\s?app/i,
  /obs/i, /obs64/i, /streamlabs/i,
  /qbit/i, /qbittorrent/i, /utorrent/i, /transmission/i,
  /winrar/i, /7-?zip/i, /winzip/i,
  /vscode/i,
  /nvidiadisplay/i, /nvcontainer/i, /nvbackend/i, /nvidiawebhelper/i,
  /radeonsoftware/i, /radeonsettings/i, /amdrsserv/i, /atiesrxx/i,

  /* Браузеры (кроме Edge) */
  /chrome/i, /firefox/i, /opera/i, /brave/i, /vivaldi/i, /yandex/i
];

/* Явный белый список по имени службы */
const MS_SERVICE_NAMES = new Set([
  'onedrive', 'onedrivesetup',
  'teams', 'msteams',
  'xboxgipsvc', 'xblauthmanager', 'xblgamesave', 'xboxnetapisvc',
  'gamingservices', 'gamingservicesnet',
  'windowsstore', 'wsservice', 'installservice',
  'cortana', 'searchui',
  'yourphone', 'phoneexperiencehost', 'crossdeviceservice',
  'widgets', 'widgetservice', 'widgetsplatformruntime',
  'skypeapp', 'skypehost', 'skypebackgroundhost',
  'peopleexperiencehost', 'people',
  'windowsterminal', 'terminal',
  'snippingtool', 'screenclippinghost',
  'mspaint', 'paint',
  'notepad',
  'photos', 'yourphotos', 'windowscamera',
  'mail', 'outlookforwindows', 'calendar',
  'microsofttodos', 'todo',
  'feedbackhub', 'feedback',
  'windowsmaps', 'maps',
  'bingweather', 'weather',
  'bingnews', 'news',
  'microsoftsolitairecollection', 'solitaire',
  'mixedrealityportal', 'mixedreality',
  '3dviewer', 'view3d',
  'windowssecurity', 'windowsdefender',
  'spotify', 'itunes', 'applemusic',
  'discord', 'telegram', 'slack', 'zoom',
  'steam', 'epicgames', 'epic', 'gog', 'galaxyclient',
  'battle.net', 'agent', 'ubisoft', 'uplay', 'origin', 'eaapp',
  'obs', 'obs64', 'streamlabs',
  'qbit', 'qbittorrent', 'utorrent', 'transmission',
  'winrar', '7zip', 'winzip',
  'vscode', 'code',
  'nvidiadisplay', 'nvcontainer', 'nvbackend', 'nvidiawebhelper',
  'radeonsoftware', 'radeonsettings', 'amdrsserv', 'atiesrxx'
].map(s => s.toLowerCase()));

/* ------------------------------------------------------------
   КРИТИЧНЫЕ ЗАДАЧИ — не показываем вообще
   ------------------------------------------------------------ */
function isCriticalTask(taskPath, taskName) {
  const p = String(taskPath || '').toLowerCase();
  const n = String(taskName || '').toLowerCase();

  const forbidden = [
    'microsoft\\windows\\updateorchestrator',
    'microsoft\\windows\\windowsupdate',
    'microsoft\\windows\\defrag',
    'microsoft\\windows\\systemrestore',
    'microsoft\\windows\\servicing',
    'microsoft\\windows\\installservice',
    'microsoft\\windows\\appxdeploymentclient',
    'microsoft\\windows\\diskfootprint',
    'microsoft\\windows\\winsat',
    'microsoft\\windows\\wlan',
    'microsoft\\windows\\windows defender',
    'microsoft\\windows\\windowsdefender',
    'microsoft\\windows\\bitlocker',
    'microsoft\\windows\\netwtw',
    'microsoft\\windows\\certificate',
    'microsoft\\windows\\endpoint',
    'microsoft\\windows\\rms',
    'microsoft\\windows\\workplace',
    'microsoft\\windows\\push',
    'microsoft\\windows\\registry',
    'microsoft\\windows\\shared',
    'microsoft\\windows\\space',
    'microsoft\\windows\\maintenance',
    'microsoft\\windows\\task manager',
    'microsoft\\windows\\time',
    'microsoft\\windows\\logon',
    'microsoft\\windows\\plug',
    'microsoft\\windows\\power',
    'microsoft\\windows\\smb',
    'microsoft\\windows\\storage',
    'microsoft\\windows\\user profile',
    'microsoft\\windows\\wsman',
    'microsoft\\windows\\shell',
    'microsoft\\windows\\windows media',
    'microsoft\\windows\\windows error',
    'microsoft\\windows\\windows backup',
    'microsoft\\windows\\dusm',
    'microsoft\\windows\\device',
    'microsoft\\windows\\net',
    'microsoft\\windows\\customer',
    'microsoft\\windows\\disk',
    'microsoft\\windows\\firmware',
    'microsoft\\windows\\flighting',
    'microsoft\\windows\\hotpatch',
    'microsoft\\windows\\license',
    'microsoft\\windows\\location',
    'microsoft\\windows\\memory',
    'microsoft\\windows\\process',
    'microsoft\\windows\\recovery',
    'microsoft\\windows\\sms',
    'microsoft\\windows\\software',
    'microsoft\\windows\\tcp',
    'microsoft\\windows\\wired',
    'microsoft\\windows\\wsd'
  ];

  const full = p + n;
  for (const f of forbidden) if (full.includes(f)) return true;

  return false;
}

class StartupManager {
  constructor({ rootDir, config, logger }) {
    this.rootDir = rootDir;
    this.config = config;
    this.logger = logger;

    this.userStartupDir = path.join(
      process.env.APPDATA || path.join(os.homedir(), 'AppData', 'Roaming'),
      'Microsoft', 'Windows', 'Start Menu', 'Programs', 'Startup'
    );
    this.commonStartupDir = path.join(
      process.env.ProgramData || 'C:\\ProgramData',
      'Microsoft', 'Windows', 'Start Menu', 'Programs', 'Startup'
    );

    this._iconCache = new Map();
    this._lnkCache = new Map();

    /* Логирование при инициализации убрано, чтобы не спамить консоль. */
  }

  _log(m) {
    const line = `[startup] ${m}`;
    console.log(line);
    if (this.logger) this.logger.info(line);
  }

  _logErr(m) {
    const line = `[startup] ${m}`;
    console.error(line);
    if (this.logger) this.logger.error(line);
  }

  _mkId(type, payload) {
    const obj = { t: type, ...payload };
    return 'b64:' + Buffer.from(JSON.stringify(obj), 'utf8').toString('base64');
  }

  _parseId(id) {
    if (!id || typeof id !== 'string') return null;
    if (!id.startsWith('b64:')) return null;
    try {
      const json = Buffer.from(id.slice(4), 'base64').toString('utf8');
      const obj = JSON.parse(json);
      if (!obj || !obj.t) return null;
      return obj;
    } catch { return null; }
  }

  _ps(script, timeoutMs = 40000, label = 'ps') {
    return new Promise((resolve) => {
      const enc = Buffer.from(script, 'utf16le').toString('base64');
      const args = ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand', enc];

      let child = null;
      const timer = setTimeout(() => {
        try { if (child) child.kill(); } catch { /* ignore */ }
        resolve({ code: -1, out: '', err: 'timeout' });
      }, timeoutMs);

      try {
        child = execFile('powershell.exe', args,
          { windowsHide: true, maxBuffer: 32 * 1024 * 1024 },
          (err, stdout, stderr) => {
            clearTimeout(timer);
            const code = err ? (err.code || -1) : 0;
            this._log(`[${label}] exit=${code} outLen=${String(stdout||'').length}`);
            resolve({ code, out: String(stdout || ''), err: String(stderr || '') });
          });
      } catch (e) {
        clearTimeout(timer);
        resolve({ code: -1, out: '', err: e.message });
      }
    });
  }

  _parseJson(out, label = 'json') {
    const s = String(out || '').replace(/^\uFEFF/, '').trim();
    if (!s) return null;
    const start = s.search(/[\{\[]/);
    if (start < 0) return null;
    const end = Math.max(s.lastIndexOf('}'), s.lastIndexOf(']'));
    if (end <= start) return null;
    try { return JSON.parse(s.slice(start, end + 1)); }
    catch (e) { this._logErr(`[${label}] JSON parse failed: ${e.message}`); return null; }
  }

  /* ============================================================
     ИКОНКИ
     ============================================================ */
  async _iconFor(filePath) {
    if (!filePath) return null;
    let p = String(filePath).trim();
    p = p.replace(/^"+|"+$/g, '');

    if (p.toLowerCase().endsWith('.lnk')) {
      const target = await this._resolveLnk(p);
      if (target) p = target;
    }

    if (!path.isAbsolute(p)) return null;

    if (!fs.existsSync(p)) {
      const found = this._which(p);
      if (found) p = found;
      else return null;
    }

    if (this._iconCache.has(p)) return this._iconCache.get(p);

    try {
      const img = await app.getFileIcon(p, { size: 'normal' });
      if (!img || img.isEmpty()) {
        this._iconCache.set(p, null);
        return null;
      }
      const dataUrl = img.toDataURL();
      this._iconCache.set(p, dataUrl);
      return dataUrl;
    } catch (e) {
      this._logErr(`_iconFor("${p}"): ${e.message}`);
      this._iconCache.set(p, null);
      return null;
    }
  }

  _exeFromCommand(cmd) {
    if (!cmd) return null;
    const s = String(cmd).trim();
    if (!s) return null;

    let m = s.match(/^"([^"]+\.(exe|lnk|bat|cmd|ps1|com))"/i);
    if (m) return m[1];

    m = s.match(/^(.+?\.(exe|lnk|bat|cmd|ps1|com))(\s|$)/i);
    if (m) return m[1].trim();

    m = s.match(/^(.+\.(exe|lnk|bat|cmd|ps1|com))$/i);
    if (m) return m[1].trim();

    return null;
  }

  _which(name) {
    try {
      const r = require('child_process').spawnSync('where', [name], { encoding: 'utf8' });
      if (r.status === 0) {
        const line = String(r.stdout || '').split(/\r?\n/).find(Boolean);
        if (line) return line.trim();
      }
    } catch { /* ignore */ }
    return null;
  }

  async _resolveLnk(lnkPath) {
    if (this._lnkCache.has(lnkPath)) return this._lnkCache.get(lnkPath);
    const safe = lnkPath.replace(/'/g, "''");
    const r = await this._ps(`
$ErrorActionPreference = 'SilentlyContinue'
$s = (New-Object -ComObject WScript.Shell).CreateShortcut('${safe}')
if ($s.TargetPath) { Write-Output $s.TargetPath }
`, 6000, 'lnk');
    const target = String(r.out || '').trim().split(/\r?\n/)[0] || null;
    this._lnkCache.set(lnkPath, target);
    return target;
  }

  /* ============================================================
     КЛАССИФИКАЦИЯ
     ============================================================ */

  _isCriticalService(name) {
    return CRITICAL_SERVICES.has(String(name || '').toLowerCase());
  }

  _isCriticalTask(taskPath, taskName) {
    return isCriticalTask(taskPath, taskName);
  }

  _categorizeItem(item) {
    const hay = [
      item.name, item.displayName, item.command,
      item.value, item.path, item.taskPath, item.author
    ].filter(Boolean).join(' ');

    const h = String(hay).toLowerCase();

    if (h) {
      for (const re of ANTIVIRUS_PATTERNS) if (re.test(h)) return 'av';
      for (const re of TELEMETRY_PATTERNS) if (re.test(h)) return 'telemetry';
      for (const re of EDGE_PATTERNS)      if (re.test(h)) return 'edge';
      for (const re of OFFICE_PATTERNS)    if (re.test(h)) return 'office';
      for (const re of MS_PROGRAM_PATTERNS) if (re.test(h)) return 'ms';
    }

    if (item.type === 'service') {
      const n = String(item.name || '').toLowerCase();
      if (MS_SERVICE_NAMES.has(n)) return 'ms';
    }

    if (item.type === 'service' || item.type === 'task' ||
        item.type === 'registry' || item.type === 'folder') {
      const cmd = String(item.command || item.value || item.path || '').toLowerCase();
      if (cmd && !cmd.includes('\\windows\\') && /\.(exe|cmd|bat|ps1|com)/i.test(cmd)) {
        return 'ms';
      }
    }

    return null;
  }

  _classifyItem(item) {
    item.category = this._categorizeItem(item);
    item.safe = item.category !== null;

    if (item.type === 'service') {
      item.system = this._isCriticalService(item.name);
    } else if (item.type === 'task') {
      item.system = this._isCriticalTask(item.taskPath, item.taskName);
    } else {
      item.system = false;
    }

    return item;
  }

  _isIdSystem(p) {
    if (!p) return false;
    switch (p.t) {
      case 'service':  return this._isCriticalService(p.name);
      case 'task':     return this._isCriticalTask(p.taskPath, p.taskName);
      default:         return false;
    }
  }

  /* ============================================================
     СПИСОК
     ============================================================ */
  async list(_force = true) {
    this._log('list(): старт');

    const [folders, registry, tasks, services] = await Promise.all([
      this._listFolders(),
      this._listRegistry(),
      this._listTasks(),
      this._listServices()
    ]);

    const all = [
      ...folders.user, ...folders.common,
      ...registry, ...tasks, ...services
    ];
    for (const it of all) this._classifyItem(it);

    await Promise.all(all.map(x => this._attachIcon(x)));

    const result = {
      folders:   { user: folders.user, common: folders.common },
      registry,
      tasks,
      services,
      counts: {
        folders:  folders.user.length + folders.common.length,
        registry: registry.length,
        tasks:    tasks.length,
        services: services.length
      }
    };

    this._log(`list(): готово. folders=${result.counts.folders} registry=${registry.length} tasks=${tasks.length} services=${services.length}`);
    return result;
  }

  async _attachIcon(item) {
    let exePath = null;

    if (item.type === 'folder') {
      exePath = item.path;
    } else if (item.type === 'registry') {
      exePath = this._exeFromCommand(item.value || item.command || '');
    } else if (item.type === 'task') {
      exePath = this._exeFromCommand(item.command || '');
    } else if (item.type === 'service') {
      exePath = this._exeFromCommand(item.command || '');
    }

    if (!exePath) {
      exePath = this._exeFromCommand(item.name || '');
    }

    const icon = await this._iconFor(exePath);
    item.icon = icon;
    item.exePath = exePath || null;
    return item;
  }

  invalidate() {
    this._iconCache.clear();
    this._lnkCache.clear();
  }

  _listFolders() {
    const scan = (dir, scope) => {
      const out = [];
      if (!fs.existsSync(dir)) return out;

      try {
        for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
          if (e.name === LEGACY_DISABLED_SUBFOLDER) continue;
          if (e.name.toLowerCase() === 'desktop.ini') continue;

          const full = path.join(dir, e.name);
          const isDisabled = e.name.endsWith(DISABLED_SUFFIX);

          if (isDisabled) {
            const originalName = e.name.slice(0, -DISABLED_SUFFIX.length);
            out.push(this._mkFolderEntry(full, originalName, scope, false, e.isDirectory(), e.name, false));
          } else {
            out.push(this._mkFolderEntry(full, e.name, scope, true, e.isDirectory(), e.name, false));
          }
        }
      } catch (err) { this._logErr(`_listFolders [${scope}]: ${err.message}`); }

      const legacyDir = path.join(dir, LEGACY_DISABLED_SUBFOLDER);
      if (fs.existsSync(legacyDir)) {
        try {
          for (const e of fs.readdirSync(legacyDir, { withFileTypes: true })) {
            const full = path.join(legacyDir, e.name);
            out.push(this._mkFolderEntry(full, e.name, scope, false, e.isDirectory(), e.name, true));
          }
        } catch { /* ignore */ }
      }
      return out;
    };

    return {
      user:   scan(this.userStartupDir, 'user'),
      common: scan(this.commonStartupDir, 'system')
    };
  }

  _mkFolderEntry(fullPath, name, scope, enabled, isDir, actualFileName, legacy) {
    let sizeBytes = 0, mtime = 0;
    try {
      const st = fs.lstatSync(fullPath);
      sizeBytes = st.size;
      mtime = st.mtimeMs;
    } catch { /* ignore */ }

    return {
      id: this._mkId('folder', { scope, name }),
      type: 'folder',
      scope,
      name,
      actualFileName: actualFileName || name,
      path: fullPath,
      target: fullPath,
      args: '',
      enabled,
      legacy: !!legacy,
      isDir,
      sizeBytes,
      mtime,
      canToggle: true,
      canDelete: true,
      icon: null
    };
  }

  async _listRegistry() {
    const script = `
$ErrorActionPreference = 'SilentlyContinue'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$result = New-Object System.Collections.ArrayList
$keys = @(
  @{ Hive='HKCU'; Path='Software\\Microsoft\\Windows\\CurrentVersion\\Run';               Scope='user'   },
  @{ Hive='HKCU'; Path='Software\\Microsoft\\Windows\\CurrentVersion\\RunOnce';          Scope='user'   },
  @{ Hive='HKLM'; Path='Software\\Microsoft\\Windows\\CurrentVersion\\Run';               Scope='system' },
  @{ Hive='HKLM'; Path='Software\\Microsoft\\Windows\\CurrentVersion\\RunOnce';          Scope='system' },
  @{ Hive='HKLM'; Path='Software\\WOW6432Node\\Microsoft\\Windows\\CurrentVersion\\Run';      Scope='system' },
  @{ Hive='HKLM'; Path='Software\\WOW6432Node\\Microsoft\\Windows\\CurrentVersion\\RunOnce'; Scope='system' }
)
foreach ($k in $keys) {
  $full = "$($k.Hive):\\$($k.Path)"
  if (Test-Path $full) {
    $props = Get-ItemProperty -Path $full
    foreach ($p in $props.PSObject.Properties) {
      if ($p.Name -like 'PS*') { continue }
      if ($p.Name -eq '(default)') { continue }
      $val = [string]$p.Value
      if ([string]::IsNullOrWhiteSpace($val)) { continue }
      [void]$result.Add([PSCustomObject]@{
        hive=$k.Hive; path=$k.Path; scope=$k.Scope;
        name=$p.Name; value=$val; enabled=$true
      })
    }
  }
  $dis = "$($k.Hive):\\$($k.Path)_disabled"
  if (Test-Path $dis) {
    $props2 = Get-ItemProperty -Path $dis
    foreach ($p in $props2.PSObject.Properties) {
      if ($p.Name -like 'PS*') { continue }
      if ($p.Name -eq '(default)') { continue }
      $val = [string]$p.Value
      if ([string]::IsNullOrWhiteSpace($val)) { continue }
      [void]$result.Add([PSCustomObject]@{
        hive=$k.Hive; path=$k.Path; scope=$k.Scope;
        name=$p.Name; value=$val; enabled=$false
      })
    }
  }
}
$result | ConvertTo-Json -Compress -Depth 4
`;
    const r = await this._ps(script, 25000, 'reg-list');
    const parsed = this._parseJson(r.out, 'reg-list');
    const arr = Array.isArray(parsed) ? parsed : (parsed ? [parsed] : []);

    this._log(`_listRegistry: получено ${arr.length} записей (вкл+выкл)`);

    return arr.map(x => {
      const { command, args } = this._splitCommand(x.value || '');
      const enabled = x.enabled === true;
      return {
        id: this._mkId('registry', { hive: x.hive, keyPath: x.path, name: x.name }),
        type: 'registry',
        scope: x.scope,
        hive: x.hive,
        keyPath: x.path,
        fullKey: `${x.hive}:\\${x.path}`,
        name: x.name,
        value: x.value || '',
        command, args,
        enabled,
        canToggle: true,
        canDelete: true,
        icon: null
      };
    });
  }

  async _listTasks() {
    this._log('_listTasks: старт (через PowerShell Get-ScheduledTask)');
    const script = `
$ErrorActionPreference = 'SilentlyContinue'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$result = New-Object System.Collections.ArrayList
$tasks = Get-ScheduledTask
foreach ($t in $tasks) {
  $logonTrig = $t.Triggers | Where-Object {
    $_.CimClass.CimClassName -eq 'MSFT_TaskLogonTrigger' -or
    $_.CimClass.CimClassName -eq 'MSFT_TaskBootTrigger'
  }
  if (-not $logonTrig) { continue }

  $action = $t.Actions | Select-Object -First 1

  $stateStr = ''
  try { $stateStr = [string]$t.State } catch { $stateStr = '' }

  $settingsEnabled = $true
  try {
    if ($null -ne $t.Settings -and $null -ne $t.Settings.Enabled) {
      $settingsEnabled = [bool]$t.Settings.Enabled
    }
  } catch { $settingsEnabled = $true }

  [void]$result.Add([PSCustomObject]@{
    taskName        = $t.TaskName
    taskPath        = $t.TaskPath
    state           = $stateStr
    settingsEnabled = $settingsEnabled
    author          = [string]$t.Author
    exec            = [string]$action.Execute
    arguments       = [string]$action.Arguments
    workdir         = [string]$action.WorkingDirectory
  })
}
$result | ConvertTo-Json -Compress -Depth 4
`;
    const r = await this._ps(script, 45000, 'task-list');
    const parsed = this._parseJson(r.out, 'task-list');
    const arr = Array.isArray(parsed) ? parsed : (parsed ? [parsed] : []);

    this._log(`_listTasks: получено ${arr.length} задач`);

    return arr.map(x => {
      const stateLower = String(x.state || '').toLowerCase();
      const enabled = stateLower !== 'disabled' && x.settingsEnabled !== false;

      const taskPath = x.taskPath || '\\';
      const taskName = x.taskName || '';
      const critical = isCriticalTask(taskPath, taskName);

      return {
        id: this._mkId('task', { taskPath, taskName }),
        type: 'task',
        scope: 'system',
        name: taskName,
        taskPath,
        fullName: taskPath + taskName,
        state: x.state,
        author: x.author || '',
        command: x.exec || '',
        args: x.arguments || '',
        workdir: x.workdir || '',
        enabled,
        canToggle: !critical,
        canDelete: !critical,
        protected: critical,
        icon: null
      };
    });
  }

  async _listServices() {
    const script = `
$ErrorActionPreference = 'SilentlyContinue'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$result = New-Object System.Collections.ArrayList
$svcs = Get-CimInstance Win32_Service
foreach ($s in $svcs) {
  [void]$result.Add([PSCustomObject]@{
    name = $s.Name; displayName = $s.DisplayName
    state = $s.State; startMode = $s.StartMode
    pathName = $s.PathName; startName = $s.StartName
    description = $s.Description
  })
}
$result | ConvertTo-Json -Compress -Depth 4
`;
    const r = await this._ps(script, 45000, 'svc-list');
    const parsed = this._parseJson(r.out, 'svc-list');
    const arr = Array.isArray(parsed) ? parsed : (parsed ? [parsed] : []);

    return arr
      .filter(s => s && s.name && !this._isCriticalService(s.name))
      .filter(s => {
        const mode = String(s.startMode || '').toLowerCase();
        return mode === 'auto' || mode === 'manual' || mode === 'disabled';
      })
      .map(s => {
        const enabled = String(s.startMode).toLowerCase() !== 'disabled';
        const critical = this._isCriticalService(s.name);
        return {
          id: this._mkId('service', { name: s.name }),
          type: 'service',
          scope: 'system',
          name: s.name,
          displayName: s.displayName || s.name,
          state: s.state,
          startMode: s.startMode,
          command: s.pathName || '',
          startName: s.startName || '',
          description: s.description || '',
          enabled,
          canToggle: !critical,
          canDelete: false,
          protected: critical,
          icon: null
        };
      });
  }

  /* ============================================================
     ДЕЙСТВИЯ
     ============================================================ */
  async enable(id)  { return this._setEnabled(id, true);  }
  async disable(id) { return this._setEnabled(id, false); }
  async delete(id)  { return this._delete(id);            }

  async _setEnabled(id, enabled) {
    const p = this._parseId(id);
    if (!p) return { ok: false, error: 'Некорректный id' };

    if (this._isIdSystem(p)) {
      return { ok: false, error: 'Критичный компонент Windows защищён' };
    }

    this._log(`_setEnabled type=${p.t} enabled=${enabled}`);

    switch (p.t) {
      case 'folder':   return this._toggleFolder(p, enabled);
      case 'registry': return await this._toggleRegistry(p, enabled);
      case 'task':     return await this._toggleTask(p, enabled);
      case 'service':  return await this._toggleService(p, enabled);
      default:         return { ok: false, error: 'Неизвестный тип' };
    }
  }

  async _delete(id) {
    const p = this._parseId(id);
    if (!p) return { ok: false, error: 'Некорректный id' };

    if (this._isIdSystem(p)) {
      return { ok: false, error: 'Критичный компонент Windows защищён' };
    }

    this._log(`_delete type=${p.t}`);

    switch (p.t) {
      case 'folder':   return await this._deleteFolder(p);
      case 'registry': return await this._deleteRegistry(p);
      case 'task':     return await this._deleteTask(p);
      case 'service':  return { ok: false, error: 'Службы не удаляются' };
      default:         return { ok: false, error: 'Неизвестный тип' };
    }
  }

  _toggleFolder(p, enabled) {
    const { scope, name } = p;
    const baseDir = scope === 'user' ? this.userStartupDir : this.commonStartupDir;
    const legacyDir = path.join(baseDir, LEGACY_DISABLED_SUBFOLDER);

    const activePath   = path.join(baseDir, name);
    const disabledPath = path.join(baseDir, name + DISABLED_SUFFIX);
    const legacyPath   = path.join(legacyDir, name);

    try {
      if (enabled) {
        let src = null;
        if (fs.existsSync(disabledPath)) src = disabledPath;
        else if (fs.existsSync(legacyPath)) src = legacyPath;
        else return { ok: false, error: 'Отключённый файл не найден' };

        if (fs.existsSync(activePath)) return { ok: false, error: 'Активный файл уже существует' };

        fs.mkdirSync(path.dirname(activePath), { recursive: true });
        fs.renameSync(src, activePath);
        this._log(`_toggleFolder: ENABLE "${src}" → "${activePath}"`);
      } else {
        if (!fs.existsSync(activePath)) return { ok: false, error: 'Активный файл не найден' };
        if (fs.existsSync(disabledPath)) return { ok: false, error: 'Отключённый уже существует' };

        fs.mkdirSync(path.dirname(disabledPath), { recursive: true });
        fs.renameSync(activePath, disabledPath);
        this._log(`_toggleFolder: DISABLE "${activePath}" → "${disabledPath}"`);
      }
      return { ok: true };
    } catch (e) {
      this._logErr(`_toggleFolder: ${e.message}`);
      return { ok: false, error: e.message };
    }
  }

  async _deleteFolder(p) {
    const { scope, name } = p;
    const baseDir = scope === 'user' ? this.userStartupDir : this.commonStartupDir;
    const legacyDir = path.join(baseDir, LEGACY_DISABLED_SUBFOLDER);

    const candidates = [
      path.join(baseDir, name),
      path.join(baseDir, name + DISABLED_SUFFIX),
      path.join(legacyDir, name)
    ];

    let target = null;
    for (const c of candidates) if (fs.existsSync(c)) { target = c; break; }
    if (!target) return { ok: false, error: 'Файл не найден' };

    const safe = target.replace(/'/g, "''");
    await this._ps(`
$ErrorActionPreference = 'SilentlyContinue'
Add-Type -AssemblyName Microsoft.VisualBasic
try {
  [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile('${safe}','OnlyErrorDialogs','SendToRecycleBin')
  Write-Output 'OK'
} catch { Write-Output ('ERR:' + $_.Exception.Message) }
`, 15000, 'folder-delete');

    if (!fs.existsSync(target)) return { ok: true };

    try {
      if (fs.lstatSync(target).isDirectory()) fs.rmSync(target, { recursive: true, force: true });
      else fs.unlinkSync(target);
      return { ok: true };
    } catch (e) { return { ok: false, error: e.message }; }
  }

  async _toggleRegistry(p, enabled) {
    const { hive, keyPath, name } = p;
    const fullKey = `${hive}:\\${keyPath}`;
    const disKey  = `${hive}:\\${keyPath}_disabled`;

    this._log(`_toggleRegistry: ${hive}\\${keyPath}\\${name} → ${enabled ? 'ENABLE' : 'DISABLE'}`);

    const script = `
$ErrorActionPreference = 'SilentlyContinue'
$full = '${fullKey.replace(/'/g, "''")}'
$dis  = '${disKey.replace(/'/g, "''")}'
$name = '${name.replace(/'/g, "''")}'

if (-not (Test-Path $full)) { New-Item -Path $full -Force | Out-Null }

if ($${enabled ? 'true' : 'false'}) {
  $v = (Get-ItemProperty -Path $dis -Name $name -ErrorAction SilentlyContinue).$name
  if ($null -eq $v) { Write-Output 'ERR:disabled-not-found'; exit 1 }
  New-ItemProperty -Path $full -Name $name -Value $v -PropertyType String -Force | Out-Null
  Remove-ItemProperty -Path $dis -Name $name -Force -ErrorAction SilentlyContinue
} else {
  $v = (Get-ItemProperty -Path $full -Name $name -ErrorAction SilentlyContinue).$name
  if ($null -eq $v) { Write-Output 'ERR:active-not-found'; exit 1 }
  if (-not (Test-Path $dis)) { New-Item -Path $dis -Force | Out-Null }
  New-ItemProperty -Path $dis -Name $name -Value $v -PropertyType String -Force | Out-Null
  Remove-ItemProperty -Path $full -Name $name -Force -ErrorAction SilentlyContinue
}

$inActive = (Get-ItemProperty -Path $full -Name $name -ErrorAction SilentlyContinue).$name -ne $null
$inDis    = (Get-ItemProperty -Path $dis  -Name $name -ErrorAction SilentlyContinue).$name -ne $null
Write-Output ('RESULT:' + $inActive + '|' + $inDis)
`;
    const r = await this._ps(script, 12000, 'reg-toggle');
    const out = String(r.out || '').trim();

    this._log(`_toggleRegistry: PS out="${out}"`);

    const m = out.match(/RESULT:(\w+)\|(\w+)/);
    if (!m) {
      if (/ERR:/.test(out)) return { ok: false, error: out.replace(/^ERR:/, '') };
      return { ok: false, error: out || 'Ошибка реестра' };
    }

    const inActive = m[1].toLowerCase() === 'true';
    const inDisabled = m[2].toLowerCase() === 'true';
    const actuallyEnabled = inActive && !inDisabled;

    if (actuallyEnabled === enabled) {
      this._log(`_toggleRegistry: успех (inActive=${inActive} inDisabled=${inDisabled})`);
      return { ok: true };
    }

    return {
      ok: false,
      error: `Не удалось изменить (inActive=${inActive} inDisabled=${inDisabled})`
    };
  }

  async _deleteRegistry(p) {
    const { hive, keyPath, name } = p;
    const full = `${hive}:\\${keyPath}`;
    const dis  = `${hive}:\\${keyPath}_disabled`;

    await this._ps(`
$ErrorActionPreference = 'SilentlyContinue'
Remove-ItemProperty -Path '${full.replace(/'/g, "''")}' -Name '${name.replace(/'/g, "''")}' -Force
Remove-ItemProperty -Path '${dis.replace(/'/g, "''")}' -Name '${name.replace(/'/g, "''")}' -Force
`, 8000, 'reg-delete');
    return { ok: true };
  }

  async _toggleTask(p, enabled) {
    const { taskPath, taskName } = p;

    if (isCriticalTask(taskPath, taskName)) {
      return { ok: false, error: 'Критичная задача Windows защищена' };
    }

    const safeName = String(taskName).replace(/'/g, "''");
    const safePath = String(taskPath || '\\').replace(/'/g, "''");
    const cmd = enabled ? 'Enable-ScheduledTask' : 'Disable-ScheduledTask';

    this._log(`_toggleTask: "${(taskPath || '\\') + taskName}" → ${enabled ? 'ENABLE' : 'DISABLE'}`);

    const script = `
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
try {
  ${cmd} -TaskName '${safeName}' -TaskPath '${safePath}' -ErrorAction Stop | Out-Null
} catch {
  Write-Output ('ERR:' + $_.Exception.Message)
  exit 0
}
try {
  $t = Get-ScheduledTask -TaskName '${safeName}' -TaskPath '${safePath}' -ErrorAction Stop
  $st = ''; try { $st = [string]$t.State } catch { $st = '' }
  $se = $true
  try { if ($null -ne $t.Settings -and $null -ne $t.Settings.Enabled) { $se = [bool]$t.Settings.Enabled } } catch { $se = $true }
  Write-Output ('RESULT:' + $st + '|' + $se)
} catch {
  Write-Output ('ERR2:' + $_.Exception.Message)
}
`;
    const r = await this._ps(script, 15000, 'task-toggle');
    const out = String(r.out || '').trim();

    this._log(`_toggleTask: PS out="${out}"`);

    if (out.startsWith('ERR:')) {
      return { ok: false, error: out.slice(4).trim() };
    }

    const m = out.match(/RESULT:([^|]*)\|(\w+)/);
    if (!m) return { ok: false, error: out || 'Не удалось проверить состояние' };

    const stateAfter = m[1];
    const settingsAfter = m[2].toLowerCase() === 'true';
    const stateLower = stateAfter.toLowerCase();
    const actuallyEnabled = stateLower !== 'disabled' && settingsAfter;

    this._log(`_toggleTask: state="${stateAfter}" settings=${settingsAfter} → actuallyEnabled=${actuallyEnabled}`);

    if (actuallyEnabled === enabled) {
      return { ok: true, state: stateAfter };
    }

    return {
      ok: false,
      error: enabled ? `Не включилась (state="${stateAfter}")` : `Не отключилась (state="${stateAfter}")`
    };
  }

  async _deleteTask(p) {
    const { taskPath, taskName } = p;

    if (isCriticalTask(taskPath, taskName)) {
      return { ok: false, error: 'Критичная задача Windows защищена' };
    }

    const safeName = String(taskName).replace(/'/g, "''");
    const safePath = String(taskPath || '\\').replace(/'/g, "''");

    const script = `
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
try {
  Unregister-ScheduledTask -TaskName '${safeName}' -TaskPath '${safePath}' -Confirm:$false -ErrorAction Stop
  Write-Output 'OK'
} catch { Write-Output ('ERR:' + $_.Exception.Message) }
`;
    const r = await this._ps(script, 15000, 'task-delete');
    const out = String(r.out || '').trim();

    if (out.includes('OK')) return { ok: true };
    return { ok: false, error: out.replace(/^ERR:/, '').trim() || 'Ошибка удаления' };
  }

  async _toggleService(p, enabled) {
    const { name } = p;

    if (this._isCriticalService(name)) {
      return { ok: false, error: 'Критичная служба Windows защищена' };
    }

    const startVal = enabled ? 'auto' : 'disabled';
    const r = await this._runSc(['config', name, 'start=', startVal]);
    if (r.code !== 0) {
      return { ok: false, error: (r.err || r.out || `exit ${r.code}`).trim() };
    }

    if (enabled) await this._runSc(['start', name]);
    else         await this._runSc(['stop',  name]);

    return { ok: true };
  }

  _runSc(args) {
    return new Promise((resolve) => {
      execFile('sc.exe', args, { windowsHide: true }, (err, stdout, stderr) => {
        resolve({
          code: err ? (err.code || -1) : 0,
          out: String(stdout || ''),
          err: String(stderr || '')
        });
      });
    });
  }
  
  async describe() { return null; }

  _splitCommand(cmd) {
    const s = String(cmd || '').trim();
    if (!s) return { command: '', args: '' };
    const m = s.match(/^"([^"]+)"\s*(.*)$/);
    if (m) return { command: m[1], args: m[2] || '' };
    const sp = s.indexOf(' ');
    if (sp < 0) return { command: s, args: '' };
    return { command: s.slice(0, sp), args: s.slice(sp + 1) };
  }
}

module.exports = { StartupManager };