import { state, clearCheckboxes, toast, Sound } from '../app.js';

let SERVICES_DATA = [];
let SERVICES_STATUS = {};

async function loadServicesData() {
  try {
    const res = await window.api.tabs.readJson('src/renderer/tabs/services-table.json');
    if (res && res.ok && res.data) {
      SERVICES_DATA = Array.isArray(res.data) ? res.data : [];
      console.log(`[services] загружено ${SERVICES_DATA.length} служб`);
      return true;
    }
    console.warn('[services] services-table.json не прочитан:', res?.error);
  } catch (e) {
    console.warn('[services] loadServicesData failed:', e);
  }
  return false;
}

async function loadServicesStatus() {
  try {
    const runRes = await window.api.tweaks.run('tweaks/Службы/Get_Services_Status.bat', { wait: true });
    console.log('[services] bat result:', runRes);

    const res = await window.api.tabs.readJson('extreme_data/services_status.json');
    console.log('[services] readJson result:', res);

    if (res && res.ok && res.data) {
      SERVICES_STATUS = res.data;
      console.log(`[services] loaded ${Object.keys(SERVICES_STATUS).length} statuses`);
      return true;
    }
    console.warn('[services] readJson failed:', res?.error, res?.data);
  } catch (e) {
    console.warn('[services] loadServicesStatus failed:', e);
  }
  return false;
}

function getStatusLabel(status) {
  switch (status) {
    case 'boot': return { text: 'Загрузка', color: 'var(--danger)', bg: 'color-mix(in srgb, var(--danger) 15%, transparent)' };
    case 'system': return { text: 'Система', color: 'var(--danger)', bg: 'color-mix(in srgb, var(--danger) 15%, transparent)' };
    case 'auto': return { text: 'Авто', color: 'var(--fg-muted)', bg: 'var(--bg-alt)' };
    case 'manual': return { text: 'Вручную', color: 'var(--accent)', bg: 'color-mix(in srgb, var(--accent) 15%, transparent)' };
    case 'disabled': return { text: 'Откл', color: 'var(--success)', bg: 'color-mix(in srgb, var(--success) 15%, transparent)' };
    case 'notfound': return { text: 'Нет', color: 'var(--fg-muted)', bg: 'var(--bg-alt)' };
    default: return { text: '—', color: 'var(--fg-muted)', bg: 'var(--bg-alt)' };
  }
}

function statusToStartValue(status) {
  switch (status) {
    case 'boot': return '0';
    case 'system': return '1';
    case 'auto': return '2';
    case 'manual': return '3';
    case 'disabled': return '4';
    case 'notfound': return '';
    default: return '3';
  }
}

function startValueToStatus(val) {
  switch (val) {
    case '0': return 'boot';
    case '1': return 'system';
    case '2': return 'auto';
    case '3': return 'manual';
    case '4': return 'disabled';
    default: return 'unknown';
  }
}

export async function renderServices() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = '';
  content.innerHTML = '';
  clearCheckboxes();

  if (!SERVICES_DATA.length) {
    await loadServicesData();
  }

  const wrap = document.createElement('div');
  wrap.className = 'apps-page';
  content.appendChild(wrap);

  // ==================== ШАПКА ====================
  const header = document.createElement('div');
  header.className = 'apps-header';
  header.innerHTML = `
    <div class="apps-title">
      <span class="apps-title-icon">⚙️</span>
      <span>Управление службами Windows</span>
      <span class="apps-count" id="svc-count">${SERVICES_DATA.length}</span>
    </div>
  `;
  wrap.appendChild(header);

  // ==================== СЕКЦИЯ 1: ОПИСАНИЕ + ДОКУМЕНТАЦИЯ + БЭКАП ====================
  const introSection = document.createElement('div');
  introSection.className = 'apps-detected-section';
  introSection.style.background = 'color-mix(in srgb, var(--card) 60%, transparent)';
  introSection.style.borderColor = 'color-mix(in srgb, var(--border) 30%, transparent)';

  introSection.innerHTML = `
    <div class="section-title">🛡️ Безопасная оптимизация служб</div>
    <p class="muted" style="margin:0 0 16px 0; line-height:1.6;">
      Этот модуль позволяет выборочно отключать фоновые службы Windows, которые не влияют на критически важные функции
      (питание 🔋, аккумулятор, тачпад, базовая сеть 🌐, темы 🎨, звук 🔊).
      Все изменения полностью обратимы.
      <br>
      <span style="color:var(--accent);">💡 Совет:</span> перед массовым отключением рекомендуется создать резервную копию текущего состояния реестра служб.
    </p>

    <details style="margin-bottom:16px; background:var(--bg-alt); border:1px solid var(--border); border-radius:8px; padding:12px 14px;">
      <summary style="cursor:pointer; font-weight:600; color:var(--fg); user-select:none;">
        📖 Что означают типы запуска служб
      </summary>
      <div style="margin-top:12px; font-size:13px; line-height:1.7; color:var(--fg-muted);">
        <p style="margin:0 0 10px 0;">
          Тип запуска определяет, <b>когда и как</b> Windows загружает службу. Значение хранится в реестре
          (<code>HKLM\\SYSTEM\\CurrentControlSet\\Services\\&lt;Имя&gt;\\Start</code>)
          и дублируется командой <code>sc config</code>.
        </p>
        <table style="width:100%; border-collapse:collapse; font-size:13px;">
          <thead>
            <tr style="border-bottom:1px solid var(--border);">
              <th style="text-align:left; padding:6px 8px; width:140px;">Тип</th>
              <th style="text-align:left; padding:6px 8px; width:70px;">Start</th>
              <th style="text-align:left; padding:6px 8px;">Что означает</th>
            </tr>
          </thead>
          <tbody>
            <tr style="border-bottom:1px solid var(--border);">
              <td style="padding:6px 8px; color:var(--danger); font-weight:600;">Загрузка</td>
              <td style="padding:6px 8px; font-family:Consolas,Monaco,monospace;">0</td>
              <td style="padding:6px 8px;">
                <b>Boot.</b> Драйвер загружается загрузчиком Windows <b>до старта ядра</b>.
                Используется только драйверами загрузочных устройств (дисковые контроллеры, файловые системы).
                Для обычных служб недоступен.
              </td>
            </tr>
            <tr style="border-bottom:1px solid var(--border);">
              <td style="padding:6px 8px; color:var(--danger); font-weight:600;">Система</td>
              <td style="padding:6px 8px; font-family:Consolas,Monaco,monospace;">1</td>
              <td style="padding:6px 8px;">
                <b>System.</b> Драйвер загружается ядром на раннем этапе инициализации,
                до запуска пользовательских служб. Тоже только для драйверов.
                Для Win32-служб обычно не применяется.
              </td>
            </tr>
            <tr style="border-bottom:1px solid var(--border);">
              <td style="padding:6px 8px; font-weight:600;">Авто</td>
              <td style="padding:6px 8px; font-family:Consolas,Monaco,monospace;">2</td>
              <td style="padding:6px 8px;">
                <b>Automatic.</b> Служба запускается <b>автоматически при загрузке Windows</b>,
                без участия пользователя. Стандартный режим для большинства системных служб.
                Может иметь «отложенный старт» (delayed auto start) — тогда она стартует чуть позже, чтобы ускорить вход.
              </td>
            </tr>
            <tr style="border-bottom:1px solid var(--border);">
              <td style="padding:6px 8px; color:var(--accent); font-weight:600;">Вручную</td>
              <td style="padding:6px 8px; font-family:Consolas,Monaco,monospace;">3</td>
              <td style="padding:6px 8px;">
                <b>Manual.</b> Служба <b>не запускается сама</b> при загрузке, но стартует
                по требованию: когда её вызывает другая служба, приложение или триггер
                (например, подключение устройства или вход в систему).
                Это <b>не отключение</b> — служба полностью работоспособна, просто ждёт вызова.
              </td>
            </tr>
            <tr>
              <td style="padding:6px 8px; color:var(--success); font-weight:600;">Отключено</td>
              <td style="padding:6px 8px; font-family:Consolas,Monaco,monospace;">4</td>
              <td style="padding:6px 8px;">
                <b>Disabled.</b> Служба <b>не может быть запущена</b> ни автоматически,
                ни вручную, ни по требованию. При попытке запуска Windows вернёт ошибку.
                Используется для служб, которые точно не нужны.
              </td>
            </tr>
          </tbody>
        </table>
        <p style="margin:12px 0 0 0; font-size:12px; color:var(--fg-muted);">
          ⚠️ <b>Важно:</b> «Вручную» — самый безопасный способ отключить ненужную активность.
          Служба не грузит систему в фоне, но если какое-то приложение её запросит, она запустится
          и всё будет работать. «Отключено» — жёсткая мера: если служба кому-то понадобится,
          это приложение или компонент Windows сломается. Для телеметрии, поиска и подобных
          фоновых служб обычно достаточно «Вручную».
        </p>
      </div>
    </details>

    <div style="display:flex; gap:12px; flex-wrap:wrap;">
      <button class="btn" id="btn-create-backup" style="background:var(--accent); color:white; font-weight:600;">
        💾 Создать бэкап служб
      </button>
      <button class="btn danger" id="btn-restore-backup">
        ↩ Восстановить из бэкапа
      </button>
      <button class="btn" id="btn-refresh-status" style="margin-left:auto;">
        🔄 Обновить статусы
      </button>
    </div>
    <div id="backup-status" style="margin-top:12px; font-size:13px; color:var(--fg-muted);"></div>
  `;
  wrap.appendChild(introSection);

  // ==================== СЕКЦИЯ 2: ПОИСК + УПРАВЛЕНИЕ ====================
  const controlsSection = document.createElement('div');
  controlsSection.className = 'apps-detected-section';
  controlsSection.style.background = 'color-mix(in srgb, var(--card) 60%, transparent)';
  controlsSection.style.borderColor = 'color-mix(in srgb, var(--border) 30%, transparent)';
  controlsSection.style.marginTop = '16px';

  controlsSection.innerHTML = `
    <div class="section-title">🔍 Поиск и массовое управление</div>
    <div style="display:flex; gap:12px; flex-wrap:wrap; align-items:center;">
      <div style="flex:1; min-width:250px; position:relative;">
        <span style="position:absolute; left:12px; top:50%; transform:translateY(-50%); color:var(--fg-muted);">🔎</span>
        <input type="text" id="svc-search" placeholder="Поиск по названию или описанию..."
               style="width:100%; padding:10px 10px 10px 36px; background:var(--bg-alt); color:var(--fg); border:1px solid var(--border); border-radius:8px; font-size:14px; outline:none;">
      </div>
      <button class="btn" id="btn-select-all">✅ Выбрать все</button>
      <button class="btn" id="btn-deselect-all">❌ Снять все</button>
      <button class="btn danger" id="btn-disable-selected">⏹ Отключить выбранные</button>
      <button class="btn success" id="btn-enable-selected">▶ Включить выбранные</button>
    </div>
    <div id="svc-status" style="margin-top:12px; font-size:13px; color:var(--fg-muted); border-left:3px solid var(--accent); padding-left:12px;">
      ℹ️ Готов к работе. Выберите службы и нажмите нужную кнопку.
    </div>
  `;
  wrap.appendChild(controlsSection);

  // ==================== СЕКЦИЯ 3: ТАБЛИЦА СЛУЖБ ====================
  const tableSection = document.createElement('div');
  tableSection.className = 'apps-detected-section';
  tableSection.style.background = 'color-mix(in srgb, var(--card) 60%, transparent)';
  tableSection.style.borderColor = 'color-mix(in srgb, var(--border) 30%, transparent)';
  tableSection.style.marginTop = '16px';

  const tableTitle = document.createElement('div');
  tableTitle.className = 'section-title';
  tableTitle.textContent = `📋 Список доступных для управления служб (${SERVICES_DATA.length})`;
  tableSection.appendChild(tableTitle);

  const tableWrap = document.createElement('div');
  tableWrap.style.cssText = 'overflow-x:auto;';
  tableSection.appendChild(tableWrap);

  const table = document.createElement('table');
  table.style.cssText = 'width:100%; border-collapse:collapse; font-size:13px;';
  table.innerHTML = `
    <thead>
      <tr style="background:var(--bg); border-bottom:2px solid var(--border);">
        <th style="padding:12px 8px; text-align:center; width:40px;">☑️</th>
        <th style="padding:12px 8px; text-align:left; width:40px;"></th>
        <th style="padding:12px 8px; text-align:left;">Служба</th>
        <th style="padding:12px 8px; text-align:left;">Описание</th>
        <th style="padding:12px 8px; text-align:center; width:100px;">Статус</th>
        <th style="padding:12px 8px; text-align:center; width:260px;">Тип запуска</th>
        <th style="padding:12px 8px; text-align:left;">Отключена в</th>
      </tr>
    </thead>
    <tbody id="svc-table-body"></tbody>
  `;
  tableWrap.appendChild(table);
  wrap.appendChild(tableSection);

  // ==================== РЕНДЕР СТРОК ТАБЛИЦЫ ====================
  const tbody = table.querySelector('#svc-table-body');
  const searchInput = wrap.querySelector('#svc-search');

  function renderTableRows(filter = '') {
    tbody.innerHTML = '';
    const lowerFilter = filter.toLowerCase().trim();

    const filtered = SERVICES_DATA.filter(s =>
      s.name.toLowerCase().includes(lowerFilter) ||
      s.desc.toLowerCase().includes(lowerFilter)
    );

    if (filtered.length === 0) {
      tbody.innerHTML = `<tr><td colspan="7" style="padding:40px; text-align:center; color:var(--fg-muted);">Ничего не найдено</td></tr>`;
      return;
    }

    filtered.forEach(svc => {
      const status = SERVICES_STATUS[svc.name] || 'unknown';
      const statusInfo = getStatusLabel(status);
      const curVal = statusToStartValue(status);
      const notFound = status === 'notfound';

      const buildsBadges = (svc.builds || []).map(b =>
        `<span style="font-size:10px; font-weight:600; color:var(--accent); background:color-mix(in srgb, var(--accent) 10%, transparent); border:1px solid color-mix(in srgb, var(--accent) 30%, transparent); padding:2px 6px; border-radius:4px; margin-right:4px; margin-bottom:4px; display:inline-block;">${b}</span>`
      ).join('');

      const tr = document.createElement('tr');
      tr.style.cssText = 'border-bottom:1px solid var(--border); transition:background .15s;';
      tr.onmouseenter = () => tr.style.background = 'var(--bg-alt)';
      tr.onmouseleave = () => tr.style.background = 'transparent';

      tr.innerHTML = `
        <td style="padding:12px 8px; text-align:center;">
          <input type="checkbox" class="svc-cb" value="${svc.name}" ${svc.default ? 'checked' : ''} style="width:16px; height:16px; accent-color:var(--accent); cursor:pointer;">
        </td>
        <td style="padding:12px 8px; text-align:center; font-size:20px;">${svc.icon || '⚙️'}</td>
        <td style="padding:12px 8px; font-family:Consolas,Monaco,monospace; font-weight:600; font-size:12px; word-break:break-all;">${svc.name}</td>
        <td style="padding:12px 8px; color:var(--fg-muted); font-size:12px; line-height:1.4;">${svc.desc}</td>
        <td style="padding:12px 8px; text-align:center;">
          <span class="svc-status-badge" data-svc="${svc.name}" style="font-size:11px; font-weight:600; padding:4px 8px; border-radius:4px; background:${statusInfo.bg}; color:${statusInfo.color}; border:1px solid ${statusInfo.color};">
            ${statusInfo.text}
          </span>
        </td>
        <td style="padding:12px 8px; text-align:center; white-space:nowrap;">
          <select class="svc-startup-select" data-svc="${svc.name}" ${notFound ? 'disabled' : ''} style="padding:6px 8px; font-size:12px; background:var(--bg-alt); color:var(--fg); border:1px solid var(--border); border-radius:6px; cursor:pointer; min-width:110px;">
            <option value="0" ${curVal === '0' ? 'selected' : ''}>Загрузка</option>
            <option value="1" ${curVal === '1' ? 'selected' : ''}>Система</option>
            <option value="2" ${curVal === '2' ? 'selected' : ''}>Авто</option>
            <option value="3" ${curVal === '3' ? 'selected' : ''}>Вручную</option>
            <option value="4" ${curVal === '4' ? 'selected' : ''}>Отключено</option>
          </select>
          <button class="btn svc-apply-btn" data-svc="${svc.name}" ${notFound ? 'disabled' : ''} style="padding:6px 10px; font-size:11px; margin-left:6px; background:color-mix(in srgb, var(--accent) 15%, transparent); border-color:var(--accent); color:var(--accent); font-weight:600;">✔ Применить</button>
        </td>
        <td style="padding:12px 8px;">${buildsBadges}</td>
      `;
      tbody.appendChild(tr);
    });

    // Обработчик кнопки «Применить» в строке
    tbody.querySelectorAll('.svc-apply-btn').forEach(btn => {
      btn.addEventListener('click', async (e) => {
        e.stopPropagation();
        if (btn.disabled) return;

        const svcName = btn.dataset.svc;
        const select = tbody.querySelector(`.svc-startup-select[data-svc="${svcName}"]`);
        if (!select) return;

        const newStart = select.value;
        const oldStatus = SERVICES_STATUS[svcName] || 'unknown';
        const oldVal = statusToStartValue(oldStatus);

        if (newStart === oldVal) {
          toast(`${svcName}: тип запуска не изменился`, 'error');
          return;
        }

        btn.disabled = true;
        select.disabled = true;
        Sound.click();

        try {
          await window.api.tweaks.run('tweaks/Службы/Set_Service_Startup.bat', {
            wait: true,
            args: `${svcName},${newStart}`
          });

          Sound.success();

          const newStatus = startValueToStatus(newStart);
          SERVICES_STATUS[svcName] = newStatus;

          const badge = tbody.querySelector(`.svc-status-badge[data-svc="${svcName}"]`);
          if (badge) {
            const info = getStatusLabel(newStatus);
            badge.textContent = info.text;
            badge.style.background = info.bg;
            badge.style.color = info.color;
            badge.style.borderColor = info.color;
          }

          const actionText = newStart === '4'
            ? 'отключена и остановлена'
            : (newStart === '2' || newStart === '3')
              ? 'включена и запущена'
              : 'тип запуска изменён';
          toast(`${svcName}: служба ${actionText}`, 'success');
        } catch (err) {
          Sound.error();
          toast(`Ошибка изменения ${svcName}`, 'error');
          select.value = oldVal || '3';
        } finally {
          btn.disabled = false;
          select.disabled = false;
        }
      });
    });
  }

  // Инициализация: загружаем статусы и рендерим таблицу
  await loadServicesStatus();
  renderTableRows();

  // ==================== ОБРАБОТЧИКИ СОБЫТИЙ ====================

  searchInput.addEventListener('input', (e) => {
    renderTableRows(e.target.value);
  });

  wrap.querySelector('#btn-select-all').addEventListener('click', () => {
    Sound.click();
    tbody.querySelectorAll('.svc-cb').forEach(cb => cb.checked = true);
  });

  wrap.querySelector('#btn-deselect-all').addEventListener('click', () => {
    Sound.click();
    tbody.querySelectorAll('.svc-cb').forEach(cb => cb.checked = false);
  });

  wrap.querySelector('#btn-refresh-status').addEventListener('click', async () => {
    Sound.click();
    const statusEl = wrap.querySelector('#svc-status');
    statusEl.innerHTML = '⏳ Обновление статусов служб...';
    statusEl.style.borderLeftColor = 'var(--accent)';
    try {
      await loadServicesStatus();
      renderTableRows(searchInput.value);
      statusEl.innerHTML = '✅ Статусы обновлены.';
      statusEl.style.borderLeftColor = 'var(--success)';
      toast('Статусы служб обновлены', 'success');
      Sound.success();
    } catch (e) {
      statusEl.innerHTML = '❌ Ошибка обновления статусов.';
      statusEl.style.borderLeftColor = 'var(--danger)';
      toast('Ошибка обновления', 'error');
      Sound.error();
    }
  });

  wrap.querySelector('#btn-create-backup').addEventListener('click', async () => {
    Sound.click();
    const statusEl = wrap.querySelector('#backup-status');
    statusEl.textContent = '⏳ Создание бэкапа реестра служб...';
    statusEl.style.color = 'var(--fg)';
    try {
      await window.api.tweaks.run('tweaks/Службы/Backup_Services.bat', { wait: true });
      statusEl.textContent = '✅ Бэкап успешно создан (Services_Backup.reg)';
      statusEl.style.color = 'var(--success)';
      toast('Бэкап служб создан', 'success');
      Sound.success();
    } catch (e) {
      statusEl.textContent = '❌ Ошибка создания бэкапа. Запустите приложение от имени администратора.';
      statusEl.style.color = 'var(--danger)';
      toast('Ошибка бэкапа', 'error');
      Sound.error();
    }
  });

  wrap.querySelector('#btn-restore-backup').addEventListener('click', async () => {
    if (!confirm('Это восстановит исходное состояние всех служб из файла Services_Backup.reg. Продолжить?')) return;
    Sound.click();
    const statusEl = wrap.querySelector('#backup-status');
    statusEl.textContent = '⏳ Восстановление из бэкапа...';
    statusEl.style.color = 'var(--fg)';
    try {
      await window.api.tweaks.run('tweaks/Службы/Restore_Services.bat', { wait: true });
      statusEl.textContent = '✅ Службы успешно восстановлены из бэкапа.';
      statusEl.style.color = 'var(--success)';
      toast('Службы восстановлены', 'success');
      Sound.success();
      await loadServicesStatus();
      renderTableRows(searchInput.value);
    } catch (e) {
      statusEl.textContent = '❌ Ошибка восстановления. Возможно, файл бэкапа отсутствует.';
      statusEl.style.color = 'var(--danger)';
      toast('Ошибка восстановления', 'error');
      Sound.error();
    }
  });

  wrap.querySelector('#btn-disable-selected').addEventListener('click', async () => {
    const checked = Array.from(tbody.querySelectorAll('.svc-cb:checked')).map(cb => cb.value);
    if (checked.length === 0) {
      toast('Выберите хотя бы одну службу для отключения', 'error');
      return;
    }
    if (!confirm(`Вы действительно хотите отключить ${checked.length} выбранных служб? Это действие можно будет отменить через бэкап.`)) return;

    Sound.click();
    const statusEl = wrap.querySelector('#svc-status');
    statusEl.innerHTML = `⏳ Отключение ${checked.length} служб...`;
    statusEl.style.borderLeftColor = 'var(--accent)';

    try {
      await window.api.tweaks.run('tweaks/Службы/Disable_Selected_Services.bat', { wait: true, args: checked.join(',') });
      statusEl.innerHTML = `✅ Успешно отключено ${checked.length} служб.`;
      statusEl.style.borderLeftColor = 'var(--success)';
      toast(`Отключено ${checked.length} служб`, 'success');
      Sound.success();

      await loadServicesStatus();
      renderTableRows(searchInput.value);
    } catch (e) {
      statusEl.innerHTML = `❌ Ошибка при отключении служб.`;
      statusEl.style.borderLeftColor = 'var(--danger)';
      toast('Ошибка применения', 'error');
      Sound.error();
    }
  });

  wrap.querySelector('#btn-enable-selected').addEventListener('click', async () => {
    const checked = Array.from(tbody.querySelectorAll('.svc-cb:checked')).map(cb => cb.value);
    if (checked.length === 0) {
      toast('Выберите хотя бы одну службу для включения', 'error');
      return;
    }
    if (!confirm(`Вы действительно хотите включить ${checked.length} выбранных служб?`)) return;

    Sound.click();
    const statusEl = wrap.querySelector('#svc-status');
    statusEl.innerHTML = `⏳ Включение ${checked.length} служб...`;
    statusEl.style.borderLeftColor = 'var(--accent)';

    try {
      await window.api.tweaks.run('tweaks/Службы/Enable_Selected_Services.bat', { wait: true, args: checked.join(',') });
      statusEl.innerHTML = `✅ Успешно включено ${checked.length} служб.`;
      statusEl.style.borderLeftColor = 'var(--success)';
      toast(`Включено ${checked.length} служб`, 'success');
      Sound.success();

      await loadServicesStatus();
      renderTableRows(searchInput.value);
    } catch (e) {
      statusEl.innerHTML = `❌ Ошибка при включении служб.`;
      statusEl.style.borderLeftColor = 'var(--danger)';
      toast('Ошибка применения', 'error');
      Sound.error();
    }
  });
}