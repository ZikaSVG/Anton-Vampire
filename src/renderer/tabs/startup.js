import { state, clearCheckboxes, toast, Sound } from '../app.js';

const TABS = [
  { id: 'all',      label: '📋 Все' },
  { id: 'folders',  label: '📁 Папки' },
  { id: 'registry', label: '🔑 Реестр' },
  { id: 'tasks',    label: '⏰ Планировщик' },
  { id: 'services', label: '⚙ Службы' }
];

const SCOPE_LABEL = { user: 'Пользователь', system: 'Система' };

const TYPE_META = {
  folder:   { icon: '📁', label: 'Папка' },
  registry: { icon: '🔑', label: 'Реестр' },
  task:     { icon: '⏰', label: 'Задача' },
  service:  { icon: '⚙',  label: 'Служба' }
};

const CATEGORY_META = {
  av:        { icon: '🛡', label: 'Антивирус',    color: 'green'  },
  telemetry: { icon: '📡', label: 'Телеметрия',   color: 'orange' },
  office:    { icon: '📄', label: 'Office',        color: 'blue'   },
  edge:      { icon: '🌊', label: 'Microsoft Edge', color: 'teal'  },
  ms:        { icon: '🪟', label: 'Программа',     color: 'purple' }
};

const MODE_KEY = 'startup.safeMode';

function readSafeMode() {
  const raw = localStorage.getItem(MODE_KEY);
  return raw === null ? true : raw === 'true';
}

function writeSafeMode(v) {
  localStorage.setItem(MODE_KEY, String(!!v));
}

export async function renderStartup() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = '';
  content.innerHTML = '';
  clearCheckboxes();

  let safeMode = readSafeMode();

  const wrap = document.createElement('div');
  wrap.className = 'startup-page';
  content.appendChild(wrap);

  /* HEADER */
  const header = document.createElement('div');
  header.className = 'apps-header';
  header.innerHTML = `
    <div class="apps-title">
      <span class="apps-title-icon">🚀</span>
      <span>Автозагрузка</span>
      <span class="apps-count" id="startup-count">…</span>
    </div>
    <div class="apps-toolbar">
      <div class="startup-mode-switch" id="mode-switch">
        <button type="button" class="mode-btn ${safeMode ? 'active' : ''}" data-mode="safe">
          🛡 Безопасный
        </button>
        <button type="button" class="mode-btn ${!safeMode ? 'active' : ''}" data-mode="advanced">
          ⚙ Расширенный
        </button>
      </div>
      <input id="startup-search" type="search" placeholder="🔍 Поиск..." class="startup-search">
      <button class="btn" id="startup-refresh">🔄 Обновить</button>
    </div>
  `;
  wrap.appendChild(header);

  const subNav = document.createElement('div');
  subNav.className = 'sub-tabs-nav';
  wrap.appendChild(subNav);

  let currentTab = 'all';
  for (const t of TABS) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'sub-tab-btn' + (t.id === currentTab ? ' active' : '');
    btn.textContent = t.label;
    btn.addEventListener('click', () => {
      Sound.click();
      subNav.querySelectorAll('.sub-tab-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      currentTab = t.id;
      renderList();
    });
    subNav.appendChild(btn);
  }

  const summary = document.createElement('div');
  summary.className = 'startup-summary';
  wrap.appendChild(summary);

  const host = document.createElement('div');
  host.className = 'startup-list';
  wrap.appendChild(host);

  let lastData = null;
  let searchQuery = '';
  const busyIds = new Set();

  header.querySelectorAll('.mode-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const newMode = btn.dataset.mode === 'safe';
      if (newMode === safeMode) return;
      Sound.click();
      if (!newMode) {
        const ok = confirm(
          '⚠️ Расширенный режим\n\n' +
          'Ты увидишь все пользовательские и большинство системных служб и задач.\n\n' +
          'Критичные для Windows компоненты остаются скрытыми, но остальные можно случайно ' +
          'сломать.\n\nПродолжить?'
        );
        if (!ok) return;
      }
      safeMode = newMode;
      writeSafeMode(safeMode);
      header.querySelectorAll('.mode-btn').forEach(b => {
        b.classList.toggle('active', (b.dataset.mode === 'safe') === safeMode);
      });
      renderList();
      Sound.success();
    });
  });

  header.querySelector('#startup-search').addEventListener('input', (e) => {
    searchQuery = e.target.value.toLowerCase();
    renderList();
  });

  /* LOAD — читает кэш, если он есть. force=true → игнорирует кэш. */
  async function load(force = false) {
    try {
      if (!force && state?.dataCache?.startup) {
        lastData = state.dataCache.startup;
        console.log('[startup] данные из кэша');
      } else {
        lastData = await window.api.startup.list(true);
        state.dataCache.startup = lastData;
        console.log('[startup] данные загружены самостоятельно');
      }
      renderSummary();
      renderList();
    } catch (e) {
      console.error('[startup] load failed:', e);
      if (!lastData) host.innerHTML = `<div class="muted" style="padding:20px">Ошибка: ${escapeHtml(e.message)}</div>`;
    }
  }

  function renderSummary() {
    if (!lastData) return;
    const c = lastData.counts || {};
    const total = (c.folders || 0) + (c.registry || 0) + (c.tasks || 0) + (c.services || 0);
    const el = header.querySelector('#startup-count');
    if (el) el.textContent = `${total} элементов`;

    summary.innerHTML = `
      <div class="startup-summary-card">
        <span class="startup-summary-icon">📁</span>
        <span class="startup-summary-label">Папки</span>
        <span class="startup-summary-value">${c.folders || 0}</span>
      </div>
      <div class="startup-summary-card">
        <span class="startup-summary-icon">🔑</span>
        <span class="startup-summary-label">Реестр</span>
        <span class="startup-summary-value">${c.registry || 0}</span>
      </div>
      <div class="startup-summary-card">
        <span class="startup-summary-icon">⏰</span>
        <span class="startup-summary-label">Задачи</span>
        <span class="startup-summary-value">${c.tasks || 0}</span>
      </div>
      <div class="startup-summary-card">
        <span class="startup-summary-icon">⚙</span>
        <span class="startup-summary-label">Службы</span>
        <span class="startup-summary-value">${c.services || 0}</span>
      </div>
    `;
  }

  function renderList() {
    if (!lastData) return;
    host.innerHTML = '';

    const items = collectItems();
    const filtered = filterItems(items, searchQuery);

    if (!filtered.length) {
      host.innerHTML = `<div class="apps-empty">
        ${safeMode ? 'Нет безопасных элементов для отключения. Попробуй расширенный режим.' : 'Ничего не найдено'}
      </div>`;
      return;
    }

    const groups = groupBySource(filtered);

    for (const g of groups) {
      const section = document.createElement('section');
      section.className = 'startup-group';

      const title = document.createElement('div');
      title.className = 'startup-group-title';
      title.innerHTML = `
        <span>${g.icon} ${escapeHtml(g.title)}</span>
        <span class="muted" style="font-weight:400;font-size:11px">· ${g.items.length}</span>
      `;
      section.appendChild(title);

      const list = document.createElement('div');
      list.className = 'startup-rows';
      for (const it of g.items) {
        const row = makeRow(it);
        row.dataset.id = it.id;
        list.appendChild(row);
      }
      section.appendChild(list);
      host.appendChild(section);
    }
  }

  function collectItems() {
    const out = [];
    const d = lastData;
    if (!d) return out;

    if (d.folders) {
      for (const f of d.folders.user)   out.push({ ...f, sourceKey: 'folder-user',   sourceTitle: 'Папка автозагрузки (пользователь)', sourceIcon: '📁', scopeLabel: 'Пользователь' });
      for (const f of d.folders.common) out.push({ ...f, sourceKey: 'folder-system', sourceTitle: 'Папка автозагрузки (система)',      sourceIcon: '📁', scopeLabel: 'Система' });
    }
    if (d.registry) {
      for (const r of d.registry) {
        out.push({ ...r, sourceKey: 'registry-' + r.scope, sourceTitle: `Реестр (${SCOPE_LABEL[r.scope] || r.scope})`, sourceIcon: '🔑', scopeLabel: SCOPE_LABEL[r.scope] || r.scope });
      }
    }
    if (d.tasks) {
      for (const t of d.tasks) out.push({ ...t, sourceKey: 'task', sourceTitle: 'Планировщик заданий', sourceIcon: '⏰', scopeLabel: 'Система' });
    }
    if (d.services) {
      for (const s of d.services) out.push({ ...s, sourceKey: 'service', sourceTitle: 'Службы', sourceIcon: '⚙', scopeLabel: 'Система' });
    }
    return out;
  }

  function filterItems(items, q) {
    let list = items;

    if (safeMode && (currentTab === 'tasks' || currentTab === 'services' || currentTab === 'all')) {
      list = list.filter(i => {
        if (i.type === 'folder' || i.type === 'registry') return true;
        return i.safe === true;
      });
    }

    if (currentTab === 'folders')  list = list.filter(i => i.type === 'folder');
    if (currentTab === 'registry') list = list.filter(i => i.type === 'registry');
    if (currentTab === 'tasks')    list = list.filter(i => i.type === 'task');
    if (currentTab === 'services') list = list.filter(i => i.type === 'service');

    if (q) {
      list = list.filter(i => {
        const hay = [i.name, i.displayName, i.command, i.value, i.taskPath, i.author, i.description]
          .filter(Boolean).join(' ').toLowerCase();
        return hay.includes(q);
      });
    }
    return list;
  }

  function groupBySource(items) {
    const map = new Map();
    for (const it of items) {
      if (!map.has(it.sourceKey)) {
        map.set(it.sourceKey, { key: it.sourceKey, title: it.sourceTitle, icon: it.sourceIcon, items: [] });
      }
      map.get(it.sourceKey).items.push(it);
    }
    return [...map.values()];
  }

  function makeRow(item) {
    const row = document.createElement('div');
    row.className = 'startup-row' + (item.enabled ? '' : ' disabled');
    row.dataset.id = item.id;
    row.dataset.enabled = item.enabled ? '1' : '0';
    row.dataset.type = item.type;

    const isBusy = busyIds.has(item.id);
    if (isBusy) row.classList.add('busy');

    if (item.category && CATEGORY_META[item.category]) {
      row.classList.add('cat-' + item.category);
    }

    const meta = TYPE_META[item.type] || { icon: '❔', label: item.type };

    const icon = document.createElement('div');
    icon.className = 'startup-icon';
    if (item.icon) {
      const img = document.createElement('img');
      img.src = item.icon;
      img.alt = '';
      img.className = 'startup-icon-img';
      img.draggable = false;
      img.onerror = () => { img.remove(); icon.textContent = meta.icon; };
      icon.appendChild(img);
    } else {
      icon.textContent = meta.icon;
    }

    const main = document.createElement('div');
    main.className = 'startup-main';

    const nameRow = document.createElement('div');
    nameRow.className = 'startup-name-row';

    const name = document.createElement('span');
    name.className = 'startup-name';
    name.textContent = item.displayName || item.name || '(без имени)';
    name.title = item.name || '';
    nameRow.appendChild(name);

    const badge = document.createElement('span');
    badge.className = 'startup-badge';
    badge.textContent = meta.label;
    nameRow.appendChild(badge);

    if (item.category && CATEGORY_META[item.category]) {
      const cm = CATEGORY_META[item.category];
      const catBadge = document.createElement('span');
      catBadge.className = 'startup-badge cat-badge cat-' + item.category;
      catBadge.textContent = `${cm.icon} ${cm.label}`;
      nameRow.appendChild(catBadge);
    }

    if (item.scope) {
      const sc = document.createElement('span');
      sc.className = 'startup-scope startup-scope-' + item.scope;
      sc.textContent = SCOPE_LABEL[item.scope] || item.scope;
      nameRow.appendChild(sc);
    }

    main.appendChild(nameRow);

    const details = document.createElement('div');
    details.className = 'startup-details';
    if (item.type === 'folder') details.textContent = item.path || '';
    else if (item.type === 'registry') details.textContent = item.value || '';
    else if (item.type === 'task') details.textContent = item.command ? `→ ${item.command}`.trim() : '';
    else if (item.type === 'service') details.textContent = item.command || item.description || '';
    details.title = details.textContent;
    main.appendChild(details);

    const status = document.createElement('div');
    status.className = 'startup-status' + (item.enabled ? ' on' : ' off');
    status.textContent = item.enabled ? 'Включено' : 'Отключено';
    if (item.type === 'service' && item.startMode) {
      status.textContent = item.enabled
        ? (String(item.startMode).toLowerCase() === 'auto' ? 'Авто' : 'Вручную')
        : 'Отключено';
    }
    if (item.type === 'task' && item.state) {
      status.textContent = item.enabled ? item.state : 'Disabled';
    }
    main.appendChild(status);

    const actions = document.createElement('div');
    actions.className = 'startup-actions';

    if (item.canToggle) {
      const switchEl = document.createElement('div');
      switchEl.className = 'startup-switch'
        + (item.enabled ? ' on' : '')
        + (isBusy ? ' busy' : '');
      switchEl.title = item.enabled ? 'Отключить' : 'Включить';
      switchEl.setAttribute('role', 'switch');
      switchEl.setAttribute('aria-checked', String(!!item.enabled));

      if (isBusy) switchEl.classList.add('disabled');

      const switchThumb = document.createElement('div');
      switchThumb.className = 'startup-switch-thumb';
      switchEl.appendChild(switchThumb);

      switchEl.addEventListener('click', async (e) => {
        e.stopPropagation();
        if (busyIds.has(item.id)) return;
        const row = switchEl.closest('.startup-row');
        const isEnabledNow = row && row.dataset.enabled === '1';
        await doAction(isEnabledNow ? 'disable' : 'enable', item, switchEl);
      });

      actions.appendChild(switchEl);
    } else {
      const lock = document.createElement('span');
      lock.className = 'startup-lock';
      lock.textContent = '🔒';
      lock.title = item.protected
        ? 'Критичный компонент Windows — изменение запрещено'
        : 'Нельзя изменить';
      actions.appendChild(lock);
    }

    if (item.canDelete) {
      const delBtn = document.createElement('button');
      delBtn.type = 'button';
      delBtn.className = 'startup-btn delete';
      delBtn.textContent = '🗑';
      delBtn.title = 'Удалить';
      delBtn.disabled = isBusy;
      delBtn.addEventListener('click', async (e) => {
        e.stopPropagation();
        const what = item.type === 'registry' ? `значение «${item.name}» из реестра`
          : item.type === 'task' ? `задачу «${item.name}»` : `«${item.name}»`;
        if (!confirm(`Удалить ${what}?\n\nЭто действие нельзя отменить.`)) return;
        await doAction('delete', item, delBtn);
      });
      actions.appendChild(delBtn);
    } else if (item.type === 'service' || item.protected) {
      const lock = document.createElement('span');
      lock.className = 'startup-lock';
      lock.textContent = '🔒';
      lock.title = item.type === 'service'
        ? 'Службы нельзя удалять — только отключать'
        : 'Критичный элемент — удаление запрещено';
      actions.appendChild(lock);
    }

    row.append(icon, main, actions);
    return row;
  }

  async function doAction(action, item, control) {
    if (busyIds.has(item.id)) return;

    if (item.system === true) {
      Sound.error();
      toast('🔒 Критичный компонент Windows защищён', 'error', 3000);
      return;
    }

    busyIds.add(item.id);

    const isSwitch = control.classList.contains('startup-switch');
    const isDelete = action === 'delete';
    const row = control.closest('.startup-row');

    let prevEnabled = null;
    if (isSwitch && row) {
      prevEnabled = row.dataset.enabled === '1';
      const willBeEnabled = action === 'enable';

      control.classList.toggle('on', willBeEnabled);
      control.setAttribute('aria-checked', String(willBeEnabled));
      control.classList.add('busy');
      row.classList.toggle('disabled', !willBeEnabled);
      row.dataset.enabled = willBeEnabled ? '1' : '0';

      const statusEl = row.querySelector('.startup-status');
      if (statusEl) {
        statusEl.classList.toggle('on', willBeEnabled);
        statusEl.classList.toggle('off', !willBeEnabled);
        statusEl.textContent = willBeEnabled ? 'Включено' : 'Отключено';
      }
    }

    if (isDelete && control) {
      control.disabled = true;
      control.textContent = '…';
    }

    Sound.click();

    try {
      let r;
      if (action === 'enable')  r = await window.api.startup.enable(item.id);
      if (action === 'disable') r = await window.api.startup.disable(item.id);
      if (action === 'delete')  r = await window.api.startup.delete(item.id);

      await sleep(500);

      if (isDelete) {
        if (r && r.ok) {
          Sound.success();
          toast(`Удалено: ${item.displayName || item.name}`, 'success', 1600);
        } else {
          Sound.error();
          toast('Ошибка: ' + (r?.error || 'неизвестно'), 'error', 5000);
        }
        await load(true);
        return;
      }

      /* Обновляем данные с сервера и обновляем кэш */
      lastData = await window.api.startup.list(true);
      state.dataCache.startup = lastData;
      const all = collectItems();
      const fresh = all.find(x => x.id === item.id);
      const expectedEnabled = action === 'enable';

      if (!r || !r.ok) {
        rollback();
        Sound.error();
        toast('Ошибка: ' + (r?.error || 'неизвестно'), 'error', 5000);
        renderSummary();
        renderList();
        return;
      }

      if (fresh && fresh.enabled === expectedEnabled) {
        Sound.success();
        toast(
          expectedEnabled ? `Включено: ${item.displayName || item.name}` : `Отключено: ${item.displayName || item.name}`,
          'success', 1600
        );
        renderSummary();
        renderList();
      } else {
        rollback();
        Sound.error();
        toast(
          expectedEnabled
            ? `⚠ Не удалось включить "${item.displayName || item.name}"`
            : `⚠ Не удалось отключить "${item.displayName || item.name}"`,
          'error', 5000
        );
        renderSummary();
        renderList();
      }

      function rollback() {
        if (!isSwitch || !row || prevEnabled === null) return;
        control.classList.toggle('on', prevEnabled);
        control.setAttribute('aria-checked', String(prevEnabled));
        row.classList.toggle('disabled', !prevEnabled);
        row.dataset.enabled = prevEnabled ? '1' : '0';
        const statusEl = row.querySelector('.startup-status');
        if (statusEl) {
          statusEl.classList.toggle('on', prevEnabled);
          statusEl.classList.toggle('off', !prevEnabled);
          statusEl.textContent = prevEnabled ? 'Включено' : 'Отключено';
        }
      }
    } catch (e) {
      console.error('[startup] doAction exception:', e);
      Sound.error();
      toast('Ошибка: ' + e.message, 'error', 5000);
    } finally {
      busyIds.delete(item.id);
      if (isSwitch) control.classList.remove('busy');
      if (isDelete && control) { control.disabled = false; control.textContent = '🗑'; }
    }
  }

  header.querySelector('#startup-refresh').addEventListener('click', async () => {
    Sound.click();
    const btn = header.querySelector('#startup-refresh');
    if (btn.disabled) return;
    btn.disabled = true;
    btn.textContent = '⏳ Обновление…';
    try {
      /* Сбрасываем кэш этой вкладки и грузим заново */
      delete state.dataCache.startup;
      await load(true);
      toast('Данные обновлены', 'success', 1500);
    } finally {
      btn.disabled = false;
      btn.textContent = '🔄 Обновить';
    }
  });

  await load();
}

function escapeHtml(s) {
  return String(s)
    .replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
}

function sleep(ms) {
  return new Promise(r => setTimeout(r, ms));
}