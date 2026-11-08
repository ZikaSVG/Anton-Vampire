/* ============================================================
   Общий модуль для получения путей к Papirus-иконкам.
   Решает три проблемы:
     1. Пробелы в пути (Extreme Electron → Extreme%20Electron)
     2. Кириллица в пути
     3. Кэш, чтобы не дёргать DOM каждый раз
   ============================================================ */

   let _rootCache = null;

   /**
    * Возвращает корень проекта в виде fs-пути (без file://).
    * Кэшируется, чтобы не парсить location на каждый вызов.
    */
   export function getProjectRoot() {
     if (_rootCache) return _rootCache;
   
     // location.pathname в Electron: /D:/Projects/Extreme Electron/index.html
     let p = decodeURIComponent(location.pathname);
     if (p.startsWith('/')) p = p.slice(1);
   
     // Убираем имя файла (index.html)
     const idx = p.lastIndexOf('/');
     p = idx >= 0 ? p.slice(0, idx) : p;
   
     // Нормализуем слеши
     p = p.replace(/\\/g, '/');
   
     _rootCache = p;
     return p;
   }
   
   /**
    * Строит корректный file:// URL.
    * @param {string} category  - 'nav' | 'apps' | 'devices' | 'categories' | 'vendors'
    * @param {string} name      - имя файла без расширения
    * @param {string} ext       - расширение (по умолчанию 'png')
    */
   export function papirusUrl(category, name, ext = 'png') {
     const root = getProjectRoot();
   
     // Полный fs-путь
     const raw = `${root}/assets/papirus/${category}/${name}.${ext}`;
   
     // Кодируем КАЖДЫЙ сегмент пути отдельно (кроме первого с диском).
     // "D:" не кодируем, иначе получится "D%3A" и URL сломается.
     const parts = raw.split('/');
     const encoded = [
       parts[0],                                  // "D:" — как есть
       ...parts.slice(1).map(seg => encodeURIComponent(seg))
     ].join('/');
   
     // ВАЖНО: три слэша — file:///D:/...
     return `file:///${encoded}`;
   }
   
   /**
    * Возвращает HTML-разметку <img> с fallback на emoji.
    * @param {string} category
    * @param {string} name
    * @param {string} fallbackEmoji - что показать, если иконка не загрузится
    * @param {string} className     - CSS-класс для <img>
    */
   export function papirusImgHtml(category, name, fallbackEmoji, className = '') {
     const url = papirusUrl(category, name);
     const fallback = escapeHtml(fallbackEmoji || '📦');
     const cls = className ? ` class="${className}"` : '';
   
     return `
       <img${cls} src="${url}" alt=""
            onerror="this.style.display='none';this.nextElementSibling.style.display='inline-flex'">
       <span class="papirus-fallback" style="display:none">${fallback}</span>
     `;
   }
   
   function escapeHtml(s) {
     return String(s)
       .replace(/&/g, '&amp;')
       .replace(/</g, '&lt;')
       .replace(/>/g, '&gt;')
       .replace(/"/g, '&quot;')
       .replace(/'/g, '&#39;');
   }