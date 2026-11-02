/* ============================================================
   Обёртка над sources.js для вкладки «Безопасность».

   Раньше эта функция читала state.tabsData.tabs_0[category]
   (плоский массив) и рендерила голый renderCheckboxGrid.
   Теперь — рендерит полноценный блок «источников» с под-
   вкладками по сборкам (HardeningKitty / XOS / AtlasOS / ...)
   и кнопками отмены ↩ для парных твиков.

   Использование в панелях:

     import { renderTweaksFor } from './tweaks.js';
     import { SECURITY_SOURCES } from './sources-config.js';

     renderTweaksFor(rootEl, SECURITY_SOURCES, 'security', 'Безопасность');

   sectionId должен быть уникальным для под-вкладки:
     - 'security'  (Безопасность)
     - 'privacy'   (Приватность)
     - 'comfort'   (Удобство)
   иначе registerCheckbox перезапишет ключи между панелями.
   ============================================================ */

   import { renderSources } from '../sources.js';

   /**
    * Рендерит блок «Твики: <subtitle>» с источниками.
    *
    * @param {HTMLElement} root        — контейнер (например, tw из panel)
    * @param {Array}       sources     — SECURITY_SOURCES | PRIVACY_SOURCES | COMFORT_SOURCES
    * @param {string}      sectionId   — 'security' | 'privacy' | 'comfort'
    * @param {string}      subtitle    — заголовок блока (напр. «Безопасность»)
    * @returns {Promise<{destroy:Function}|null>}
    */
   export async function renderTweaksFor(root, sources, sectionId, subtitle) {
     if (!root) return null;
     if (!Array.isArray(sources) || !sources.length) return null;
   
     /* ---------- Внешний блок m3-section ---------- */
     const section = document.createElement('section');
     section.className = 'm3-section';
   
     const titleEl = document.createElement('div');
     titleEl.className = 'm3-section-title';
     titleEl.innerHTML = `
       <span>⚙ Твики: ${escapeHtml(subtitle || '')}</span>
       <span class="muted" style="font-weight:400;font-size:11px;margin-left:8px">
         · ${sources.length} ${pluralSources(sources.length)}
       </span>
     `;
     section.appendChild(titleEl);
   
     const host = document.createElement('div');
     host.className = 'm3-grid';
     section.appendChild(host);
   
     root.appendChild(section);
   
     /* ---------- Рендер через renderSources ---------- */
     try {
       const instance = renderSources({
         host,
         sources,
         sectionId,
         subtitle: null,          // заголовок уже в m3-section-title
         initialSourceId: sources[0].id
       });
       return instance;
     } catch (e) {
       console.error('[security/tweaks] renderSources failed:', e);
       host.innerHTML = `<div class="m3-empty">Ошибка рендера источников: ${escapeHtml(e.message)}</div>`;
       return null;
     }
   }
   
   /* ============================================================
      Утилиты
      ============================================================ */
   function pluralSources(n) {
     const mod10 = n % 10;
     const mod100 = n % 100;
     if (mod10 === 1 && mod100 !== 11) return 'источник';
     if (mod10 >= 2 && mod10 <= 4 && (mod100 < 10 || mod100 >= 20)) return 'источника';
     return 'источников';
   }
   
   function escapeHtml(s) {
     return String(s || '')
       .replace(/&/g, '&amp;')
       .replace(/</g, '&lt;')
       .replace(/>/g, '&gt;')
       .replace(/"/g, '&quot;')
       .replace(/'/g, '&#39;');
   }