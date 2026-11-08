import { state, clearCheckboxes, toast, Sound } from '../app.js';
import { renderCheckboxGrid } from '../components/checkbox.js';
import { papirusUrl } from '../utils/icons.js';

const PS_DIR_REL = 'src/renderer/tabs';
const TWEAKS_BASE = 'src/renderer/tabs/';

/* ─── Категории компонентов ───────────────────────────────────────────
   Приоритетные — те, у которых много вариантов твиков (Defender, Edge,
   WebView2, OneDrive). Выносятся в ОТДЕЛЬНУЮ секцию в самом верху,
   чтобы карточки не «распирало» от кнопок и они помещались целиком.
   Остальные — в общей секции «📦 Программы Windows».
   ────────────────────────────────────────────────────────────────────── */
const PRIORITY_COMPONENT_KEYS = ['defender', 'edge', 'webview2', 'onedrive'];
const SECONDARY_COMPONENT_KEYS = [
  'notepad', 'internet_explorer', 'rdp', 'copilot',
  'microsoft_photos', 'microsoft_teams', 'mixed_reality_portal', 'wsl', 'xbox'
];

const COMPONENT_TWEAKS = {
  onedrive: [
    { id: 'soft', label: 'Мягкое', file: 'remove_apps/onedrive_optimizer.bat', desc: 'Быстрое удаление через официальный деинсталлятор.', danger: false },
    { id: 'full', label: 'Полное', file: 'remove_apps/onedrive_xos.bat', desc: 'Полное удаление: автозагрузка, ярлыки, задачи, политики.', danger: false, recommended: true },
    { id: 'hard', label: 'Хардкор', file: 'remove_apps/onedrive_hard.bat', desc: 'Максимально агрессивно: убивает Explorer, забирает владение.', warning: 'Explorer будет перезапущен.', danger: true },
    { id: 'clean', label: 'Зачистка следов', file: 'remove_apps/onedrive_cleanup.bat', desc: 'Удаляет остатки: пустые папки, ярлыки, кэш.', danger: false },
    { id: 'marty', label: 'MartyFiles', file: 'remove_apps/onedrive_martyfiles.bat', desc: 'Альтернативный метод глубокой зачистки OneDrive.', danger: true },
    { id: 'atlas', label: 'Atlas', file: 'remove_apps/onedrive_atlas.bat', desc: 'Метод удаления через Atlas OS.', danger: true },
    { id: 'sos', label: 'SOS', file: 'remove_apps/onedrive_sos.bat', desc: 'Экстренное удаление при проблемах.', danger: true },
    { id: 'vainos', label: 'Vainos', file: 'remove_apps/onedrive_vainos.bat', desc: 'Метод удаления через Vainos.', danger: true }
  ],
  edge: [
    { id: 'appx', label: 'AppX Edge', file: 'remove_apps/edge_appx_only.bat', desc: 'Удаляет только AppX-пакет Edge. WebView2 НЕ трогает.', danger: false },
    { id: 'full', label: 'Полное', file: 'remove_apps/edge_webview2_full.bat', desc: 'Удаляет Edge и WebView2 через официальный установщик.', warning: 'WebView2 используется в Teams, Widgets, Office.', danger: true, recommended: true },
    { id: 'hard', label: 'Хардкор', file: 'remove_apps/edge_webview2_hard.bat', desc: 'AppX + установщик + реестр + задачи + ярлыки + политики.', warning: 'Полностью ломает WebView2-зависимые приложения.', danger: true },
    { id: 'block', label: 'Только блокировка', file: 'remove_apps/edge_block_only.bat', desc: 'НЕ удаляет Edge, но блокирует автозапуск и обновления.', danger: false },
    { id: 'xos', label: 'XOS', file: 'remove_apps/edge_xos.bat', desc: 'Полное удаление через XOS метод.', danger: true },
    { id: 'sos', label: 'SOS', file: 'remove_apps/edge_sos.bat', desc: 'Экстренное удаление при проблемах.', danger: true },
    { id: 'vainos', label: 'Vainos', file: 'remove_apps/edge_vainos.bat', desc: 'Метод удаления через Vainos.', danger: true }
  ],
  webview2: [
    { id: 'only', label: 'Только WebView2', file: 'remove_apps/webview2_only.bat', desc: 'Удаляет только WebView2 Runtime. Edge НЕ трогает.', warning: 'Teams, Widgets, Office могут перестать работать.', danger: true },
    { id: 'full', label: 'Edge + WebView2', file: 'remove_apps/edge_webview2_full.bat', desc: 'Удаляет Edge и WebView2 вместе.', warning: 'Полное удаление обоих.', danger: true },
    { id: 'hard', label: 'Хардкор', file: 'remove_apps/edge_webview2_hard.bat', desc: 'Максимально агрессивная зачистка Edge + WebView2 + реестра.', danger: true }
  ],
  defender: [
    { id: 'off', label: 'Отключить', file: 'remove_apps/defender_off.bat', desc: 'Отключает Defender через политики, НЕ удаляя компоненты.', danger: false, recommended: true },
    { id: 'back', label: 'Вернуть', file: 'remove_apps/defender_back.bat', desc: 'Возвращает Defender после отключения.', danger: false },
    { id: 'remove', label: 'Удалить', file: 'remove_apps/defender_xos.bat', desc: 'Полное удаление Defender: процессы, AppX, службы, файлы.', warning: 'НЕОБРАТИМО без переустановки Windows.', danger: true },
    { id: 'hard', label: 'Хардкор', file: 'remove_apps/defender_hard.bat', desc: 'Всё из «Удалить» + расширенные политики Spynet.', warning: 'НЕОБРАТИМО без точки восстановления.', danger: true }
  ],
  notepad: [
    { id: 'remove', label: 'Удалить', file: 'remove_apps/notepad.bat', desc: 'Удаляет классический Блокнот Windows.', danger: true },
    { id: 'restore', label: 'Восстановить', file: 'remove_apps/restore_notepad.bat', desc: 'Восстанавливает классический Блокнот.', danger: false }
  ],
  internet_explorer: [
    { id: 'remove', label: 'Удалить', file: 'remove_apps/internet_explorer.bat', desc: 'Полное удаление Internet Explorer.', danger: true },
    { id: 'restore', label: 'Восстановить', file: 'remove_apps/restore_internet_explorer.bat', desc: 'Возвращает Internet Explorer в систему.', danger: false }
  ],
  rdp: [
    { id: 'remove', label: 'Удалить', file: 'remove_apps/rdp_mstsc.bat', desc: 'Удаляет клиент Remote Desktop (mstsc.exe).', danger: true, warning: 'Вы не сможете подключаться к удаленным рабочим столам через встроенный клиент.' },
    { id: 'off', label: 'Отключить', file: 'remove_apps/rdp_mstsc_off.bat', desc: 'Отключает Remote Desktop без удаления файлов.', danger: false }
  ],
  copilot: [
    { id: 'remove', label: 'Удалить', file: 'remove_apps/copilot.bat', desc: 'Удаляет Microsoft Copilot.', danger: true },
    { id: 'restore', label: 'Восстановить', file: 'remove_apps/restore_сopilot.bat', desc: 'Восстанавливает Microsoft Copilot.', danger: false }
  ],
  microsoft_photos: [
    { id: 'remove', label: 'Удалить', file: 'remove_apps/microsoft_photos.bat', desc: 'Удаляет приложение Microsoft Photos.', danger: true }
  ],
  microsoft_teams: [
    { id: 'remove', label: 'Удалить', file: 'remove_apps/microsoft_teams.bat', desc: 'Удаляет Microsoft Teams.', danger: true }
  ],
  mixed_reality_portal: [
    { id: 'remove', label: 'Удалить', file: 'remove_apps/mixed_reality_portal.bat', desc: 'Удаляет Mixed Reality Portal.', danger: true }
  ],
  wsl: [
    { id: 'remove', label: 'Удалить', file: 'remove_apps/wsl.bat', desc: 'Удаляет Windows Subsystem for Linux.', danger: true, warning: 'Все WSL-дистрибутивы будут удалены.' },
    { id: 'restore', label: 'Восстановить', file: 'remove_apps/restore_wsl.bat', desc: 'Восстанавливает WSL.', danger: false }
  ],
  xbox: [
    { id: 'remove', label: 'Удалить', file: 'remove_apps/xbox.bat', desc: 'Удаляет Xbox и связанные компоненты.', danger: true }
  ]
};

const COMPONENT_META = {
  onedrive: { icon: '☁️', title: 'OneDrive', desc: 'Облачное хранилище Microsoft' },
  edge:     { icon: '🌊', title: 'Microsoft Edge', desc: 'Браузер Microsoft' },
  webview2: { icon: '🧩', title: 'WebView2 Runtime', desc: 'Компонент для встраивания Edge' },
  defender: { icon: '🛡️', title: 'Windows Defender', desc: 'Встроенный антивирус' },
  notepad:  { icon: '📝', title: 'Блокнот', desc: 'Стандартный текстовый редактор' },
  internet_explorer: { icon: '🌐', title: 'Internet Explorer', desc: 'Устаревший браузер Microsoft' },
  rdp:      { icon: '🖥️', title: 'Remote Desktop', desc: 'Клиент подключения к удаленному рабочему столу' },
  copilot:  { icon: '🤖', title: 'Microsoft Copilot', desc: 'ИИ-ассистент Microsoft' },
  microsoft_photos: { icon: '📷', title: 'Microsoft Photos', desc: 'Приложение для просмотра фотографий' },
  microsoft_teams: { icon: '👥', title: 'Microsoft Teams', desc: 'Платформа для совместной работы' },
  mixed_reality_portal: { icon: '🥽', title: 'Mixed Reality Portal', desc: 'Портал смешанной реальности' },
  wsl:      { icon: '🐧', title: 'Windows Subsystem for Linux', desc: 'Подсистема Windows для Linux' },
  xbox:     { icon: '🎮', title: 'Xbox', desc: 'Игровые компоненты Xbox' }
};

const WINDOWS_COMPONENTS = {
  extended_wallpapers: {
    icon: '🖼️', title: 'Дополнительные фоны', desc: 'Расширенный набор обоев рабочего стола',
    tweaks: [
      { id: 'remove', label: 'Удалить', file: 'remove_components/extended_wallpapers.bat', desc: 'Удаляет дополнительные фоны рабочего стола.', danger: false },
      { id: 'restore', label: 'Восстановить', file: 'remove_components/restore/extended_wallpapers.bat', desc: 'Восстанавливает дополнительные фоны.', danger: false }
    ]
  },
  hello_face: {
    icon: '👤', title: 'Windows Hello Face', desc: 'Компонент биометрической аутентификации',
    tweaks: [
      { id: 'remove', label: 'Удалить', file: 'remove_components/hello_face.bat', desc: 'Удаляет компонент распознавания лиц Windows Hello.', danger: true },
      { id: 'restore', label: 'Восстановить', file: 'remove_components/restore/hello_face.bat', desc: 'Восстанавливает Windows Hello Face.', danger: false }
    ]
  },
  math_recognizer: {
    icon: '🧮', title: 'Math Recognizer', desc: 'Компонент распознавания математических формул',
    tweaks: [
      { id: 'remove', label: 'Удалить', file: 'remove_components/math_recognizer.bat', desc: 'Удаляет Math Recognizer.', danger: false },
      { id: 'restore', label: 'Восстановить', file: 'remove_components/restore/math_recognizer.bat', desc: 'Восстанавливает Math Recognizer.', danger: false }
    ]
  },
  openssh_client: {
    icon: '🔐', title: 'OpenSSH Client', desc: 'Клиент безопасного удаленного доступа',
    tweaks: [
      { id: 'remove', label: 'Удалить', file: 'remove_components/openssh_client.bat', desc: 'Удаляет встроенный клиент OpenSSH.', danger: false },
      { id: 'restore', label: 'Восстановить', file: 'remove_components/restore/openssh_client.bat', desc: 'Восстанавливает клиент OpenSSH.', danger: false }
    ]
  },
  powershell_ise: {
    icon: '⌨️', title: 'PowerShell ISE', desc: 'Среда сценариев Windows PowerShell',
    tweaks: [
      { id: 'remove', label: 'Удалить', file: 'remove_components/powershell_ise.bat', desc: 'Удаляет PowerShell ISE.', danger: false },
      { id: 'restore', label: 'Восстановить', file: 'remove_components/restore/powershell_ise.bat', desc: 'Восстанавливает PowerShell ISE.', danger: false }
    ]
  },
  print_management_console: {
    icon: '🖨️', title: 'Консоль управления печатью', desc: 'Инструмент управления принтерами',
    tweaks: [
      { id: 'remove', label: 'Удалить', file: 'remove_components/print_management_console.bat', desc: 'Удаляет консоль управления печатью.', danger: false },
      { id: 'restore', label: 'Восстановить', file: 'remove_components/restore/print_management_console.bat', desc: 'Восстанавливает консоль управления печатью.', danger: false }
    ]
  },
  steps_recorder: {
    icon: '📹', title: 'Steps Recorder', desc: 'Средство записи действий по воспроизведению проблем',
    tweaks: [
      { id: 'remove', label: 'Удалить', file: 'remove_components/steps_recorder.bat', desc: 'Удаляет Steps Recorder.', danger: false },
      { id: 'restore', label: 'Восстановить', file: 'remove_components/restore/steps_recorder.bat', desc: 'Восстанавливает Steps Recorder.', danger: false }
    ]
  },
  vbscript: {
    icon: '📜', title: 'VBScript', desc: 'Поддержка сценариев Visual Basic',
    tweaks: [
      { id: 'remove', label: 'Удалить', file: 'remove_components/vbscript.bat', desc: 'Отключает/удаляет поддержку VBScript.', danger: true, warning: 'Может сломать старые скрипты и программы.' },
      { id: 'restore', label: 'Восстановить', file: 'remove_components/restore/vbscipt.bat', desc: 'Включает поддержку VBScript.', danger: false }
    ]
  }
};

const REMOVAL_CATEGORIES = [
  { id: 'defender', label: '🛡️ Defender и антивирусы' },
  { id: 'edge',     label: '🌊 Microsoft Edge' },
  { id: 'onedrive', label: '☁️ OneDrive' },
  { id: 'office',   label: '📄 Microsoft Office' },
  { id: 'xbox',     label: '🎮 Xbox' },
  { id: 'uwp',      label: '📦 UWP-приложения' },
  { id: 'tools',    label: '🔧 Системные инструменты' },
  { id: 'other',    label: '📋 Прочее' }
];

const APP_OPTIM_CATEGORIES = [
  { id: 'browsers', label: '🌐 Браузеры' },
  { id: 'games',    label: '🎮 Игры' },
  { id: 'programs', label: '📱 Приложения' }
];

let _cachedRoot = null;

async function getProjectRoot() {
  if (_cachedRoot) return _cachedRoot;
  try {
    if (window.api?.app?.rootDir) {
      const r = await window.api.app.rootDir();
      if (r) {
        _cachedRoot = String(r).replace(/\\/g, '/');
        return _cachedRoot;
      }
    }
  } catch { /* ignore */ }

  let p = decodeURIComponent(location.pathname);
  if (p.startsWith('/')) p = p.slice(1);
  const idx = p.lastIndexOf('/');
  _cachedRoot = (idx >= 0 ? p.slice(0, idx) : p).replace(/\\/g, '/');
  return _cachedRoot;
}

function toBase64Utf16(str) {
  const buf = new Uint8Array(str.length * 2);
  for (let i = 0; i < str.length; i++) {
    const c = str.charCodeAt(i);
    buf[i * 2]     = c & 0xff;
    buf[i * 2 + 1] = (c >> 8) & 0xff;
  }
  let bin = '';
  for (let i = 0; i < buf.length; i++) bin += String.fromCharCode(buf[i]);
  return btoa(bin);
}

function b64ToUtf8(b64) {
  try {
    const bin = atob(b64);
    const bytes = new Uint8Array(bin.length);
    for (let i = 0; i < bin.length; i++) bytes[i] = bin.charCodeAt(i);
    return new TextDecoder('utf-8', { fatal: false }).decode(bytes);
  } catch { return ''; }
}

function parseJson(out) {
  const s = String(out || '').replace(/^\uFEFF/, '').trim();
  if (!s) return null;
  const start = s.search(/[\{\[]/);
  if (start < 0) return null;
  const end = Math.max(s.lastIndexOf('}'), s.lastIndexOf(']'));
  if (end <= start) return null;
  try { return JSON.parse(s.slice(start, end + 1)); }
  catch (e) { console.warn('[appx] JSON parse failed:', e.message); return null; }
}

function parseJsonArray(out) {
  const p = parseJson(out);
  if (Array.isArray(p)) return p;
  if (p && typeof p === 'object') return [p];
  return [];
}

function escapeHtml(s) {
  return String(s)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

async function runPs1(fileName, args = []) {
  const root = await getProjectRoot();
  const absPath = `${root}/${PS_DIR_REL}/${fileName}`.replace(/\\/g, '/');

  const argStr = args.map(a => {
    const s = String(a ?? '');
    if (s.startsWith('-')) return s;
    return `"${s.replace(/"/g, '\\"')}"`;
  }).join(' ');

  const psCommand =
    `$ProgressPreference = 'SilentlyContinue'; ` +
    `$VerbosePreference = 'SilentlyContinue'; ` +
    `$WarningPreference = 'SilentlyContinue'; ` +
    `& "${absPath}" ${argStr}`.trim();

  const enc = toBase64Utf16(psCommand);
  const cmd = `powershell.exe -NoProfile -ExecutionPolicy Bypass -EncodedCommand ${enc}`;

  const r = await window.api.tweaks.runCommand(cmd, { wait: true });
  return { code: r?.code ?? 0, out: r?.out ?? '', err: r?.err ?? '' };
}

function iconFor(name) {
  if (!name) return '📦';
  const s = String(name);
  const t = s.toLowerCase();

  if (s === 'OneDrive') return '☁️';
  if (s === 'RemoteDesktop') return '🖥️';
  if (/edge/i.test(s)) return '🌊';
  if (/chrome|chromium/i.test(t)) return '🌐';
  if (/firefox|mozilla/i.test(t)) return '🦊';
  if (/opera|gx/i.test(t)) return '🎭';
  if (/brave/i.test(t)) return '🦁';
  if (/vivaldi/i.test(t)) return '🎵';
  if (/yandex|яндекс/i.test(t)) return '🇾';
  if (/safari/i.test(t)) return '🧭';
  if (/tor\s?browser/i.test(t)) return '🧅';
  if (/steam/i.test(t)) return '🎮';
  if (/epic\s?games/i.test(t)) return '⚡';
  if (/gog\s?galaxy/i.test(t)) return '🎲';
  if (/battle\.?net|blizzard/i.test(t)) return '⚔️';
  if (/ubisoft|uplay/i.test(t)) return '🎯';
  if (/origin|ea\s?(app|desktop|games)/i.test(t)) return '🅴';
  if (/riot|valorant|league\s?of\s?legends/i.test(t)) return '🔥';
  if (/roblox/i.test(t)) return '🧱';
  if (/minecraft/i.test(t)) return '⛏️';
  if (/xbox/i.test(s)) return '🎮';
  if (/playstation|ps\s?now/i.test(t)) return '🎮';
  if (/nintendo/i.test(t)) return '🍄';
  if (/rockstar|gta/i.test(t)) return '⭐';
  if (/bethesda|skyrim|fallout/i.test(t)) return '🗡️';
  if (/unity\s?hub/i.test(t)) return '🎨';
  if (/unreal\s?engine/i.test(t)) return '🎬';
  if (/nvidia|geforce|physx/i.test(t)) return '🟢';
  if (/intel/i.test(t)) return '🔵';
  if (/amd|radeon|ryzen/i.test(t)) return '🔴';
  if (/realtek|audio|sound|звук/i.test(t)) return '🔊';
  if (/dolby|dts/i.test(t)) return '🎧';
  if (/spotify/i.test(t)) return '🟢';
  if (/music|groove|zune|itunes/i.test(t)) return '🎵';
  if (/video|vlc|film|media\s?player|k-lite|mpc-hc/i.test(t)) return '🎬';
  if (/obs|streamlabs|stream/i.test(t)) return '📹';
  if (/adobe|photoshop|illustrator|premiere|after\s?effects|lightroom/i.test(t)) return '🎨';
  if (/discord/i.test(t)) return '💬';
  if (/telegram/i.test(t)) return '✈️';
  if (/whatsapp/i.test(t)) return '📱';
  if (/skype/i.test(s)) return '💬';
  if (/teams/i.test(t)) return '👥';
  if (/slack/i.test(t)) return '💼';
  if (/zoom/i.test(t)) return '📹';
  if (/visual\s?studio/i.test(t)) return '🟣';
  if (/vscode|code/i.test(s)) return '🟦';
  if (/python/i.test(t)) return '🐍';
  if (/node|npm/i.test(t)) return '🟩';
  if (/java|jdk|jre/i.test(t)) return '☕';
  if (/docker/i.test(t)) return '🐳';
  if (/winrar|rar/i.test(t)) return '📚';
  if (/7-?zip|7zip/i.test(t)) return '🗜️';
  if (/ccleaner|cleaner/i.test(t)) return '🧹';
  if (/office|word|excel|powerpoint|outlook|onenote|access/i.test(t)) return '📄';
  if (/acrobat|pdf/i.test(t)) return '📕';
  if (/dropbox/i.test(t)) return '📦';
  if (/google\s?drive/i.test(t)) return '🟡';
  if (/yandex\s?disk/i.test(t)) return '🇾';
  if (/mega/i.test(t)) return '☁️';
  if (/defender|security/i.test(t)) return '🛡️';
  if (/kaspersky|касперский/i.test(t)) return '🟢';
  if (/avast/i.test(t)) return '🟠';
  if (/avg/i.test(t)) return '🟡';
  if (/bitdefender/i.test(t)) return '🔵';
  if (/malwarebytes|malware/i.test(t)) return '🕷️';
  if (/eset|nod32/i.test(t)) return '🟩';
  if (/norton|symantec/i.test(t)) return '🟡';
  if (/mcafee/i.test(t)) return '🔴';
  if (/firewall|брандмауэр/i.test(t)) return '🔥';
  if (/vpn|wireguard|openvpn/i.test(t)) return '🔐';
  if (/smart.?screen/i.test(t)) return '🛡️';
  if (/antimalware|антивирус/i.test(t)) return '🛡️';
  if (/store|магазин/i.test(t)) return '🛍️';
  if (/photo|фото/i.test(t)) return '🖼️';
  if (/camera|камера/i.test(t)) return '📷';
  if (/weather|погода/i.test(t)) return '⛅';
  if (/news|новости/i.test(t)) return '📰';
  if (/maps|карты/i.test(t)) return '🗺️';
  if (/mail|почта/i.test(t)) return '📧';
  if (/calc|калькулятор/i.test(t)) return '🧮';
  if (/cortana|кортана/i.test(t)) return '🤖';
  if (/people|люди|контакт/i.test(t)) return '👤';
  if (/feedback|отзыв/i.test(t)) return '📣';
  if (/tips|советы|подсказки/i.test(t)) return '💡';
  if (/solitaire|пасьянс/i.test(t)) return '🃏';
  if (/clock|будильник|часы/i.test(t)) return '⏰';
  if (/calendar|календарь/i.test(t)) return '📅';
  if (/terminal|терминал|powershell/i.test(t)) return '⌨️';
  if (/notepad|блокнот|записки/i.test(t)) return '📝';
  if (/snip|скриншот|screenshot|набросок/i.test(t)) return '✂️';
  if (/voice|голос/i.test(t)) return '🎙️';
  if (/phone|телефон/i.test(t)) return '📱';
  if (/widgets|виджеты/i.test(t)) return '🧩';
  if (/start|начало|пуск/i.test(t)) return '🏠';
  if (/money|деньги/i.test(t)) return '💰';
  if (/bing\s?sport|sport|спорт/i.test(t)) return '🏆';
  if (/mobile\s?plans|моб/i.test(t)) return '📶';
  if (/help|поддержк|помощь/i.test(t)) return '🆘';
  if (/3d\s?builder|3d-просмотр|средство 3d|paint\s?3d|print\s?3d/i.test(t)) return '🎨';
  if (/heif|webp|расширение/i.test(t)) return '🖼️';
  if (/mixed\s?reality|vr|портал/i.test(t)) return '🥽';
  if (/internet\s?explorer|explorer/i.test(t)) return '🌐';
  if (/update\s?health/i.test(t)) return '💊';
  if (/uwp/i.test(t)) return '📦';
  if (/defender.?kill|защитник/i.test(t)) return '🛡️';
  if (/visual\s?c\+\+|vc\+\+|redistributable/i.test(t)) return '⚙️';
  if (/\.net|dotnet/i.test(t)) return '🟣';
  if (/directx/i.test(t)) return '🎮';
  if (/java|jre|jdk/i.test(t)) return '☕';
  if (/webview/i.test(t)) return '🧩';
  if (/copilot/i.test(t)) return '🤖';
  if (/wsl|linux/i.test(t)) return '🐧';

  return '📦';
}

function vendorPapirusIcon(name) {
  if (!name) return null;
  const t = String(name).toLowerCase();
  if (/nvidia|geforce|physx/i.test(t)) return 'nvidia';
  if (/amd|radeon|ryzen/i.test(t))     return 'amd';
  if (/\bintel/i.test(t))              return 'intel';
  if (/directx/i.test(t))              return 'directx';
  if (/opengl/i.test(t))               return 'opengl';
  return null;
}

const ACTION_VERBS = [
  'включить', 'включать', 'включи', 'отключить', 'отключать', 'отключи', 'выключить', 'выключать', 'выключи',
  'вернуть', 'возвращать', 'верни', 'восстановить', 'восстанавливать', 'восстанови', 'включить обратно', 'вернуть обратно', 'восстановить обратно',
  'отменить', 'отмена', 'показать', 'показывать', 'покажи', 'скрыть', 'скрывать', 'скрой', 'убрать', 'убирать', 'убери',
  'добавить', 'добавлять', 'добавь', 'разблокировать', 'разблокируй', 'заблокировать', 'блокировать', 'блокируй',
  'удалить', 'удалять', 'удали', 'отменить удаление', 'настроить', 'настраивать', 'настрой', 'применить', 'применять', 'примени',
  'сбросить', 'сбрасывать', 'сбрось', 'откатить', 'откатывать', 'откати', 'изменить', 'изменять', 'измени',
  'запустить', 'запускать', 'запусти', 'остановить', 'останавливать', 'останови', 'разрешить', 'разрешать', 'разреши',
  'запретить', 'запрещать', 'запрети', 'ограничить', 'ограничивать', 'ограничь', 'установить', 'устанавливать', 'установи',
];
const ACTION_VERBS_SORTED = [...ACTION_VERBS].sort((a, b) => b.length - a.length);

function normalizeWhitespace(s) {
  return String(s).replace(/[\u00A0\u2007\u202F\u2009\u200A\uFEFF]/g, ' ').replace(/[\t\r\n]+/g, ' ').replace(/\s+/g, ' ').trim();
}

function coreName(fileName) {
  let s = String(fileName);
  s = s.replace(/^[\uFEFF\u00A0]+/, '').replace(/\.(bat|cmd|ps1|reg|exe|pow)$/i, '').replace(/^\s*отмена\s*[\\\/]\s*/i, '');
  s = normalizeWhitespace(s);
  let changed = true;
  while (changed) {
    changed = false;
    for (const verb of ACTION_VERBS_SORTED) {
      const v = normalizeWhitespace(verb).toLowerCase();
      if (s.toLowerCase().startsWith(v + ' ')) {
        s = s.slice(v.length).trim();
        changed = true;
        break;
      }
    }
  }
  return normalizeWhitespace(s).toLowerCase().replace(/\.\s*$/, '');
}

function buildPairMap(rootFiles, cancelFiles) {
  const cancels = new Map();
  for (const f of cancelFiles || []) {
    const base = String(f).replace(/\\/g, '/').split('/').pop();
    const core = coreName(base);
    if (!core) continue;
    if (!cancels.has(core)) cancels.set(core, base);
  }
  const valid = new Set();
  for (const f of rootFiles || []) {
    const base = String(f).replace(/\\/g, '/').split('/').pop();
    const core = coreName(base);
    if (core) valid.add(core);
  }
  const filtered = new Map();
  for (const [core, file] of cancels) {
    if (valid.has(core)) filtered.set(core, file);
  }
  return filtered;
}

export async function renderAppUninstaller() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = '';
  content.innerHTML = '';
  clearCheckboxes();

  const removalPane = document.createElement('div');
  removalPane.id = 'tab-removal';
  removalPane.className = 'tab-pane';

  const optimPane = document.createElement('div');
  optimPane.id = 'tab-optimization';
  optimPane.className = 'tab-pane';
  optimPane.style.display = 'none';

  const scriptsPane = document.createElement('div');
  scriptsPane.id = 'tab-scripts';
  scriptsPane.className = 'tab-pane';
  scriptsPane.style.display = 'none';

  content.appendChild(removalPane);
  content.appendChild(optimPane);
  content.appendChild(scriptsPane);

  const tabs = [
    { id: 'tab-removal', label: '🗑️ Удаление', pane: removalPane },
    { id: 'tab-optimization', label: '⚡ Оптимизация', pane: optimPane },
    { id: 'tab-scripts', label: '📜 Скрипты', pane: scriptsPane }
  ];

  tabs.forEach((tab, index) => {
    const btn = document.createElement('button');
    btn.className = `tab-btn ${index === 0 ? 'active' : ''}`;
    btn.textContent = tab.label;
    btn.addEventListener('click', () => {
      Sound.click();
      tabsNav.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      [removalPane, optimPane, scriptsPane].forEach(p => p.style.display = 'none');
      tab.pane.style.display = 'block';
    });
    tabsNav.appendChild(btn);
  });

  /* ─── PRIORITY: Четыре всадника апокалипсиса (сверху, широкая секция) ─── */
  const prioritySection = document.createElement('div');
  prioritySection.className = 'apps-detected-section priority-components-section';
  prioritySection.style.display = 'none';
  prioritySection.style.marginBottom = '24px';
  prioritySection.style.padding = '14px 14px 16px';
  prioritySection.style.borderRadius = '12px';
  prioritySection.style.border = '1px solid color-mix(in srgb, var(--accent) 35%, transparent)';
  prioritySection.style.background = 'color-mix(in srgb, var(--accent) 6%, transparent)';
  removalPane.appendChild(prioritySection);

  /* ─── SECONDARY: 📦 Программы Windows ─── */
  const detectedSection = document.createElement('div');
  detectedSection.className = 'apps-detected-section';
  detectedSection.style.display = 'none';
  detectedSection.style.marginBottom = '24px';
  removalPane.appendChild(detectedSection);

  /* ─── Windows components ─── */
  const componentsSection = document.createElement('div');
  componentsSection.className = 'apps-detected-section';
  componentsSection.style.display = 'none';
  componentsSection.style.marginBottom = '24px';
  removalPane.appendChild(componentsSection);

  const uwpHeader = document.createElement('div');
  uwpHeader.className = 'section-title';
  uwpHeader.style.marginTop = '24px';
  uwpHeader.style.marginBottom = '12px';
  uwpHeader.textContent = '📦 Найденные UWP-приложения';
  removalPane.appendChild(uwpHeader);

  const grid = document.createElement('div');
  grid.className = 'apps-grid';
  removalPane.appendChild(grid);

  const empty = document.createElement('div');
  empty.className = 'apps-empty';
  empty.textContent = 'Все UWP-приложения удалены';
  empty.style.display = 'none';
  removalPane.appendChild(empty);

  const optimSection = document.createElement('div');
  optimSection.id = 'app-optimization-section';
  optimSection.className = 'apps-detected-section';
  optimPane.appendChild(optimSection);

  const batSection = document.createElement('div');
  batSection.id = 'bat-removals-section';
  batSection.className = 'apps-detected-section';
  scriptsPane.appendChild(batSection);

  let busy = false;

  async function loadAll(force = false) {
    if (busy) return;
    busy = true;
    grid.innerHTML = '';
    prioritySection.innerHTML = '';
    prioritySection.style.display = 'none';
    detectedSection.innerHTML = '';
    detectedSection.style.display = 'none';
    componentsSection.innerHTML = '';
    componentsSection.style.display = 'none';
    empty.style.display = 'none';

    try {
      const cached = state.dataCache?.apps;
      const useCache = !force && cached && (cached.raw || cached.detectRaw);

      let listResult, detectResult;

      if (useCache) {
        listResult   = { out: cached.raw || '' };
        detectResult = { out: cached.detectRaw || '' };
      } else {
        [listResult, detectResult] = await Promise.all([
          runPs1('appx-list.ps1'),
          runPs1('appx-detect.ps1')
        ]);
        state.dataCache.apps = {
          raw: listResult.out || '',
          detectRaw: detectResult.out || ''
        };
      }

      const parsed = parseJsonArray(listResult.out);
      const list = parsed.map(a => {
        const raw = String(a.displayName || '');
        const displayName = raw.startsWith('B64:') ? b64ToUtf8(raw.slice(4)) : raw;
        return {
          name: a.name || '',
          displayName: displayName || a.name || '',
          packageFullName: a.packageFullName || null,
          kind: a.kind || 'appx'
        };
      });

      const report = parseJson(detectResult.out) || {};
      renderDetectedComponents(report);
      renderList(list);
    } catch (e) {
      toast('Ошибка загрузки: ' + e.message, 'error', 5000);
    } finally {
      busy = false;
    }

    try { await renderBatRemovals(force); } catch (e) { console.warn('[removal]', e); }
    try { await renderAppOptimization(force); } catch (e) { console.warn('[app-optim]', e); }
    renderWindowsComponents();
  }

  /* ─── Компоненты Windows (WINDOWS_COMPONENTS) ─── */
  function renderWindowsComponents() {
    const host = componentsSection;
    if (!host) return;
    host.innerHTML = '';
    host.style.display = 'block';

    const title = document.createElement('div');
    title.className = 'section-title';
    title.style.marginTop = '0';
    title.textContent = '🧩 Компоненты Windows';
    host.appendChild(title);

    const desc = document.createElement('p');
    desc.className = 'muted';
    desc.style.margin = '0 0 12px 0';
    desc.style.fontSize = '12px';
    desc.textContent = 'Управление встроенными компонентами Windows (удаление или восстановление).';
    host.appendChild(desc);

    const gridEl = document.createElement('div');
    gridEl.className = 'detected-grid';
    host.appendChild(gridEl);

    for (const [key, config] of Object.entries(WINDOWS_COMPONENTS)) {
      const card = makeComponentCardStatic(key, config);
      if (card) gridEl.appendChild(card);
    }
  }

  /* ─── Рендер обнаруженных компонентов — делит на 2 секции ─── */
  function renderDetectedComponents(report) {
    const priorityFound = [];
    const secondaryFound = [];

    for (const key of PRIORITY_COMPONENT_KEYS) {
      const r = report[key];
      if (r && r.present) {
        priorityFound.push({ key, reasons: r.reasons || [] });
      }
    }

    for (const key of SECONDARY_COMPONENT_KEYS) {
      const r = report[key];
      if (r && r.present) {
        secondaryFound.push({ key, reasons: r.reasons || [] });
      } else {
        secondaryFound.push({ key, reasons: [] });
      }
    }

    renderDetectedSection(
      prioritySection,
      priorityFound,
      '🐎 Всадники апокалипсиса',
      'Defender, Edge, WebView2 и OneDrive — четыре самых живучих компонента Windows. Больше всего вариантов удаления, поэтому карточки вынесены отдельно и растянуты на всю ширину.',
      { wide: true }
    );

    renderDetectedSection(
      detectedSection,
      secondaryFound,
      '📦 Программы Windows',
      'Выберите способ удаления/отключения для каждого компонента.'
    );
  }

  function renderDetectedSection(host, found, titleText, descText, opts = {}) {
    if (!found.length) {
      host.style.display = 'none';
      return;
    }

    host.style.display = 'block';
    host.innerHTML = '';

    const title = document.createElement('div');
    title.className = 'section-title';
    title.textContent = titleText;
    if (opts.wide) {
      title.style.fontSize = '15px';
      title.style.color = 'var(--accent)';
    }
    host.appendChild(title);

    const desc = document.createElement('p');
    desc.className = 'muted';
    desc.style.margin = '0 0 12px 0';
    desc.style.fontSize = '12px';
    desc.textContent = descText;
    host.appendChild(desc);

    const gridEl = document.createElement('div');
    gridEl.className = 'detected-grid';

    /* Широкий режим (Четыре всадника): 2 карточки в строку.
       Обычный режим (Программы Windows): дефолтная сетка через CSS. */
    if (opts.wide) {
      gridEl.style.gridTemplateColumns = 'repeat(2, minmax(0, 1fr))';
      gridEl.style.gap = '14px';
    }

    host.appendChild(gridEl);

    for (const { key, reasons } of found) {
      const card = makeComponentCard(key, reasons);
      if (card) {
        if (opts.wide) card.style.width = '100%';
        gridEl.appendChild(card);
      }
    }
  }

  /* ─── Скролл-совместимый ряд табов ─── */
  function applyScrollableNavStyles(navEl) {
    navEl.style.display = 'flex';
    navEl.style.flexWrap = 'nowrap';
    navEl.style.overflowX = 'auto';
    navEl.style.overflowY = 'hidden';
    navEl.style.scrollbarWidth = 'thin';
    navEl.style.maxWidth = '100%';
    navEl.style.gap = '4px';
    navEl.style.setProperty('scrollbar-width', 'thin');
  }

  /* ─── Статичная карточка компонента Windows ─── */
  function makeComponentCardStatic(key, config) {
    const tweaks = config.tweaks || [];
    if (!tweaks.length) return null;

    const card = document.createElement('div');
    card.className = 'detected-card';

    const head = document.createElement('div');
    head.className = 'detected-head';
    head.innerHTML = `
      <div class="detected-icon">${config.icon}</div>
      <div class="detected-info">
        <div class="detected-title">${escapeHtml(config.title)}</div>
        <div class="detected-desc">${escapeHtml(config.desc)}</div>
      </div>
    `;
    card.appendChild(head);

    const framesWrap = document.createElement('div');
    framesWrap.className = 'detected-frames';
    const nav = document.createElement('div');
    nav.className = 'detected-frames-nav';
    applyScrollableNavStyles(nav);
    const panels = document.createElement('div');
    panels.className = 'detected-frames-body';
    const panelMap = {};

    tweaks.forEach((t, idx) => {
      const tab = document.createElement('button');
      tab.type = 'button';
      tab.className = 'detected-tab' + (idx === 0 ? ' active' : '');
      tab.dataset.tweakId = t.id;
      if (t.danger) tab.classList.add('danger-tab');
      if (t.recommended) tab.classList.add('recommended-tab');

      tab.innerHTML = `
        <span class="detected-tab-label">${escapeHtml(t.label)}</span>
        ${t.recommended ? '<span class="detected-tab-star" title="Рекомендуется">★</span>' : ''}
        ${t.danger ? '<span class="detected-tab-warn" title="Опасный твик">⚠</span>' : ''}
      `;
      nav.appendChild(tab);

      const panel = document.createElement('div');
      panel.className = 'detected-panel';
      panel.style.display = idx === 0 ? '' : 'none';

      const descEl = document.createElement('div');
      descEl.className = 'detected-panel-desc';
      descEl.textContent = t.desc || '';
      panel.appendChild(descEl);

      if (t.warning) {
        const warnEl = document.createElement('div');
        warnEl.className = 'detected-panel-warning';
        warnEl.innerHTML = `<span class="warn-icon">⚠</span><span>${escapeHtml(t.warning)}</span>`;
        panel.appendChild(warnEl);
      }

      const actions = document.createElement('div');
      actions.className = 'detected-panel-actions';
      const runBtn = document.createElement('button');
      runBtn.type = 'button';
      runBtn.className = 'btn ' + (t.danger ? 'danger' : 'success');
      runBtn.textContent = '▶ Запустить';
      runBtn.title = t.file;

      runBtn.addEventListener('click', async () => {
        Sound.click();
        if (t.danger) {
          if (!confirm(`⚠️ ВНИМАНИЕ!\n\nВы запускаете «${t.label}» для ${config.title}.\n\n${t.warning || 'Это необратимая операция.'}\n\nПродолжить?`)) return;
        } else {
          if (!confirm(`Запустить «${t.label}» для ${config.title}?`)) return;
        }

        runBtn.disabled = true;
        const oldText = runBtn.textContent;
        runBtn.textContent = 'Запуск…';
        try {
          await window.api.tweaks.run(TWEAKS_BASE + t.file, { wait: false });
          toast(`Запущено: ${t.label}`, 'success', 2500);
          Sound.success();
        } catch (e) {
          toast('❌ ' + (e?.message || e), 'error', 5000);
          Sound.error();
        } finally {
          runBtn.disabled = false;
          runBtn.textContent = oldText;
        }
      });

      actions.appendChild(runBtn);
      panel.appendChild(actions);
      panels.appendChild(panel);
      panelMap[t.id] = { tab, panel };
    });

    nav.addEventListener('click', (e) => {
      const tab = e.target.closest('.detected-tab');
      if (!tab) return;
      const id = tab.dataset.tweakId;
      for (const { tab: tb, panel: pl } of Object.values(panelMap)) {
        tb.classList.toggle('active', tb.dataset.tweakId === id);
        pl.style.display = (tb.dataset.tweakId === id) ? '' : 'none';
      }
      Sound.hover();
    });

    framesWrap.appendChild(nav);
    framesWrap.appendChild(panels);
    card.appendChild(framesWrap);
    return card;
  }

  /* ─── Динамическая карточка компонента (из отчёта detect) ─── */
  function makeComponentCard(key, reasons) {
    const meta = COMPONENT_META[key];
    const tweaks = COMPONENT_TWEAKS[key] || [];
    if (!tweaks.length) return null;

    const card = document.createElement('div');
    card.className = 'detected-card';

    const head = document.createElement('div');
    head.className = 'detected-head';
    head.innerHTML = `
      <div class="detected-icon">${meta.icon}</div>
      <div class="detected-info">
        <div class="detected-title">${escapeHtml(meta.title)}</div>
        <div class="detected-desc">${escapeHtml(meta.desc)}</div>
      </div>
      ${reasons.length > 0 ? `<div class="detected-badge" title="Признаков: ${reasons.length}">${reasons.length}</div>` : ''}
    `;
    card.appendChild(head);

    if (reasons.length > 0) {
      const reasonsEl = document.createElement('details');
      reasonsEl.className = 'detected-reasons';
      const summary = document.createElement('summary');
      summary.textContent = `Что найдено (${reasons.length})`;
      reasonsEl.appendChild(summary);

      const ul = document.createElement('ul');
      for (const r of reasons.slice(0, 15)) {
        const li = document.createElement('li');
        li.textContent = r;
        ul.appendChild(li);
      }
      if (reasons.length > 15) {
        const li = document.createElement('li');
        li.textContent = `…и ещё ${reasons.length - 15}`;
        ul.appendChild(li);
      }
      reasonsEl.appendChild(ul);
      card.appendChild(reasonsEl);
    }

    const framesWrap = document.createElement('div');
    framesWrap.className = 'detected-frames';
    const nav = document.createElement('div');
    nav.className = 'detected-frames-nav';
    applyScrollableNavStyles(nav);
    const panels = document.createElement('div');
    panels.className = 'detected-frames-body';
    const panelMap = {};

    tweaks.forEach((t, idx) => {
      const tab = document.createElement('button');
      tab.type = 'button';
      tab.className = 'detected-tab' + (idx === 0 ? ' active' : '');
      tab.dataset.tweakId = t.id;
      if (t.danger) tab.classList.add('danger-tab');
      if (t.recommended) tab.classList.add('recommended-tab');

      tab.innerHTML = `
        <span class="detected-tab-label">${escapeHtml(t.label)}</span>
        ${t.recommended ? '<span class="detected-tab-star" title="Рекомендуется">★</span>' : ''}
        ${t.danger ? '<span class="detected-tab-warn" title="Опасный твик">⚠</span>' : ''}
      `;
      nav.appendChild(tab);

      const panel = document.createElement('div');
      panel.className = 'detected-panel';
      panel.style.display = idx === 0 ? '' : 'none';

      const descEl = document.createElement('div');
      descEl.className = 'detected-panel-desc';
      descEl.textContent = t.desc || '';
      panel.appendChild(descEl);

      if (t.warning) {
        const warnEl = document.createElement('div');
        warnEl.className = 'detected-panel-warning';
        warnEl.innerHTML = `<span class="warn-icon">⚠</span><span>${escapeHtml(t.warning)}</span>`;
        panel.appendChild(warnEl);
      }

      const actions = document.createElement('div');
      actions.className = 'detected-panel-actions';
      const runBtn = document.createElement('button');
      runBtn.type = 'button';
      runBtn.className = 'btn ' + (t.danger ? 'danger' : 'success');
      runBtn.textContent = '▶ Запустить';
      runBtn.title = t.file;

      runBtn.addEventListener('click', async () => {
        Sound.click();
        if (t.danger) {
          if (!confirm(`⚠️ ВНИМАНИЕ!\n\nВы запускаете «${t.label}» для ${meta.title}.\n\n${t.warning || 'Это необратимая операция.'}\n\nПродолжить?`)) return;
        } else {
          if (!confirm(`Запустить «${t.label}» для ${meta.title}?`)) return;
        }

        runBtn.disabled = true;
        const oldText = runBtn.textContent;
        runBtn.textContent = 'Запуск…';
        try {
          await window.api.tweaks.run(TWEAKS_BASE + t.file, { wait: false });
          toast(`Запущено: ${t.label}`, 'success', 2500);
          Sound.success();
        } catch (e) {
          toast('❌ ' + (e?.message || e), 'error', 5000);
          Sound.error();
        } finally {
          runBtn.disabled = false;
          runBtn.textContent = oldText;
        }
      });

      actions.appendChild(runBtn);
      panel.appendChild(actions);
      panels.appendChild(panel);
      panelMap[t.id] = { tab, panel };
    });

    nav.addEventListener('click', (e) => {
      const tab = e.target.closest('.detected-tab');
      if (!tab) return;
      const id = tab.dataset.tweakId;
      for (const { tab: tb, panel: pl } of Object.values(panelMap)) {
        tb.classList.toggle('active', tb.dataset.tweakId === id);
        pl.style.display = (tb.dataset.tweakId === id) ? '' : 'none';
      }
      Sound.hover();
    });

    framesWrap.appendChild(nav);
    framesWrap.appendChild(panels);
    card.appendChild(framesWrap);
    return card;
  }

  /* ─── UWP-приложения ─── */
  function renderList(list) {
    grid.innerHTML = '';
    list.sort((a, b) => String(a.displayName).localeCompare(String(b.displayName), 'ru'));

    for (const app of list) {
      const card = document.createElement('div');
      card.className = 'apps-card';

      const icon = document.createElement('div');
      icon.className = 'apps-icon';
      const nameForIcon = app.name || app.displayName;
      const vendor = vendorPapirusIcon(nameForIcon);

      if (vendor) {
        const url = papirusUrl('vendors', vendor);
        icon.innerHTML = `
          <img class="apps-vendor-icon" src="${url}" alt="" onerror="this.style.display='none';this.nextElementSibling.style.display='inline-flex'">
          <span class="apps-vendor-fallback" style="display:none">${iconFor(nameForIcon)}</span>
        `;
      } else {
        icon.textContent = iconFor(nameForIcon);
      }

      const title = document.createElement('div');
      title.className = 'apps-name';
      title.textContent = app.displayName || app.name;
      title.title = app.name || app.displayName;

      const sub = document.createElement('div');
      sub.className = 'apps-sub';
      sub.textContent = String(app.packageFullName || '').split('_')[0] || '';

      const runBtn = document.createElement('button');
      runBtn.type = 'button';
      runBtn.className = 'apps-run';
      runBtn.textContent = '🗑 Удалить';
      runBtn.title = 'Удалить это приложение';
      runBtn.addEventListener('click', async (e) => {
        e.stopPropagation();
        if (!confirm(`Удалить «${title.textContent}»?`)) return;
        await removeOne(app, card, runBtn);
      });

      card.append(icon, title, sub, runBtn);
      grid.appendChild(card);
    }

    empty.style.display = grid.children.length === 0 ? '' : 'none';
  }

  async function removeOne(app, cardEl, btnEl) {
    if (busy) return;
    busy = true;
    if (btnEl) { btnEl.disabled = true; btnEl.textContent = '…'; }

    try {
      let out = '', err = '';
      if (app.kind === 'appx' || app.kind === 'uwp') {
        if (!app.packageFullName) throw new Error('Нет PackageFullName');
        const r = await runPs1('appx-remove.ps1', ['-PackageFullName', app.packageFullName]);
        out = r.out; err = r.err;
      } else {
        if (app.packageFullName) {
          const r = await runPs1('appx-remove.ps1', ['-PackageFullName', app.packageFullName]);
          out = r.out; err = r.err;
        } else {
          throw new Error(`Неизвестный тип приложения: ${app.kind || 'undefined'}`);
        }
      }

      const ok = /^OK\s*$/i.test(String(out).trim());
      if (ok) {
        toast(`✅ Удалено: ${app.displayName || app.name}`, 'success', 2500);
        cardEl.remove();
        delete state.dataCache.apps;
      } else {
        console.warn('[remove] stderr:', err, 'stdout:', out);
        toast(`⚠️ Не удалось удалить: ${app.displayName || app.name}`, 'warning', 4500);
      }
    } catch (e) {
      toast('❌ ' + e.message, 'error', 5000);
    } finally {
      busy = false;
      if (btnEl) { btnEl.disabled = false; btnEl.textContent = '🗑 Удалить'; }
    }
  }

  /* ─── Батники удаления ─── */
  async function renderBatRemovals(force = false) {
    const host = batSection;
    if (!host) return;

    let data = state.dataCache?.removalData;
    if (!data || force) {
      host.innerHTML = '<div class="muted" style="padding:20px">Загрузка батников…</div>';
      try {
        const res = await window.api.tabs.readJson('tweaks/removal_tabs.json');
        if (res && res.ok && res.data) {
          data = res.data;
          state.dataCache.removalData = data;
        }
      } catch (e) { console.warn('[removal] readJson:', e); }
    }

    if (!data || !Array.isArray(data.files) || !data.files.length) {
      host.innerHTML = '<div class="apps-empty">Нет батников. Запустите build_removal_json.py</div>';
      return;
    }

    host.innerHTML = '';
    const title = document.createElement('div');
    title.className = 'section-title';
    title.style.marginTop = '0';
    title.textContent = `📜 Программы-батники для удаления · ${data.files.length}`;
    host.appendChild(title);

    const grouped = {};
    for (const f of data.files) {
      const cat = f.category || 'other';
      if (!grouped[cat]) grouped[cat] = [];
      grouped[cat].push(f);
    }

    for (const meta of REMOVAL_CATEGORIES) {
      const items = grouped[meta.id];
      if (!items || !items.length) continue;

      const catTitle = document.createElement('div');
      catTitle.className = 'section-title';
      catTitle.style.marginTop = '14px';
      catTitle.style.fontSize = '13px';
      catTitle.textContent = `${meta.label} · ${items.length}`;
      host.appendChild(catTitle);

      const catGrid = document.createElement('div');
      catGrid.className = 'apps-grid';
      host.appendChild(catGrid);

      for (const item of items) {
        catGrid.appendChild(makeBatCard(item, data.baseDir));
      }
    }
  }

  function makeBatCard(item, baseDir) {
    const card = document.createElement('div');
    card.className = 'apps-card';
    const icon = document.createElement('div');
    icon.className = 'apps-icon';
    icon.textContent = iconFor(item.title || item.name);

    const title = document.createElement('div');
    title.className = 'apps-name';
    title.textContent = item.title || item.name;
    title.title = item.name;

    const sub = document.createElement('div');
    sub.className = 'apps-sub';
    sub.textContent = item.name;

    const runBtn = document.createElement('button');
    runBtn.type = 'button';
    runBtn.className = 'apps-run';
    runBtn.textContent = '▶ Запустить';
    runBtn.addEventListener('click', async (e) => {
      e.stopPropagation();
      if (runBtn.disabled) return;
      Sound.click();
      if (!confirm(`Запустить:\n${item.name}\n\nБатник выполнится в отдельном окне консоли.`)) return;

      runBtn.disabled = true;
      const old = runBtn.textContent;
      runBtn.textContent = 'Запуск…';
      try {
        const relPath = `${baseDir}/${item.name}`;
        await window.api.tweaks.run(relPath, { visible: true });
        toast(`▶ ${item.title || item.name}`, 'success', 2500);
        Sound.success();
      } catch (e2) {
        toast('❌ ' + (e2?.message || e2), 'error', 5000);
        Sound.error();
      } finally {
        runBtn.disabled = false;
        runBtn.textContent = old;
      }
    });

    card.append(icon, title, sub, runBtn);
    return card;
  }

  /* ─── Оптимизация приложений ─── */
  async function renderAppOptimization(force = false) {
    const host = optimSection;
    if (!host) return;

    let data = state.dataCache?.appsOptimizationData;
    if (!data || force) {
      host.innerHTML = '<div class="muted" style="padding:20px">Загрузка твиков…</div>';
      try {
        const res = await window.api.tabs.readJson('tweaks/apps_optimization_tabs.json');
        if (res && res.ok && res.data) {
          data = res.data;
          state.dataCache.appsOptimizationData = data;
        }
      } catch (e) { console.warn('[app-optim] readJson:', e); }
    }

    if (!data) {
      host.innerHTML = '<div class="apps-empty">Нет данных. Запустите build_apps_json.py</div>';
      return;
    }

    host.innerHTML = '';
    const title = document.createElement('div');
    title.className = 'section-title';
    title.style.marginTop = '0';
    title.textContent = '⚡ Оптимизация приложений';
    host.appendChild(title);

    const subNav = document.createElement('div');
    subNav.className = 'sub-tabs-nav';
    host.appendChild(subNav);

    const catsHost = document.createElement('div');
    host.appendChild(catsHost);

    const catContainers = {};
    let first = true;

    for (const meta of APP_OPTIM_CATEGORIES) {
      const catData = data[meta.id];
      if (!catData) continue;

      const btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'sub-tab-btn' + (first ? ' active' : '');
      btn.textContent = meta.label;
      btn.addEventListener('click', () => {
        Sound.click();
        subNav.querySelectorAll('.sub-tab-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        for (const c of Object.values(catContainers)) c.style.display = 'none';
        if (catContainers[meta.id]) catContainers[meta.id].style.display = '';
      });
      subNav.appendChild(btn);

      const catContainer = document.createElement('div');
      catContainer.className = 'sub-tab-content';
      catContainer.style.display = (first ? '' : 'none');
      catsHost.appendChild(catContainer);
      catContainers[meta.id] = catContainer;
      first = false;

      renderAppsOptimNode(catContainer, catData, meta.id, 'root');
    }

    if (first) {
      const emptyMsg = document.createElement('div');
      emptyMsg.className = 'apps-empty';
      emptyMsg.textContent = 'Твиков не найдено.';
      host.appendChild(emptyMsg);
    }
  }

  function renderAppsOptimNode(container, node, catId, pathSuffix) {
    const files = node.files || [];
    const cancels = node.cancels || [];
    const baseDir = node.baseDir;
    const cancelDir = node.cancelDir;
    const pairMap = buildPairMap(files, cancels);

    if (files.length > 0) {
      const items = files.map(f => {
        const core = coreName(f);
        const cancelFile = pairMap.get(core) || null;
        return {
          name: f.replace(/\.[^.]+$/, ''),
          path: `${baseDir}/${f}`,
          ext: f.includes('.') ? f.split('.').pop() : '',
          cancelPath: cancelFile && cancelDir ? `${baseDir}/${cancelDir}/${cancelFile}` : null,
          cancelName: cancelFile ? cancelFile.replace(/\.[^.]+$/, '') : null
        };
      });

      const gridWrap = document.createElement('div');
      container.appendChild(gridWrap);

      renderCheckboxGrid(gridWrap, {
        items,
        tabId: `apps-optim:${catId}:${pathSuffix}`,
        sectionId: 'apps-optimization',
        mode: state.config.General?.checkbox_display_mode || 'rectangle',
        columns: parseInt(state.config.Columns?.default || '3', 10) || 3,
        showCancelButton: state.config.General?.show_cancel_buttons !== false
      });
    }

    for (const [subName, sub] of Object.entries(node.subfolders || {})) {
      const subHead = document.createElement('div');
      subHead.className = 'section-title';
      subHead.style.marginTop = '14px';
      subHead.style.fontSize = '12px';
      subHead.textContent = subName;
      container.appendChild(subHead);
      renderAppsOptimNode(container, sub, catId, `${pathSuffix}:${subName}`);
    }
  }

  await loadAll();
}