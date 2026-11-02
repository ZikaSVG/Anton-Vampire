/* ============================================================
   Источники твиков для трёх под-вкладок «Безопасности».

   ВАЖНО: id должен быть уникальным внутри одной секции.
   flatCategories: true → категории в JSON — логические метки,
                          файлы лежат ПРЯМО в baseDir.
   ============================================================ */

/* ============================================================
   БЕЗОПАСНОСТЬ — в tweaks/Безопасность/ реально есть ТОЛЬКО
   папка HardeningKitty. Остальные сборки отсутствуют.
   ============================================================ */
   export const SECURITY_SOURCES = [
    {
      id: 'hardening',
      label: '🛡 HardeningKitty',
      desc: 'Базовый набор твиков безопасности Windows',
      json: 'tweaks/hardening_kitty_security_tabs.json',
      baseDir: 'tweaks/Безопасность/HardeningKitty',
      flatCategories: true
    }
  ];
  
  /* ============================================================
     ПРИВАТНОСТЬ — 4 реальные папки:
     ExtremeOS, SynergyOS-Tweaks, VainOS-Tweaks, XOS-Tweaks
     ============================================================ */
  export const PRIVACY_SOURCES = [
    {
      id: 'xos',
      label: '🟢 XOS-Tweaks',
      desc: 'Приватность XOS',
      json: 'tweaks/x_os_privacy_tabs.json',
      baseDir: 'tweaks/Приватность/XOS-Tweaks',
      flatCategories: true
    },
    {
      id: 'extreme',
      label: '💀 ExtremeOS',
      desc: 'Приватность ExtremeOS',
      json: 'tweaks/extreme_os_privacy_tabs.json',
      baseDir: 'tweaks/Приватность/ExtremeOS',
      flatCategories: true
    },
    {
      id: 'synergy',
      label: '🔷 SynergyOS-Tweaks',
      desc: 'Приватность SynergyOS',
      json: 'tweaks/synergy_os_privacy_tabs.json',
      baseDir: 'tweaks/Приватность/SynergyOS-Tweaks',
      flatCategories: true
    },
    {
      id: 'vain',
      label: '👑 VainOS-Tweaks',
      desc: 'Приватность VainOS',
      json: 'tweaks/vain_os_privacy_tabs.json',
      baseDir: 'tweaks/Приватность/VainOS-Tweaks',
      flatCategories: true
    },
    { 
      id: 'immortal',
      label: '💀 ImmortalOS-Tweaks',
      desc: 'Приватность ImmortalOS',
      json: 'tweaks/immortal_os_privacy_tabs.json',
      baseDir: 'tweaks/Приватность/ImmortalOS-Tweaks',
      flatCategories: true
    }
  ];
  
  /* ============================================================
     УДОБСТВО — 4 реальные папки:
     HardeningKitty, SynergyOS-Tweaks, VainOS-Tweaks, XOS-Tweaks
     ============================================================ */
  export const COMFORT_SOURCES = [
    {
      id: 'hardening',
      label: '🛋 HardeningKitty',
      desc: 'Базовый набор твиков удобства (отключение защит)',
      json: 'tweaks/hardening_kitty_comfort_tabs.json',
      baseDir: 'tweaks/Удобство/HardeningKitty',
      flatCategories: true
    },
    {
      id: 'xos',
      label: '🟢 XOS-Tweaks',
      desc: 'Удобство XOS',
      json: 'tweaks/x_os_comfort_tabs.json',
      baseDir: 'tweaks/Удобство/XOS-Tweaks',
      flatCategories: true
    },
    {
      id: 'synergy',
      label: '🔷 SynergyOS-Tweaks',
      desc: 'Удобство SynergyOS',
      json: 'tweaks/synergy_os_comfort_tabs.json',
      baseDir: 'tweaks/Удобство/SynergyOS-Tweaks',
      flatCategories: true
    },
    {
      id: 'vain',
      label: '👑 VainOS-Tweaks',
      desc: 'Удобство VainOS',
      json: 'tweaks/vain_os_comfort_tabs.json',
      baseDir: 'tweaks/Удобство/VainOS-Tweaks',
      flatCategories: true
    },
    { 
      id: 'immortal',
      label: '💀 ImmortalOS-Tweaks',
      desc: 'Удобство ImmortalOS',
      json: 'tweaks/immortal_os_comfort_tabs.json',
      baseDir: 'tweaks/Удобство/ImmortalOS-Tweaks',
      flatCategories: true
    }
  ];