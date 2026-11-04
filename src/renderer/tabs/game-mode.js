import { toast } from '../app.js';
import { papirusUrl } from '../utils/icons.js';

/* ------------------------------------------------------------
   Конфигурация и списки
   ------------------------------------------------------------ */

const SAFE_SERVICES = [
  "DiagTrack", "dmwappushservice", "diagnosticshub.standardcollector.service",
  "WSearch", "SysMain", "WpnService", "WpnUserService", "OneSyncSvc",
  "XblAuthManager", "XblGameSave", "XboxNetApiSvc", "XboxGipSvc",
  "MapsBroker", "RetailDemo", "PhoneSvc", "Fax", "Spooler",
  "WMPNetworkSvc", "SharedAccess", "RemoteRegistry", "RemoteAccess",
  "TrkWks", "SDRSVC", "WerSvc", "Wecsvc", "PcaSvc", "AppMgmt",
  "AppReadiness", "AssignedAccessManagerSvc", "BcastDVRUserService",
  "CaptureService", "cbdhsvc", "MessagingService", "SEMgrSvc",
  "WalletService", "wisvc", "WarpJITSvc", "UsoSvc", "WaaSMedicSvc",
  "DoSvc", "PeerDistSvc", "TroubleshootingSvc", "TabletInputService",
  "TapiSrv", "TermService", "TieringEngineService", "TimeBrokerSvc",
  "TokenBroker", "VacSvc", "WFDSConMgrSvc", "WManSvc", "WPDBusEnum",
  "SmsRouter", "SNMPTRAP", "SCardSvr", "ScDeviceEnum", "SCPolicySvc",
  "PerfHost", "QWAVE", "RasAuto", "RasMan", "PNRPsvc", "PNRPAutoReg",
  "UevAgentService", "icssvc", "lmhosts", "lltdsvc", "netprofm",
  "p2pimsvc", "p2psvc", "perceptionsimulation", "pla", "seclogon",
  "shpamsvc", "smphost", "spectrum", "stisvc", "svsvc", "swprv",
  "tzautoupdate", "upnphost", "vds", "wbengine", "wcncsvc",
  "wercplsupport", "wlpasvc", "wmiApSrv", "wscsvc", "LanmanServer",
  "MSDTC", "FontCache", "FontCache3.0.0.0", "GpuEnergyDrv",
  "edgeupdate", "edgeupdatem", "MicrosoftEdgeElevationService",
  "WbioSrvc", "Sense", "SecurityHealthService", "WdNisSvc",
  "WinDefend", "BFE", "mpssvc", "lfsvc", "SensorDataService",
  "SensorService", "SensrSvc", "SharedRealitySvc", "MixedRealityOpenXRSvc",
  "CldFlt", "UCPD", "CloudIdSvc", "WPCMonSvc", "CloudBackupRestoreSvc",
  "fhsvc", "acpipagr", "PRM", "acpitime", "bam", "dam", "WmiAcpi",
  "Telemetry", "intelpmt", "kdnic", "Ndu", "DSSvc"
];

const PK_FEATURES = [
  {
    id: 'timeouts',
    label: '🕒 Отключение таймаутов (AC/DC)',
    desc: 'Запрещает монитору, диску и системе уходить в сон или гибернацию во время игры. Убирает микро-лаги при простое.',
    file: 'PK_Timeouts.bat'
  },
  {
    id: 'cpu_throttle',
    label: '🧠 Отключение CPU Throttle',
    desc: 'Запрещает Windows ограничивать максимальную частоту процессора (Core Parking / Min State). CPU всегда на максимуме.',
    file: 'PK_CPU_Throttle.bat'
  },
  {
    id: 'power_throttling',
    label: '⚙️ Power Throttling & Dynamic Tick',
    desc: 'Отключает фоновое энергосбережение ядра и динамическое изменение частоты таймера. Снижает DPC latency.',
    file: 'PK_Power_Throttling_DynamicTick.bat'
  },
  {
    id: 'usb_power',
    label: '🔌 Управление питанием USB (LPM / D3Cold)',
    desc: 'Предотвращает "засыпание" USB-портов. Критично для игровых мышек с опросом 1000Hz+ и контроллеров.',
    file: 'PK_USB_Power.bat'
  },
  {
    id: 'pci_d3cold',
    label: '🎛️ PCI D3Cold (Энергосбережение PCIe)',
    desc: 'Запрещает глубокий сон для видеокарты и NVMe-накопителей. Устраняет микро-фризы при загрузке текстур.',
    file: 'PK_PCI_D3Cold.bat'
  },
  {
    id: 'logs',
    label: '📓 Диагностические журналы питания',
    desc: 'Отключает SleepStudy, Kernel-Processor-Power и другие логи. Снижает фоновую нагрузку на диск и CPU.',
    file: 'PK_Disable_Logs.bat'
  }
];

// Планы электропитания с описаниями
const POWER_PLANS = [
  { name: 'Amit_v1_lowlatency', desc: 'Низкая задержка ввода, баланс производительности' },
  { name: 'Amit_v2_extreme performance', desc: 'Максимальная производительность без компромиссов' },
  { name: 'Amit_v3_low latency', desc: 'Оптимизирован для минимальной задержки в играх' },
  { name: 'Atlas Power Plan', desc: 'План от AtlasOS — агрессивная оптимизация' },
  { name: 'Bitsum Highest Performance', desc: 'Максимальная частота CPU, отключено энергосбережение' },
  { name: 'Calypto', desc: 'Сбалансированный план для игр и работы' },
  { name: 'GGOSv0_8_5_Idle_Enabled', desc: 'GGOS план с включённым режимом простоя' },
  { name: 'Light pow v', desc: 'Лёгкий план с минимальными настройками' },
  { name: 'Muren_Idle_Enabled', desc: 'План Muren с поддержкой idle-состояний' },
  { name: 'Quaked Ultimate Performance Idle Off', desc: 'Максимальная производительность, idle отключён' },
  { name: 'Quaked Ultimate Performance', desc: 'Абсолютный максимум производительности' },
  { name: 'Unixcorn_Idle_Enabled', desc: 'План Unixcorn с включённым idle' },
  { name: 'XOS imribiy', desc: 'План от XOS — оптимизация для игр' },
  { name: 'Zoyata_Low Latency', desc: 'Низкая задержка, оптимизация для шутеров' }
];

const SCRIPTS = {
  backup: 'GameMode/Backup_Services.bat',
  restore: 'GameMode/Restore_Services.bat',
  disableServices: 'GameMode/Disable_Services.bat',
  revertServicesFallback: 'GameMode/Revert_Services_Fallback.bat',
  pkRevert: 'GameMode/PK_Revert_All.bat'
};

/* ------------------------------------------------------------
   Основной рендер
   ------------------------------------------------------------ */
export async function renderGameMode() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = '';
  content.innerHTML = '';

  // Контейнер для всех фреймов — один столбец по центру
  const wrap = document.createElement('div');
  wrap.style.cssText = 'display:flex; flex-direction:column; gap:20px; max-width:1200px; margin:0 auto;';

  // ================= ФРЕЙМ 1: ОБЩАЯ ИНФА =================
  const frame1 = document.createElement('div');
  frame1.className = 'panel';

  const gameIcon = papirusUrl('devices', 'gamepad');

  frame1.innerHTML = `
    <h3 class="game-title">
      <span>🎮 Игровой режим</span>
    </h3>
    <p style="color:var(--fg-muted); font-size:13px; margin-top:8px; line-height:1.6;">
      Комплексная оптимизация Windows для максимальной производительности в играх.
      Отключает фоновые процессы, телеметрию и настраивает электропитание для снижения задержек (latency) и микро-фризов.
      <br><br>
      ⚡ <b>Что делает:</b> массовое отключение фоновых служб + тонкая настройка электропитания (Power Killer).
      <br>
      🛡️ <b>Безопасность:</b> критические драйверы (питание, ввод, сеть, темы) защищены и не будут затронуты.
    </p>

    <div style="margin-top:16px; padding:14px; background:var(--bg-alt); border-radius:8px; display:flex; align-items:center; gap:14px;">
      <span class="switch" id="gm-backup-switch" role="switch" aria-checked="true" tabindex="0"
            style="position:relative;display:inline-block;width:42px;height:22px;flex:0 0 auto;
                   background:#2e7d32;border-radius:22px;transition:background .15s;outline:none;cursor:pointer;"
            data-on="true">
        <span class="switch-knob" style="position:absolute;top:3px;left:23px;width:16px;height:16px;
                                          border-radius:50%;background:#fff;transition:left .15s;"></span>
      </span>
      <div style="flex:1;">
        <div style="font-weight:600; font-size:14px;">💾 Автоматический бэкап реестра служб</div>
        <div style="font-size:12px; color:var(--fg-muted); margin-top:4px; line-height:1.5;">
          Перед отключением служб будет создан файл <code>.reg</code> с текущим состоянием реестра.
          Это позволит безопасно откатить любые изменения одним кликом через кнопку "Восстановить из бэкапа".
        </div>
      </div>
    </div>

    <div id="gm-status" style="margin-top:16px; padding:12px; background:var(--bg-alt); border-radius:8px; font-size:13px; color:var(--fg-muted); border-left:3px solid var(--accent);">
      ℹ️ Готов к работе. Выберите опции ниже и нажмите "Применить".
    </div>
  `;
  wrap.appendChild(frame1);

  // ================= ФРЕЙМ 2: ГОТОВЫЕ ПЛАНЫ ЭЛЕКТРОПИТАНИЯ =================
  const frame2 = document.createElement('div');
  frame2.className = 'panel';

  frame2.innerHTML = `
    <h3 class="game-title">
      <span>📦 Готовые планы электропитания</span>
    </h3>
    <p style="color:var(--fg-muted); font-size:13px; margin-top:8px; line-height:1.6;">
      Импортируйте готовый план электропитания от популярных оптимизаторов.
      <br>
      🛡️ <b>Защита от дубликатов:</b> если план уже импортирован в систему, повторный импорт будет пропущен — создаётся только одна копия.
      <br>
      💡 <b>Совет:</b> для ноутбуков рекомендуется выбирать планы с <code>Idle_Enabled</code> в названии.
      <br>
      ⚠️ <b style="color:#f59e0b;">Внимание:</b> планы с "Ultimate Performance" могут привести к быстрому разряду батареи.
    </p>

    <div style="margin-top:16px; display:flex; gap:12px; align-items:flex-end;">
      <div style="flex:1;">
        <label style="font-size:12px; font-weight:600; display:block; margin-bottom:6px;">Выберите план:</label>
        <select id="power-plan-select" style="width:100%; padding:10px; background:var(--bg-alt); color:var(--fg); border:1px solid var(--border); border-radius:6px; cursor:pointer; font-size:13px;">
          <option value="">— выберите план —</option>
          ${POWER_PLANS.map(p => `<option value="${p.name}">${p.name}</option>`).join('')}
        </select>
      </div>
    </div>

    <div id="plan-desc" style="margin-top:12px; padding:12px; background:var(--bg-alt); border-radius:6px; font-size:12px; color:var(--fg-muted); min-height:40px; display:none;">
      <b>Описание плана:</b> <span id="plan-desc-text"></span>
    </div>
  `;

  // Кнопки — РАЗДЕЛЕНЫ: импорт (с проверкой) и активация
  const planFooter = document.createElement('div');
  planFooter.style.cssText = 'display:flex; gap:10px; margin-top:20px; padding-top:16px; border-top:1px solid var(--border);';
  planFooter.innerHTML = `
    <button class="btn" id="btn-import-plan" style="flex:1; background:#2563eb; color:white;">📥 Импортировать план</button>
    <button class="btn success" id="btn-activate-plan" style="flex:1;">⚡ Активировать план</button>
  `;
  frame2.appendChild(planFooter);

  wrap.appendChild(frame2);

  // ================= ФРЕЙМ 3: АКТИВАЦИЯ УСТАНОВЛЕННЫХ ПЛАНОВ =================
  const frame3 = document.createElement('div');
  frame3.className = 'panel';

  frame3.innerHTML = `
    <h3 class="game-title">
      <span>⚡ Быстрая активация установленных планов</span>
    </h3>
    <p style="color:var(--fg-muted); font-size:13px; margin-top:8px; line-height:1.6;">
      Мгновенное переключение на уже импортированный план электропитания.
      <br>
      💡 Если план не активируется — сначала импортируйте его через блок выше.
    </p>

    <div style="margin-top:16px; display:grid; grid-template-columns:1fr 1fr; gap:10px;">
      ${POWER_PLANS.map(p => `
        <button class="btn" data-plan="${p.name}" style="text-align:left; padding:10px 12px; font-size:12px; line-height:1.4;">
          <div style="font-weight:600; margin-bottom:2px;">⚡ ${p.name}</div>
        </button>
      `).join('')}
    </div>
  `;

  wrap.appendChild(frame3);

  // ================= ФРЕЙМ 4: POWER KILLER =================
  const frame4 = document.createElement('div');
  frame4.className = 'panel';

  frame4.innerHTML = `
    <h3 class="game-title">
      <span>🔧 Тонкая настройка Power Killer</span>
    </h3>
    <p style="color:var(--fg-muted); font-size:13px; margin-top:8px; line-height:1.6;">
      Тонкая настройка энергосбережения Windows для предотвращения троттлинга CPU, отключения "засыпания" USB/PCIe и снижения DPC latency.
      <br>
      ⚠️ <b style="color:#f59e0b;">Не рекомендуется для ноутбуков при работе от батареи</b> — может привести к быстрому разряду.
      <br>
      💡 Отметьте галочками только те функции, которые хотите применить. Можно комбинировать.
    </p>

    <div style="margin-top:16px; display:flex; flex-direction:column; gap:10px;">
      ${PK_FEATURES.map(f => `
        <label style="display:flex; gap:12px; padding:12px; background:var(--bg-alt); border-radius:8px; cursor:pointer; border:1px solid var(--border); transition:border-color .15s;">
          <input type="checkbox" class="pk-cb" value="${f.file}" checked style="margin-top:3px; accent-color:var(--accent); cursor:pointer;">
          <div style="flex:1;">
            <div style="font-weight:600; font-size:14px;">${f.label}</div>
            <div style="font-size:12px; color:var(--fg-muted); margin-top:4px; line-height:1.5;">${f.desc}</div>
          </div>
        </label>
      `).join('')}
    </div>
  `;

  const pkFooter = document.createElement('div');
  pkFooter.style.cssText = 'display:flex; gap:10px; margin-top:20px; padding-top:16px; border-top:1px solid var(--border);';
  pkFooter.innerHTML = `
    <button class="btn success" id="btn-pk-apply" style="flex:1;">▶ Применить выбранные</button>
    <button class="btn danger" id="btn-pk-revert" style="flex:1;">↩ Откатить питание</button>
  `;
  frame4.appendChild(pkFooter);

  wrap.appendChild(frame4);

  // ================= ФРЕЙМ 5: СЛУЖБЫ =================
  const frame5 = document.createElement('div');
  frame5.className = 'panel';

  frame5.innerHTML = `
    <h3 class="game-title">
      <span>🛡️ Оптимизация служб Windows</span>
    </h3>
    <p style="color:var(--fg-muted); font-size:13px; margin-top:8px; line-height:1.6;">
      Массовое отключение <b>${SAFE_SERVICES.length}</b> телеметрических, рекламных и фоновых служб (перевод в Start=4).
      <br>
      🛡️ <b>Защищённые категории</b> (никогда не отключаются): питание 🔋, ввод ⌨️, сеть 🌐, темы 🎨, системные ядра ⚙️ (Start 0-2).
      <br>
      💡 Снимите галочки со служб, которые хотите <b>оставить включёнными</b>. По умолчанию выбраны все.
    </p>

    <div style="margin-top:12px; display:flex; gap:8px;">
      <button class="btn" id="gm-svc-all" style="flex:1; font-size:12px;">✅ Выбрать все</button>
      <button class="btn" id="gm-svc-none" style="flex:1; font-size:12px;">❌ Снять все</button>
    </div>

    <div style="margin-top:12px; max-height:350px; overflow-y:auto; padding:12px; background:var(--bg-alt); border-radius:8px; border:1px solid var(--border); columns:3; column-gap:12px;">
      ${SAFE_SERVICES.map(s => `
        <label style="display:flex; align-items:center; gap:6px; padding:4px 0; font-size:12px; font-family:Consolas,Monaco,monospace; cursor:pointer; user-select:none; break-inside:avoid;">
          <input type="checkbox" class="svc-cb" value="${s}" checked style="accent-color:var(--accent); cursor:pointer;"> <span>${s}</span>
        </label>
      `).join('')}
    </div>
  `;

  const svcFooter = document.createElement('div');
  svcFooter.style.cssText = 'display:flex; gap:10px; margin-top:20px; padding-top:16px; border-top:1px solid var(--border);';
  svcFooter.innerHTML = `
    <button class="btn success" id="btn-svc-apply" style="flex:1;">▶ Отключить службы</button>
    <button class="btn danger" id="btn-svc-restore" style="flex:1;">↩ Восстановить из бэкапа</button>
  `;
  frame5.appendChild(svcFooter);

  wrap.appendChild(frame5);

  // ================= ФРЕЙМ 6: ЗАЩИЩЁННЫЕ КОМПОНЕНТЫ =================
  const frame6 = document.createElement('div');
  frame6.className = 'panel';

  frame6.innerHTML = `
    <h3 class="game-title">
      <span>🔒 Защищённые компоненты</span>
    </h3>
    <p style="color:var(--fg-muted); font-size:13px; margin-top:8px; line-height:1.6;">
      Следующие категории системных драйверов и служб <b>никогда</b> не отключаются этим скриптом, чтобы гарантировать стабильную работу ПК и ноутбука:
    </p>

    <div style="margin-top:12px; display:grid; grid-template-columns:1fr 1fr; gap:10px;">
      <div style="padding:10px; background:var(--bg-alt); border-radius:6px; font-size:13px; line-height:1.6;">
        🔋 <b>Питание:</b> Power, CmBatt, AcpiPmi, acpiex
      </div>
      <div style="padding:10px; background:var(--bg-alt); border-radius:6px; font-size:13px; line-height:1.6;">
        ⌨️ <b>Ввод:</b> mouclass, kbdclass, hidserv, mouhid
      </div>
      <div style="padding:10px; background:var(--bg-alt); border-radius:6px; font-size:13px; line-height:1.6;">
        🌐 <b>Сеть:</b> WlanSvc, Dhcp, Dnscache, NlaSvc, Netman
      </div>
      <div style="padding:10px; background:var(--bg-alt); border-radius:6px; font-size:13px; line-height:1.6;">
        🎨 <b>Интерфейс:</b> Themes, Audiosrv, AudioEndpointBuilder
      </div>
      <div style="padding:10px; background:var(--bg-alt); border-radius:6px; font-size:13px; line-height:1.6;">
        ⚙️ <b>Ядро (Start 0-2):</b> RpcSs, SamSs, LSM, DcomLaunch, Schedule
      </div>
      <div style="padding:10px; background:var(--bg-alt); border-radius:6px; font-size:13px; line-height:1.6;">
        🛡️ <b>Безопасность:</b> BFE, mpssvc, WinDefend
      </div>
    </div>
  `;

  wrap.appendChild(frame6);

  content.appendChild(wrap);

  // ================= ЛОГИКА =================
  const statusEl = frame1.querySelector('#gm-status');
  const switchEl = frame1.querySelector('#gm-backup-switch');
  const knobEl = switchEl.querySelector('.switch-knob');

  function setSwitch(on) {
    switchEl.dataset.on = on ? 'true' : 'false';
    switchEl.setAttribute('aria-checked', on ? 'true' : 'false');
    switchEl.style.background = on ? '#2e7d32' : '#3a3a3a';
    knobEl.style.left = on ? '23px' : '3px';
  }
  function isSwitchOn() { return switchEl.dataset.on === 'true'; }
  function toggleSwitch() { setSwitch(!isSwitchOn()); }

  switchEl.addEventListener('click', toggleSwitch);
  switchEl.addEventListener('keydown', (e) => {
    if (e.key === ' ' || e.key === 'Enter') { e.preventDefault(); toggleSwitch(); }
  });
  setSwitch(true);

  function updateStatus(msg, type = 'info') {
    const icon = type === 'error' ? '❌' : (type === 'success' ? '✅' : 'ℹ️');
    statusEl.innerHTML = `<span>${icon}</span> <span>${msg}</span>`;
    statusEl.style.borderLeftColor = type === 'error' ? '#ef4444' : (type === 'success' ? '#22c55e' : 'var(--accent)');
  }

  async function runBat(relPath, description) {
    updateStatus(`⏳ ${description}...`);
    try {
      await window.api.tweaks.run('tweaks/' + relPath, { wait: true });
      return true;
    } catch (e) {
      console.error(e);
      updateStatus(`Ошибка: ${description}. ${e.message}`, 'error');
      toast(`Ошибка: ${description}`, 'error');
      return false;
    }
  }

  // --- Логика выбора плана ---
  const planSelect = frame2.querySelector('#power-plan-select');
  const planDesc = frame2.querySelector('#plan-desc');
  const planDescText = frame2.querySelector('#plan-desc-text');

  planSelect.addEventListener('change', () => {
    const selectedPlan = POWER_PLANS.find(p => p.name === planSelect.value);
    if (selectedPlan) {
      planDescText.textContent = selectedPlan.desc;
      planDesc.style.display = 'block';
    } else {
      planDesc.style.display = 'none';
    }
  });

  // --- ИМПОРТ ПЛАНА (с проверкой на дубликаты внутри .bat) ---
  frame2.querySelector('#btn-import-plan').addEventListener('click', async () => {
    const selectedPlan = planSelect.value;
    if (!selectedPlan) {
      toast('Выберите план электропитания', 'error');
      return;
    }

    const safeName = selectedPlan.replace(/ /g, '_').replace(/\./g, '_');
    const batPath = `Электропитание/Популярные режимы электропитания/Import_${safeName}.bat`;

    const success = await runBat(batPath, `Импорт плана: ${selectedPlan}`);
    if (success) {
      updateStatus(`План "${selectedPlan}" обработан. Если он уже был в системе — дубликат не создан.`, 'success');
      toast('План обработан', 'success');
    }
  });

  // --- АКТИВАЦИЯ ПЛАНА (только активация, без импорта) ---
  frame2.querySelector('#btn-activate-plan').addEventListener('click', async () => {
    const selectedPlan = planSelect.value;
    if (!selectedPlan) {
      toast('Выберите план электропитания', 'error');
      return;
    }

    const safeName = selectedPlan.replace(/ /g, '_').replace(/\./g, '_');
    const batPath = `Электропитание/Популярные режимы электропитания/Activate_${safeName}.bat`;

    const success = await runBat(batPath, `Активация плана: ${selectedPlan}`);
    if (success) {
      updateStatus(`План "${selectedPlan}" активирован.`, 'success');
      toast('План активирован', 'success');
    }
  });

  // --- Быстрая активация из блока "установленные планы" ---
  frame3.querySelectorAll('button[data-plan]').forEach(btn => {
    btn.addEventListener('click', async () => {
      const planName = btn.dataset.plan;
      const safeName = planName.replace(/ /g, '_').replace(/\./g, '_');
      const batPath = `Электропитание/Популярные режимы электропитания/Activate_${safeName}.bat`;

      const success = await runBat(batPath, `Активация плана: ${planName}`);
      if (success) {
        updateStatus(`План "${planName}" активирован.`, 'success');
        toast('План активирован', 'success');
      }
    });
  });

  // --- Управление чекбоксами служб ---
  frame5.querySelector('#gm-svc-all').addEventListener('click', () => {
    frame5.querySelectorAll('.svc-cb').forEach(cb => cb.checked = true);
  });
  frame5.querySelector('#gm-svc-none').addEventListener('click', () => {
    frame5.querySelectorAll('.svc-cb').forEach(cb => cb.checked = false);
  });

  // --- ПРИМЕНИТЬ POWER KILLER ---
  frame4.querySelector('#btn-pk-apply').addEventListener('click', async () => {
    const checkedFiles = Array.from(frame4.querySelectorAll('.pk-cb:checked')).map(cb => cb.value);

    if (checkedFiles.length === 0) {
      toast('Выберите хотя бы одну функцию Power Killer', 'error');
      return;
    }

    for (const file of checkedFiles) {
      const featureName = PK_FEATURES.find(f => f.file === file)?.label || file;
      const success = await runBat(`GameMode/${file}`, featureName);
      if (!success) break;
    }

    updateStatus('Выбранные настройки питания применены.', 'success');
    toast('Настройки питания применены', 'success');
  });

  // --- ОТКАТИТЬ POWER KILLER ---
  frame4.querySelector('#btn-pk-revert').addEventListener('click', async () => {
    if (!confirm('Это сбросит все настройки электропитания к стандартным значениям Windows. Продолжить?')) return;

    const success = await runBat(SCRIPTS.pkRevert, 'Откат настроек электропитания');
    if (success) {
      updateStatus('Настройки питания сброшены к стандартным.', 'success');
      toast('Настройки питания откатаны', 'success');
    }
  });

  // --- ПРИМЕНИТЬ СЛУЖБЫ ---
  frame5.querySelector('#btn-svc-apply').addEventListener('click', async () => {
    const wantBackup = isSwitchOn();
    const checkedServices = Array.from(frame5.querySelectorAll('.svc-cb:checked')).map(cb => cb.value);

    if (checkedServices.length === 0) {
      toast('Выберите хотя бы одну службу для отключения', 'error');
      return;
    }

    if (wantBackup) {
      const backupOk = await runBat(SCRIPTS.backup, 'Создание бэкапа реестра служб');
      if (!backupOk) return;
    }

    const disableOk = await runBat(SCRIPTS.disableServices, 'Отключение выбранных служб');
    if (disableOk) {
      updateStatus(`Успешно отключено ${checkedServices.length} служб. ${wantBackup ? 'Бэкап сохранён.' : ''}`, 'success');
      toast('Службы оптимизированы', 'success');
    }
  });

  // --- ВОССТАНОВИТЬ СЛУЖБЫ ---
  frame5.querySelector('#btn-svc-restore').addEventListener('click', async () => {
    if (!confirm('Это восстановит исходное состояние всех служб из созданного ранее бэкапа. Продолжить?')) return;

    const restoreOk = await runBat(SCRIPTS.restore, 'Восстановление служб из бэкапа (.reg)');

    if (restoreOk) {
      updateStatus('Службы успешно восстановлены из бэкапа.', 'success');
      toast('Службы восстановлены', 'success');
    } else {
      updateStatus('Бэкап не найден. Применяется безопасный сброс (Start=3)...', 'info');
      await runBat(SCRIPTS.revertServicesFallback, 'Безопасный сброс служб в ручной режим');
    }
  });
}