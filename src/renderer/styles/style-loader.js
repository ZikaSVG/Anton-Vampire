/* ============================================================
   Загрузчик CSS-стилей (внешнее оформление).
   Темы (цвета) применяются отдельно через themes.js.
   ============================================================ */

   export const STYLES = {
    default:   { id: 'default',   label: '🎨 Material 3',         file: 'src/styles/default.css' },
    pixel:     { id: 'pixel',     label: '🕹 Pixel Style',         file: 'src/styles/pixel.css' },
    material3: { id: 'material3', label: '✨ Material You',       file: 'src/styles/material3.css' },
    kitty:     { id: 'kitty',     label: '🎀 Pretty Kitty Pixel', file: 'src/styles/kitty.css' },
    cyberpunk: { id: 'cyberpunk', label: '🌆 Cyberpunk 2077',     file: 'src/styles/cyberpunk.css' },
    minipunk:  { id: 'minipunk',  label: '📟 Mini Punk',          file: 'src/styles/minipunk.css' },
    altpunk:   { id: 'altpunk',   label: '⚡ Alt Punk',           file: 'src/styles/altpunk.css' },
  };
  
  export const STYLE_IDS = Object.keys(STYLES);
  
  let currentStyleId = null;
  let currentLink = null;
  
  /**
   * Меняет CSS-стиль приложения.
   * Старый <link> ПОЛНОСТЬЮ удаляется, чтобы его правила
   * не «перебивали» новый стиль.
   */
  export function applyStyle(id) {
    const style = STYLES[id] || STYLES.default;
    currentStyleId = style.id;
  
    return new Promise((resolve) => {
      // 1. Отключаем и удаляем старый <link>
      if (currentLink && currentLink.parentNode) {
        try { currentLink.disabled = true; } catch {}
        currentLink.parentNode.removeChild(currentLink);
        currentLink = null;
      }
  
      // 2. Убираем осиротевшие
      document.querySelectorAll('link[data-app-style="1"]').forEach(el => {
        try { el.disabled = true; } catch {}
        el.parentNode?.removeChild(el);
      });
  
      // 3. Создаём новый
      const link = document.createElement('link');
      link.rel = 'stylesheet';
      link.id = 'app-style';
      link.dataset.appStyle = '1';
  
      let done = false;
      const finish = () => {
        if (done) return;
        done = true;
        link.removeEventListener('load', finish);
        link.removeEventListener('error', finish);
        resolve();
      };
  
      link.addEventListener('load', finish);
      link.addEventListener('error', finish);
  
      link.href = `${style.file}?v=${Date.now()}`;
      document.head.appendChild(link);
      currentLink = link;
  
      // Защита: резолвим через 2 сек максимум
      setTimeout(finish, 2000);
    });
  }
  
  export function getCurrentStyleId() {
    return currentStyleId;
  }