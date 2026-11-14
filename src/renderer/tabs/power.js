import { state, clearCheckboxes, toast, Sound } from '../app.js';
import { renderCheckboxGrid } from '../components/checkbox.js';
import { renderSources, loadSourceData, buildPairMap, coreName } from './sources.js';

const PK_FEATURES = [
  { 
    id: 'timeouts', 
    icon: '🕒', 
    title: 'Отключение таймаутов AC/DC', 
    desc: 'Запрещает экрану, диску и системе уходить в сон при простое.', 
    effect: 'Убирает лаги при пробуждении (когда игра подгружает текстуры с диска).',
    risk: 'Расход батареи на ноутбуке вырастает на 20–30%.',
    file: 'Электропитание/PowerKiller/PK_Timeouts.bat' 
  },
  { 
    id: 'cpu', 
    icon: '🧠', 
    title: 'Отключение CPU Throttle', 
    desc: 'Фиксирует частоту процессора на максимуме, запрещает парковку ядер.', 
    effect: 'Устраняет просадки 1% low FPS, фреймтайм становится ровным.',
    risk: 'Постоянный нагрев и шум кулера, батарея садится быстрее.',
    file: 'Электропитание/PowerKiller/PK_CPU_Throttle.bat' 
  },
  { 
    id: 'throttling', 
    icon: '⚙️', 
    title: 'Power Throttling & Dynamic Tick', 
    desc: 'Отключает энергосбережение для фоновых программ и системный таймер.', 
    effect: 'Снижает задержки (DPC latency), антивирус и фон не тормозят игру.',
    risk: 'Процессор не уходит в глубокий сон в простое, нагрев выше.',
    file: 'Электропитание/PowerKiller/PK_Power_Throttling_DynamicTick.bat' 
  },
  { 
    id: 'usb', 
    icon: '🔌', 
    title: 'Управление питанием USB', 
    desc: 'Запрещает отключение USB-портов и глубокий сон USB-контроллеров.', 
    effect: 'Мышь с опросом 1000 Гц не теряет пакеты, руль и флешки не отваливаются.',
    risk: 'Периферия потребляет энергию даже в простое, батарея садится.',
    file: 'Электропитание/PowerKiller/PK_USB_Power.bat' 
  },
  { 
    id: 'pci', 
    icon: '🎛️', 
    title: 'PCI D3Cold', 
    desc: 'Запрещает видеокарте, NVMe и сетевым картам уходить в глубокий сон (D3Cold).', 
    effect: 'Нет задержек при первом рендере или чтении с SSD после простоя.',
    risk: 'Видеокарта всегда под напряжением, ноутбук греется в простое.',
    file: 'Электропитание/PowerKiller/PK_PCI_D3Cold.bat' 
  },
  { 
    id: 'logs', 
    icon: '📓', 
    title: 'Отключение логов питания', 
    desc: 'Отключает фоновые журналы SleepStudy, Kernel-Processor-Power и телеметрию.', 
    effect: 'Меньше записи на SSD, чуть меньше нагрузка на процессор.',
    risk: 'Нет данных для диагностики, если начнутся проблемы с питанием.',
    file: 'Электропитание/PowerKiller/PK_Disable_Logs.bat' 
  }
];

const VAMPIRE_PLANS = [
  { 
    guid: '90a358c8-3bbc-4fb3-8b4e-d7ab065d2614', 
    name: 'Balanced Performance', 
    tag: 'Повседневный', 
    tagColor: '#10b981',
    icon: '⚖️',
    short: 'Обычный «Сбалансированный» режим Windows, но чуть бодрее.',
    what: 'Процессор не спешит сбрасывать частоту, когда вы что-то делаете. Держит себя «в тонусе», но всё ещё умеет экономить, когда вы отошли от компьютера.',
    why: 'Окна открываются мгновенно, браузер не задумывается, курсор не «плывёт» в моменты, когда система решает, дать ли мощности.',
    who: 'Обычному пользователю, который хочет отзывчивости, но не хочет, чтобы вентилятор гудел как самолёт. Это «золотая середина».',
    cons: 'Чуть больше греется и ест электричества, чем стандартный Balanced.',
    file: 'PK_Activate_BalancedPerformance.bat' 
  },
  { 
    guid: 'a1b2c3d4-e5f6-4789-a0ab-cdef12345678', 
    name: 'Maximum Performance', 
    tag: 'Игровой', 
    tagColor: '#3b82f6',
    icon: '🚀',
    short: 'Процессор всегда работает на полную. Даже когда вы просто смотрите на пустой рабочий стол.',
    what: 'Не даёт процессору снижать частоту вообще. Ни на секунду. Все ядра бодрствуют и готовы работать.',
    why: 'Чтобы не было даже малейшей задержки на «пробуждение» процессора. В тяжёлых задачах (рендер, компиляция, расчёты) это даёт предсказуемость.',
    who: 'Владельцам стационарных ПК, которым важна стабильность и которые не парятся о счёте за свет и шуме.',
    cons: 'Греется, шумит, ест электричество. На ноутбуке — плохая идея: батарея сядет быстро, а корпус станет горячим.',
    file: 'PK_Activate_MaximumPerformance.bat' 
  },
  { 
    guid: 'd8e76bb7-6943-4b7c-ab30-441296b72264', 
    name: 'Power Saving', 
    tag: 'Батарея', 
    tagColor: '#06b6d4',
    icon: '🔋',
    short: 'Процессор намеренно «придушивают», чтобы он меньше грелся и меньше ел.',
    what: 'Ставит потолок частоты (например, 50–80% от максимума), охотно паркует ядра, отключает лишние устройства (USB, Wi-Fi) при простое.',
    why: 'Чтобы ноутбук жил от батареи как можно дольше, а вентилятор не включался вообще.',
    who: 'В поездке, в самолёте, в библиотеке — когда нужно тихо и долго, а не быстро.',
    cons: 'Тяжёлые программы будут тормозить. Видео смотрится нормально, а вот играть или рендерить — нет.',
    file: 'PK_Activate_PowerSaving.bat' 
  },
  { 
    guid: 'b2c3d4e5-f6a7-4890-b1c2-def345678901', 
    name: 'NFS Racing', 
    tag: 'Гонки', 
    tagColor: '#f59e0b',
    icon: '🏎️',
    short: 'Профиль, заточенный под гонки. Главное — чтобы картинка не дёргалась.',
    what: 'Держит процессор бодрым, не даёт видеочипу и диску «засыпать» между кадрами, не отключает USB — чтобы руль или геймпад не отваливались посреди трассы.',
    why: 'В гонках важен не средний FPS, а ровность кадров. Один микро-рывок — и вы в отбойнике. Плюс USB-рули иногда «просыпаются» с задержкой, если Windows их отключила для экономии.',
    who: 'Тем, кто играет в Forza, NFS, DiRT, Assetto Corsa — особенно с рулём и педалями.',
    cons: 'Чуть больше нагрев и потребление, чем в обычном режиме.',
    file: 'PK_Activate_NFSRacing.bat' 
  },
  { 
    guid: 'c3d4e5f6-a7b8-4901-c2d3-ef4567890123', 
    name: 'Shooter Low-Latency', 
    tag: 'Шутеры', 
    tagColor: '#ef4444',
    icon: '🎯',
    short: 'Профиль для CS2, Valorant, Apex. Главное — чтобы выстрел вылетал ровно тогда, когда вы нажали кнопку.',
    what: 'Держит процессор на полной готовности, не даёт USB-мыши и клавиатуре «засыпать», не даёт Wi-Fi-адаптеру экономить энергию (чтобы не было скачков пинга).',
    why: 'В шутере важны миллисекунды. Если мышь опрашивается с задержкой или сетевая карта «просыпается» — вы это почувствуете как «мутную» стрельбу.',
    who: 'Соревновательным игрокам, особенно с быстрыми мышами (1000 Гц и выше) и по сети.',
    cons: 'Некоторые твики (например, отключение HPET) на современных системах могут навредить. Спорные меры, не на каждом железе дают плюс.',
    file: 'PK_Activate_Shooter.bat' 
  },
  { 
    guid: 'd4e5f6a7-b8c9-4012-d3e4-f56789012345', 
    name: 'Minimal Input Lag', 
    tag: 'Киберспорт', 
    tagColor: '#a855f7',
    icon: '⚡',
    short: 'То же, что Shooter, но ещё радикальнее. Всё, что можно отключить для снижения задержки — отключено.',
    what: 'Не даёт ядрам процессора уходить в глубокий сон вообще, меняет приоритеты планировщика Windows в пользу мыши и клавиатуры, отключает энергосбережение у USB-контроллеров.',
    why: 'Для игр, где важна не картинка, а точность нажатия: ритм-игры (osu!), файтинги (Tekken, Street Fighter), а также для тех, кто субъективно чувствует «плавающую» мышь.',
    who: 'Энтузиастам, которые готовы копаться в настройках и проверять, что им реально помогает.',
    cons: 'Сложно настраивать, на некоторых системах может наоборот ухудшить стабильность. Выигрыш не гарантирован — зависит от железа.',
    file: 'PK_Activate_InputLag.bat' 
  },
  { 
    guid: '7f8e9d0c-1b2a-4c3d-9e8f-a0b1c2d3e4f5', 
    name: 'Energetic Death', 
    tag: 'Экстрим', 
    tagColor: '#ec4899',
    icon: '💀',
    short: 'Агрессивный профиль «выжать максимум». Процессор не просто работает на полную — он ещё и разгоняется при первой возможности.',
    what: 'Держит частоту на 100%, включает агрессивный буст (процессор сам просит больше частоты), не даёт ядрам глубоко засыпать, мгновенно реагирует на любую нагрузку.',
    why: 'Для тяжёлых и плохо оптимизированных задач: старые MMORPG, эмуляторы консолей, компиляция больших проектов. Там важна каждая микросекунда пробуждения ядра.',
    who: 'Энтузиастам и тем, кто понимает, на что идёт: шум, жара, счёт за электричество — в обмен на предсказуемо максимальную мощность.',
    cons: 'Сильно греется, шумит, на ноутбуке приведёт к троттлингу (процессор сам себя придушит от перегрева).',
    file: 'PK_Activate_EnergeticDeath.bat' 
  },
  { 
    guid: '8f0a1b2c-3d4e-5f60-a1b2-c3d4e5f60718', 
    name: 'Power Killer', 
    tag: 'Безумие', 
    tagColor: '#dc2626',
    icon: '🔥',
    short: 'Самый бескомпромиссный профиль. Полный отказ от любой экономии энергии. Система ведёт себя как сервер.',
    what: 'Отключает всё энергосбережение, какое только можно: сон ядер процессора, отключение USB, экономию PCIe, экономию Wi-Fi, парковку дисков. Всё работает на полную готовность 24/7.',
    why: 'Для бенчмарков, тестов стабильности после разгона, или для специфических задач (например, аудио-станции, где USB-интерфейс не должен отключаться ни на миг).',
    who: 'В повседневной жизни — почти никому. Это инструмент для тестов и особых случаев.',
    cons: 'На ноутбуке — быстрый разряд и перегрев. На стационарном ПК — шум и жара. Для 95% пользователей это избыточно.',
    file: 'PK_Activate_PowerKiller.bat' 
  }
];

const PK_MAXIMUM_FILE = 'Электропитание/PowerKiller/PK_Maximum.bat';
const PK_REVERT_FILE  = 'Электропитание/PowerKiller/PK_Revert_All.bat';
const PK_CTX_INSTALL  = 'Электропитание/PowerKiller/Add_Blood_Energy.bat';
const PK_CTX_REMOVE   = 'Электропитание/PowerKiller/Remove_Blood_Energy.bat';
const PK_CREATE_ALL   = 'Электропитание/PowerKiller/PK_Create_All_Plans.bat';

let POWER_TABLE = [];
let POWER_TABLE_SOURCE = '';

async function loadPowerTable() {
  try {
    const res = await window.api.tabs.readJson('src/renderer/tabs/power-table.json');
    if (res && res.ok && res.data) {
      POWER_TABLE = Array.isArray(res.data.rows) ? res.data.rows : [];
      POWER_TABLE_SOURCE = res.data.source || '';
      return true;
    }
  } catch (e) {}
  return false;
}

const POWER_SOURCES = [
  { id: '__powerkiller__', label: '💀 Power Killer', desc: 'Твики + VampireOS + Blood Energy', _isPowerKiller: true },
  { id: '__standard__', label: '📦 Стандартные', desc: 'Таблица планов + встроенные твики', _isStandard: true },
  { id: 'xos', label: '🟢 XOS-Tweaks', json: 'tweaks/x_os_power_tabs.json', baseDir: 'tweaks/Электропитание/XOS-Tweaks' },
  { id: 'xos_legacy', label: '🟢 xOS (расш.)', json: 'tweaks/x_os_legacy_power_tabs.json', baseDir: 'tweaks/Электропитание/xOS' },
  { id: 'immortal', label: '💀 ImmortalOS', json: 'tweaks/immortal_os_power_tabs.json', baseDir: 'tweaks/Электропитание/ImmortalOS-Tweaks' },
  { id: 'systemx', label: '🟣 SystemX', json: 'tweaks/system_x_power_tabs.json', baseDir: 'tweaks/Электропитание/SystemX' },
  { id: 'igromanoff', label: '🎩 Igromanoff', json: 'tweaks/igromanoff_power_tabs.json', baseDir: 'tweaks/Электропитание/Igromanoff' },
  { id: 'vain', label: '👑 VainOS', json: 'tweaks/vain_os_power_tabs.json', baseDir: 'tweaks/Электропитание/VainOS-Tweaks' },
  { id: 'synergy', label: '🔷 SynergyOS', json: 'tweaks/synergy_os_power_tabs.json', baseDir: 'tweaks/Электропитание/SynergyOS-Tweaks' },
  { id: 'other', label: '📁 Другое', json: 'tweaks/drugoe_power_tabs.json', baseDir: 'tweaks/Электропитание/Другое' }
];

// ============================================================
// H E L P E R S
// ============================================================

function escapeHtml(s) {
  return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
}

/**
 * Master-detail блок: слева список элементов, справа детали выбранного.
 * Стилистика полностью на CSS-переменных приложения.
 */
function createMasterDetail({ items, renderItem, renderDetail }) {
  const container = document.createElement('div');
  container.className = 'pk-md-container';
  container.style.cssText = 'display:grid; grid-template-columns: 280px 1fr; border:1px solid var(--border); border-radius:10px; overflow:hidden; min-height:360px;';

  const list = document.createElement('div');
  list.className = 'pk-md-list';
  list.style.cssText = 'border-right:1px solid var(--border); padding:6px; display:flex; flex-direction:column; gap:2px; overflow-y:auto; max-height:560px;';
  container.appendChild(list);

  const detail = document.createElement('div');
  detail.className = 'pk-md-detail';
  detail.style.cssText = 'padding:20px; overflow-y:auto; max-height:560px; display:flex; flex-direction:column;';
  container.appendChild(detail);

  let activeIdx = 0;

  function paintActive() {
    list.querySelectorAll('[data-idx]').forEach(el => {
      const active = el.dataset.idx === String(activeIdx);
      el.style.background = active ? 'color-mix(in srgb, #7c3aed 15%, transparent)' : 'transparent';
      el.style.boxShadow  = active ? 'inset 3px 0 0 #7c3aed' : 'none';
    });
  }

  function select(i) {
    activeIdx = i;
    paintActive();
    detail.innerHTML = '';
    renderDetail(items[i], detail);
  }

  items.forEach((item, i) => {
    const el = document.createElement('div');
    el.dataset.idx = i;
    el.style.cssText = 'display:flex; align-items:center; gap:10px; padding:10px 12px; border-radius:6px; cursor:pointer; transition:background 0.15s;';
    el.innerHTML = renderItem(item);
    el.addEventListener('click', () => { Sound.click(); select(i); });
    el.addEventListener('mouseenter', () => { if (i !== activeIdx) el.style.background = 'var(--card-2)'; });
    el.addEventListener('mouseleave', () => { if (i !== activeIdx) el.style.background = 'transparent'; });
    list.appendChild(el);
  });

  select(0);
  return { container, list, detail, select };
}

function infoBlock(label, text, color) {
  return `
    <div style="padding:12px 14px; background:var(--card-2); border-radius:8px; border-left:3px solid ${color}; font-size:12px; line-height:1.55; color:var(--text);">
      <div style="font-size:10px; text-transform:uppercase; letter-spacing:0.05em; color:var(--muted); font-weight:600; margin-bottom:5px;">${label}</div>
      ${escapeHtml(text)}
    </div>
  `;
}

// ============================================================
// M A I N
// ============================================================

export async function renderPower() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = ''; content.innerHTML = '';
  clearCheckboxes();

  if (!POWER_TABLE.length) await loadPowerTable();

  const srcSection = document.createElement('div'); srcSection.className = 'opt-root'; content.appendChild(srcSection);
  const srcNav = document.createElement('div'); srcNav.className = 'opt-src-nav'; srcSection.appendChild(srcNav);
  const srcBody = document.createElement('div'); srcBody.className = 'opt-src-body'; srcSection.appendChild(srcBody);

  const pkContent  = document.createElement('div'); pkContent.id = 'power-pk-content';
  const stdContent = document.createElement('div'); stdContent.id = 'power-std-content'; stdContent.style.display = 'none';
  const srcContent = document.createElement('div'); srcContent.id = 'power-src-content'; srcContent.style.display = 'none';
  content.appendChild(pkContent); content.appendChild(stdContent); content.appendChild(srcContent);

  const srcState = { sourceId: '__powerkiller__', dataCache: {} };

  for (const s of POWER_SOURCES) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'opt-src-btn' + (s.id === srcState.sourceId ? ' active' : '');
    btn.dataset.src = s.id;
    btn.innerHTML = `<span class="opt-src-lbl">${escapeHtml(s.label)}</span>`;
    btn.title = s.desc || '';
    btn.addEventListener('click', async () => {
      if (srcState.sourceId === s.id) return;
      Sound.click(); srcState.sourceId = s.id;
      srcNav.querySelectorAll('.opt-src-btn').forEach(b => b.classList.toggle('active', b.dataset.src === s.id));
      await switchSource(s);
    });
    srcNav.appendChild(btn);
  }

  async function switchSource(src) {
    srcBody.innerHTML = '';
    pkContent.style.display = 'none'; stdContent.style.display = 'none'; srcContent.style.display = 'none'; srcContent.innerHTML = '';

    if (src._isPowerKiller) { pkContent.style.display = ''; clearCheckboxes(); buildPowerKillerTab(pkContent); return; }
    if (src._isStandard)    { stdContent.style.display = ''; clearCheckboxes(); buildPowerStandard(stdContent); return; }
    
    srcContent.style.display = '';
    let data = srcState.dataCache[src.id];
    if (data === undefined) {
      srcBody.innerHTML = `<p class="muted" style="padding:20px">Загрузка ${escapeHtml(src.label)}…</p>`;
      try { data = await loadSourceData(src); } catch (e) {
        srcBody.innerHTML = `<div class="apps-empty">Ошибка: ${escapeHtml(e.message)}</div>`; return;
      }
      srcState.dataCache[src.id] = data; srcBody.innerHTML = '';
    }
    renderSourceContent(srcContent, src, data);
    clearCheckboxes();
  }

  function renderSourceContent(host, src, data) {
    if (!data) { host.innerHTML = `<div class="apps-empty">Не удалось получить твики ${escapeHtml(src.label)}</div>`; return; }
    if (data.kind === 'flat') {
      const pairMap = buildPairMap(data.rootFiles, data.cancelFiles);
      const items = data.rootFiles.map(f => {
        const baseName = String(f).replace(/\\/g, '/').split('/').pop();
        const ext = baseName.includes('.') ? baseName.split('.').pop() : '';
        const core = coreName(baseName);
        const cancelFile = pairMap.get(core) || null;
        return { name: baseName.replace(/\.[^.]+$/, ''), path: `${src.baseDir}/${f}`, ext, category: src.label,
                 cancelPath: cancelFile ? `${src.baseDir}/отмена/${cancelFile}` : null,
                 cancelName: cancelFile ? cancelFile.replace(/\.[^.]+$/, '') : null };
      });
      const mode = state.config.General?.checkbox_display_mode || 'rectangle';
      const cols = parseInt(state.config.Columns?.default || '3', 10) || 3;
      const wrap = document.createElement('div'); wrap.className = 'section'; host.appendChild(wrap);
      const title = document.createElement('div'); title.className = 'section-title'; title.textContent = `Твики: ${src.label}`; wrap.appendChild(title);
      const grid = document.createElement('div'); wrap.appendChild(grid);
      renderCheckboxGrid(grid, { items, tabId: `power:${src.id}:root`, sectionId: 'power', mode, columns: cols, showCancelButton: state.config.General?.show_cancel_buttons !== false });
      return;
    }
    const categories = Object.keys(data.categories || {});
    if (!categories.length) { host.innerHTML = '<div class="apps-empty">Категорий не найдено</div>'; return; }
    const wrap = document.createElement('div'); wrap.className = 'section'; host.appendChild(wrap);
    const title = document.createElement('div'); title.className = 'section-title'; title.textContent = `Твики: ${src.label}`; wrap.appendChild(title);
    const subNav = document.createElement('div'); subNav.className = 'sub-tabs-nav'; wrap.appendChild(subNav);
    const catsHost = document.createElement('div'); wrap.appendChild(catsHost);
    const catContainers = {};
    for (let i = 0; i < categories.length; i++) {
      const cat = categories[i];
      const btn = document.createElement('button'); btn.type = 'button'; btn.className = 'sub-tab-btn' + (i === 0 ? ' active' : ''); btn.textContent = cat;
      btn.addEventListener('click', () => {
        Sound.click();
        subNav.querySelectorAll('.sub-tab-btn').forEach(b => b.classList.remove('active')); btn.classList.add('active');
        for (const c of Object.values(catContainers)) c.style.display = 'none';
        if (catContainers[cat]) catContainers[cat].style.display = '';
      });
      subNav.appendChild(btn);
      const catContainer = document.createElement('div'); catContainer.className = 'sub-tab-content'; catContainer.style.display = (i === 0 ? '' : 'none');
      catsHost.appendChild(catContainer); catContainers[cat] = catContainer;
      const files = data.categories[cat] || [];
      const cancelEntry = data.cancels[cat];
      const cancelFiles = cancelEntry ? cancelEntry.files : [];
      const cancelDirName = cancelEntry ? cancelEntry.key : 'отмена';
      const pairMap = buildPairMap(files, cancelFiles);
      const items = files.map(f => {
        const baseName = String(f).replace(/\\/g, '/').split('/').pop();
        const ext = baseName.includes('.') ? baseName.split('.').pop() : '';
        const core = coreName(baseName);
        const cancelFile = pairMap.get(core) || null;
        return { name: baseName.replace(/\.[^.]+$/, ''), path: `${src.baseDir}/${cat}/${f}`, ext, category: cat,
                 cancelPath: cancelFile ? `${src.baseDir}/${cat}/${cancelDirName}/${cancelFile}` : null,
                 cancelName: cancelFile ? cancelFile.replace(/\.[^.]+$/, '') : null };
      });
      const mode = state.config.General?.checkbox_display_mode || 'rectangle';
      const cols = parseInt(state.config.Columns?.default || '3', 10) || 3;
      renderCheckboxGrid(catContainer, { items, tabId: `power:${src.id}:${cat}`, sectionId: 'power', mode, columns: cols, showCancelButton: state.config.General?.show_cancel_buttons !== false });
    }
  }

  // ============================================================
  // P O W E R   K I L L E R   T A B
  // ============================================================
  function buildPowerKillerTab(host) {
    host.innerHTML = '';

    // ================= Модули Power Killer =================
    const pkSection = document.createElement('div');
    pkSection.className = 'section';
    pkSection.style.marginBottom = '24px';
    host.appendChild(pkSection);

    const pkTitle = document.createElement('div');
    pkTitle.className = 'section-title';
    pkTitle.textContent = '💀 Модули Power Killer';
    pkSection.appendChild(pkTitle);

    const pkMD = createMasterDetail({
      items: PK_FEATURES,
      renderItem: (f) => `
        <div style="font-size:18px; flex-shrink:0;">${f.icon}</div>
        <div style="flex:1; min-width:0;">
          <div style="font-size:12px; font-weight:500; color:var(--text); line-height:1.35;">${escapeHtml(f.title)}</div>
        </div>
      `,
      renderDetail: (f, detail) => {
        detail.innerHTML = `
          <div style="display:flex; align-items:center; gap:12px; margin-bottom:16px;">
            <div style="font-size:32px;">${f.icon}</div>
            <div class="apps-name" style="font-size:16px; margin:0;">${escapeHtml(f.title)}</div>
          </div>
          <div style="font-size:13px; color:var(--text); margin-bottom:16px; line-height:1.55;">${escapeHtml(f.desc)}</div>
          <div style="display:flex; flex-direction:column; gap:10px; margin-bottom:auto;">
            <div style="padding:10px 12px; background:color-mix(in srgb, #10b981 10%, var(--card-2)); border-left:3px solid #10b981; border-radius:6px; font-size:12px; line-height:1.5; color:var(--text);">
              <div style="font-size:10px; text-transform:uppercase; letter-spacing:0.05em; color:var(--muted); font-weight:600; margin-bottom:4px;">✓ Эффект</div>
              ${escapeHtml(f.effect)}
            </div>
            <div style="padding:10px 12px; background:color-mix(in srgb, #ef4444 10%, var(--card-2)); border-left:3px solid #ef4444; border-radius:6px; font-size:12px; line-height:1.5; color:var(--text);">
              <div style="font-size:10px; text-transform:uppercase; letter-spacing:0.05em; color:var(--muted); font-weight:600; margin-bottom:4px;">⚠ Риск</div>
              ${escapeHtml(f.risk)}
            </div>
          </div>
          <button class="apps-run" style="margin-top:20px; align-self:flex-start; padding:10px 24px;">▶ Применить</button>
        `;
        const btn = detail.querySelector('.apps-run');
        btn.addEventListener('click', async () => {
          if (btn.disabled) return;
          btn.disabled = true; Sound.click();
          try {
            await window.api.tweaks.run(`tweaks/${f.file}`, { wait: true });
            Sound.success(); toast(`${f.title} применено`, 'success');
          } catch (err) { Sound.error(); toast(`Ошибка: ${err.message}`, 'error'); }
          finally { btn.disabled = false; }
        });
      }
    });
    pkSection.appendChild(pkMD.container);

    const pkFooter = document.createElement('div');
    pkFooter.style.cssText = 'margin-top:16px; display:flex; gap:12px; flex-wrap:wrap; justify-content:flex-end;';
    pkFooter.innerHTML = `
      <button class="btn" id="btn-pk-max" style="flex:1; min-width:200px; background:#7c3aed; color:#fff; font-weight:600;">💀 Применить ВСЁ сразу</button>
      <button class="btn danger" id="btn-pk-revert" style="flex:1; min-width:200px;">↩ Откатить к стандарту</button>
    `;
    pkSection.appendChild(pkFooter);

    pkFooter.querySelector('#btn-pk-max').addEventListener('click', async () => {
      if (!confirm('Применить все модули Power Killer?')) return;
      const btn = pkFooter.querySelector('#btn-pk-max'); btn.disabled = true; Sound.click();
      try {
        await window.api.tweaks.run(`tweaks/${PK_MAXIMUM_FILE}`, { wait: true });
        Sound.success(); toast('Power Killer: всё применено', 'success');
      } catch (err) { Sound.error(); toast(`Ошибка: ${err.message}`, 'error'); }
      finally { btn.disabled = false; }
    });

    pkFooter.querySelector('#btn-pk-revert').addEventListener('click', async () => {
      if (!confirm('Сбросить настройки к стандартным?')) return;
      const btn = pkFooter.querySelector('#btn-pk-revert'); btn.disabled = true; Sound.click();
      try {
        await window.api.tweaks.run(`tweaks/${PK_REVERT_FILE}`, { wait: true });
        Sound.success(); toast('Настройки сброшены', 'success');
      } catch (err) { Sound.error(); toast(`Ошибка: ${err.message}`, 'error'); }
      finally { btn.disabled = false; }
    });

    // ================= Планы VampireOS =================
    const vsSection = document.createElement('div');
    vsSection.className = 'section';
    vsSection.style.marginTop = '24px';
    host.appendChild(vsSection);

    const vsTitle = document.createElement('div');
    vsTitle.className = 'section-title';
    vsTitle.textContent = '🩸 Планы электропитания VampireOS';
    vsSection.appendChild(vsTitle);

    const vsNote = document.createElement('div');
    vsNote.style.cssText = 'padding:10px 14px; background:color-mix(in srgb, #f59e0b 10%, var(--card)); border-left:3px solid #f59e0b; border-radius:6px; font-size:12px; color:var(--text); margin-bottom:16px; line-height:1.55;';
    vsNote.innerHTML = '<b>⚠ Важно:</b> названия в меню — это просто ярлыки. Если в системе нет схемы с нужным GUID, пункт будет называться «Maximum Performance», а работать как обычный Balanced.';
    vsSection.appendChild(vsNote);

    const vsTopBar = document.createElement('div');
    vsTopBar.style.cssText = 'display:flex; justify-content:space-between; align-items:center; margin-bottom:12px; gap:12px; flex-wrap:wrap;';
    vsTopBar.innerHTML = `
      <div class="muted" style="font-size:12px; flex:1;">Сначала создайте схемы, если они отсутствуют.</div>
      <button class="btn" id="btn-create-all" style="background:#7c3aed; color:#fff;">➕ Создать схемы</button>
    `;
    vsSection.appendChild(vsTopBar);

    vsTopBar.querySelector('#btn-create-all').addEventListener('click', async () => {
      const btn = vsTopBar.querySelector('#btn-create-all'); btn.disabled = true; Sound.click();
      try {
        await window.api.tweaks.run(`tweaks/${PK_CREATE_ALL}`, { wait: true });
        Sound.success(); toast('Схемы созданы', 'success');
      } catch (err) { Sound.error(); toast(`Ошибка: ${err.message}`, 'error'); }
      finally { btn.disabled = false; }
    });

    const vsMD = createMasterDetail({
      items: VAMPIRE_PLANS,
      renderItem: (p) => `
        <div style="font-size:18px; flex-shrink:0;">${p.icon}</div>
        <div style="flex:1; min-width:0; display:flex; flex-direction:column; gap:2px;">
          <div style="font-size:12px; font-weight:500; color:var(--text); line-height:1.3;">${escapeHtml(p.name)}</div>
          <div style="font-size:10px; text-transform:uppercase; letter-spacing:0.04em; color:${p.tagColor}; font-weight:500;">${escapeHtml(p.tag)}</div>
        </div>
      `,
      renderDetail: (p, detail) => {
        detail.innerHTML = `
          <div style="display:flex; align-items:center; gap:14px; margin-bottom:14px; padding-bottom:14px; border-bottom:1px solid var(--border);">
            <div style="font-size:40px; flex-shrink:0;">${p.icon}</div>
            <div style="min-width:0;">
              <div class="apps-name" style="font-size:18px; margin:0 0 6px 0;">${escapeHtml(p.name)}</div>
              <span style="font-size:10px; padding:2px 8px; border-radius:10px; background:${p.tagColor}22; color:${p.tagColor}; border:1px solid ${p.tagColor}44; text-transform:uppercase; letter-spacing:0.04em; font-weight:500;">${escapeHtml(p.tag)}</span>
            </div>
          </div>
          <div style="font-size:13px; color:var(--muted); line-height:1.55; margin-bottom:18px;">${escapeHtml(p.short)}</div>
          <div style="display:grid; grid-template-columns:1fr 1fr; gap:10px; margin-bottom:auto;">
            ${infoBlock('🧠 Что делает', p.what, '#7c3aed')}
            ${infoBlock('🎯 Зачем', p.why, '#3b82f6')}
            ${infoBlock('👤 Кому', p.who, '#10b981')}
            ${infoBlock('⚠ Минус', p.cons, '#ef4444')}
          </div>
          <div style="display:flex; justify-content:space-between; align-items:center; gap:12px; margin-top:20px; padding-top:16px; border-top:1px solid var(--border); flex-wrap:wrap;">
            <code style="font-family:'SF Mono', Consolas, monospace; font-size:11px; color:var(--muted); background:var(--card-2); padding:5px 9px; border-radius:6px; border:1px solid var(--border);">${p.guid}</code>
            <button class="apps-run" style="padding:10px 20px;">▶ Активировать</button>
          </div>
        `;
        const btn = detail.querySelector('.apps-run');
        btn.addEventListener('click', async () => {
          if (btn.disabled) return;
          btn.disabled = true; Sound.click();
          try {
            await window.api.tweaks.run(`tweaks/Электропитание/PowerKiller/${p.file}`, { wait: true });
            Sound.success(); toast(`Схема «${p.name}» активирована`, 'success');
          } catch (err) { Sound.error(); toast(`Ошибка: ${err.message}`, 'error'); }
          finally { btn.disabled = false; }
        });
      }
    });
    vsSection.appendChild(vsMD.container);

    // ================= Blood Energy =================
    const beSection = document.createElement('div');
    beSection.className = 'section';
    beSection.style.marginTop = '24px';
    host.appendChild(beSection);

    const beTitle = document.createElement('div');
    beTitle.className = 'section-title';
    beTitle.textContent = '🩸 Blood Energy';
    beSection.appendChild(beTitle);

    const beDesc = document.createElement('p');
    beDesc.className = 'muted';
    beDesc.style.cssText = 'font-size:13px; line-height:1.5; margin: 0 0 16px 0;';
    beDesc.textContent = 'Добавляет в контекстное меню рабочего стола быстрый доступ ко всем схемам питания, управлению Idle и панели управления.';
    beSection.appendChild(beDesc);

    const beButtons = document.createElement('div');
    beButtons.style.cssText = 'display:flex; gap:12px; flex-wrap:wrap;';
    beButtons.innerHTML = `
      <button class="btn" id="btn-be-install" style="flex:1; min-width:200px; background:#dc2626; color:#fff; font-weight:600;">🩸 Установить</button>
      <button class="btn danger" id="btn-be-remove" style="flex:1; min-width:200px;">🗑 Удалить</button>
    `;
    beSection.appendChild(beButtons);

    beButtons.querySelector('#btn-be-install').addEventListener('click', async () => {
      if (!confirm('Установить меню Blood Energy?')) return;
      const btn = beButtons.querySelector('#btn-be-install'); btn.disabled = true; Sound.click();
      try {
        await window.api.tweaks.run(`tweaks/${PK_CTX_INSTALL}`, { wait: true });
        Sound.success(); toast('Blood Energy установлен', 'success');
      } catch (err) { Sound.error(); toast(`Ошибка: ${err.message}`, 'error'); }
      finally { btn.disabled = false; }
    });

    beButtons.querySelector('#btn-be-remove').addEventListener('click', async () => {
      if (!confirm('Удалить меню Blood Energy?')) return;
      const btn = beButtons.querySelector('#btn-be-remove'); btn.disabled = true; Sound.click();
      try {
        await window.api.tweaks.run(`tweaks/${PK_CTX_REMOVE}`, { wait: true });
        Sound.success(); toast('Blood Energy удалён', 'success');
      } catch (err) { Sound.error(); toast(`Ошибка: ${err.message}`, 'error'); }
      finally { btn.disabled = false; }
    });
  }

  // ============================================================
  // S T A N D A R D   T A B   (не тронуто)
  // ============================================================
  function buildPowerStandard(host) {
    host.innerHTML = '';
    const tableSection = document.createElement('div'); tableSection.className = 'section'; host.appendChild(tableSection);
    const tableTitle = document.createElement('div'); tableTitle.className = 'section-title'; tableTitle.textContent = '📊 Результаты тестирования планов электропитания'; tableSection.appendChild(tableTitle);
    const tableWrap = document.createElement('div'); tableWrap.className = 'power-table-wrap'; tableSection.appendChild(tableWrap);
    const table = document.createElement('table'); table.className = 'power-table';
    table.innerHTML = `<thead><tr><th>План питания</th><th>Ср. задержка (мс)</th><th>Мин. задержка</th><th>Макс. задержка</th><th>Ср. FPS</th><th>Темп. CPU</th><th>Комментарий</th></tr></thead><tbody></tbody>`;
    const tbody = table.querySelector('tbody');
    for (const row of POWER_TABLE) {
      const [plan, avg, min, max, fps, temp, comment] = row;
      const isSep = avg === null && min === null && fps === null;
      const tr = document.createElement('tr');
      if (isSep) tr.className = 'power-row-sep';
      tr.innerHTML = `<td>${escapeHtml(plan)}</td><td>${avg ?? ''}</td><td>${min ?? ''}</td><td>${max ?? ''}</td><td>${fps ?? ''}</td><td>${temp ?? ''}</td><td>${comment ? escapeHtml(comment) : ''}</td>`;
      tbody.appendChild(tr);
    }
    tableWrap.appendChild(table);
    const footer = document.createElement('div'); footer.className = 'power-footer';
    if (POWER_TABLE_SOURCE) {
      footer.innerHTML = `Источник данных: <a href="${escapeHtml(POWER_TABLE_SOURCE)}" target="_blank" rel="noopener">Google Sheets</a>`;
      footer.querySelector('a').addEventListener('click', (e) => { e.preventDefault(); window.api.shell.openExternal(POWER_TABLE_SOURCE); });
    } else footer.innerHTML = '<span class="muted">Источник данных не указан.</span>';
    tableSection.appendChild(footer);

    const tabsData = state.tabsData || {};
    const tabs2 = tabsData.tabs_2 || {};
    const PLAN_ORDER = ['Популярные режимы электропитания','Классика','Адские режимы электропитания','Схемы AMD&INTEL','Схемы где ЗАГРУЖЕННОСТЬ ПРОЦЕССОРА 100%','Все планы электропитания','Твики','Твики от xOS','Электропитание'];
    const known = Object.keys(tabs2);
    const ordered = [...PLAN_ORDER.filter(k => known.includes(k)), ...known.filter(k => !PLAN_ORDER.includes(k))];
    if (!ordered.length) return;

    const plansSection = document.createElement('div'); plansSection.className = 'section'; plansSection.style.marginTop = '24px'; host.appendChild(plansSection);
    const plansTitle = document.createElement('div'); plansTitle.className = 'section-title'; plansTitle.textContent = '🔋 Планы и твики электропитания'; plansSection.appendChild(plansTitle);
    const subNav = document.createElement('div'); subNav.className = 'sub-tabs-nav'; plansSection.appendChild(subNav);
    const innerHost = document.createElement('div'); plansSection.appendChild(innerHost);
    const containers = {};
    for (let i = 0; i < ordered.length; i++) {
      const cat = ordered[i];
      const btn = document.createElement('button'); btn.type = 'button'; btn.className = 'sub-tab-btn' + (i === 0 ? ' active' : ''); btn.textContent = cat;
      btn.addEventListener('click', () => {
        Sound.click(); subNav.querySelectorAll('.sub-tab-btn').forEach(b => b.classList.remove('active')); btn.classList.add('active');
        for (const c of Object.values(containers)) c.style.display = 'none';
        if (containers[cat]) containers[cat].style.display = '';
      });
      subNav.appendChild(btn);
      const catContainer = document.createElement('div'); catContainer.className = 'sub-tab-content'; catContainer.style.display = (i === 0 ? '' : 'none');
      innerHost.appendChild(catContainer); containers[cat] = catContainer;
      const files = (tabs2[cat] || []).filter(f => /\.(pow|bat|cmd|exe|ps1|reg)$/i.test(f));
      const items = files.map(rel => {
        const relStr = String(rel).replace(/\\/g, '/');
        const seg = relStr.split('/');
        const base = seg[seg.length - 1];
        const sub = seg.length > 1 ? seg.slice(0, -1).join('/') : null;
        const ext = base.includes('.') ? base.split('.').pop() : '';
        return { name: base.replace(/\.[^.]+$/, ''), path: `tweaks/Электропитание/${cat}/${relStr}`, ext, category: sub };
      });
      const mode = state.config.General?.checkbox_display_mode || 'rectangle';
      const cols = parseInt(state.config.Columns?.default || '3', 10) || 3;
      renderCheckboxGrid(catContainer, { items, tabId: cat, sectionId: 'power', mode, columns: cols });
    }
  }

  buildPowerKillerTab(pkContent);
}