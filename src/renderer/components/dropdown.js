import { Sound } from '../app.js';

/**
 * Кастомный дропдаун в стиле hone/boosterx/sapphire.
 * 
 * @param {Object} opts
 * @param {Array<{value: any, label: string}>} opts.options
 * @param {any} opts.value              — текущее значение
 * @param {string} opts.placeholder     — текст, если ничего не выбрано
 * @param {(v:any)=>void} opts.onChange — колбэк при выборе
 */
export function createDropdown({ options, value, placeholder = 'Выберите…', onChange }) {
  const root = document.createElement('div');
  root.className = 'dd';

  const btn = document.createElement('button');
  btn.type = 'button';
  btn.className = 'dd-btn';
  root.appendChild(btn);

  const list = document.createElement('div');
  list.className = 'dd-list';
  root.appendChild(list);

  let current = value;
  let opened = false;

  function findLabel(v) {
    const o = options.find(x => String(x.value) === String(v));
    return o ? o.label : null;
  }

  function renderBtn() {
    const label = findLabel(current);
    btn.innerHTML = `
      <span class="dd-value">${label ?? `<span class="dd-placeholder">${placeholder}</span>`}</span>
      <span class="dd-chev">▾</span>
    `;
    btn.classList.toggle('has-value', label !== null);
  }

  function renderList() {
    list.innerHTML = '';
    for (const opt of options) {
      const item = document.createElement('button');
      item.type = 'button';
      item.className = 'dd-item' + (String(opt.value) === String(current) ? ' active' : '');
      item.innerHTML = `
        <span class="dd-item-label">${opt.label}</span>
        <span class="dd-item-check">✓</span>
      `;
      item.addEventListener('click', (e) => {
        e.stopPropagation();
        current = opt.value;
        renderBtn();
        renderList();
        close();
        Sound.click();
        if (typeof onChange === 'function') onChange(opt.value);
      });
      list.appendChild(item);
    }
  }

  function open() {
    if (opened) return;
    opened = true;
    root.classList.add('open');
    Sound.hover();
  }

  function close() {
    if (!opened) return;
    opened = false;
    root.classList.remove('open');
  }

  btn.addEventListener('click', (e) => {
    e.stopPropagation();
    Sound.click();
    opened ? close() : open();
  });

  document.addEventListener('click', (e) => {
    if (!root.contains(e.target)) close();
  });

  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') close();
  });

  renderBtn();
  renderList();

  return {
    el: root,
    get value() { return current; },
    set value(v) { current = v; renderBtn(); renderList(); }
  };
}