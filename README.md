<h1 align="center">
  <img src="assets/icon.png" alt="Anton Vampire" width="96" /><br/>
  Anton Vampire
</h1>

  <p align="center">
  <b>Windows-оптимизатор на Electron</b><br/>
</p>

<p align="center">
  <a href="https://github.com/ZikaSVG/Anton-Vampire/releases/download/v1.1.0/Anton.Vampire.Setup.1.1.0.exe">
    <img src="https://img.shields.io/badge/%F0%9F%93%A5_Download-Setup_.exe-EA38B8?style=for-the-badge" alt="Download Setup" />
  </a>
  <a href="https://github.com/ZikaSVG/Anton-Vampire/releases/download/v1.1.0/Anton.Vampire.Portable.rar">
    <img src="https://img.shields.io/badge/%F0%9F%93%A6_Download-Portable_.rar-6E40C0?style=for-the-badge" alt="Download Portable" />
  </a>
</p>

---

## 🩸 Что это

**Anton Vampire** — полностью переписанный Windows-оптимизатор.
Наследник [All Tweaker](https://github.com/scode18/All-Tweaker) (Python / tkinter),
переехавший на **Electron 44 + Material You + Cyberpunk Style**.

<p align="center">
  <a href="web/screenshot.jpg">
    <img src="web/screenshot.jpg" alt="Anton Vampire v1.1.0 — главный экран" width="90%" style="border-radius: 8px;" />
  </a>
</p>

Внутри — **1000+ твиков**, сгруппированных по 13 вкладкам, **100+ тем**
(включая игровые, Catppuccin, Dark Reader, Cyberpunk),
аудит безопасности, управление автозагрузкой, службами, курсорами, обои
и портативный режим.

> ⚠️ Требуются **права администратора**. Приложение проверяет `fltmc` при старте
> и предлагает перезапуск через UAC.

---

## ✨ Новое в 1.1.0

- 🧛 **VampireOS** — отдельная вкладка «Вампир» с глобальной оптимизацией системы (13 категорий изменений в реестре, службах и групповых политиках). Включает:
  - **Установить VampireOS** — базовый необратимый BAT-твик.
  - **Убить KCAS и Xeon** — режим максимальной производительности (десктопы).
  - **Режим Деда** — режим максимального энергосбережения (ноутбуки).
  - **↺ Откат** — возврат к стандартным настройкам (Balanced).
- ⚙️ **Менеджер служб** — выделен в отдельную вкладку. Полноценная таблица с поиском, статусами (boot/system/auto/manual/disabled), массовым включением/отключением, безопасным бэкапом `.reg` и отображением тегов сборок, в которых служба уже отключена.
- 🎮 **Игровой режим 2.0** — 14 готовых планов электропитания (Amit, Atlas, Bitsum, Quaked, XOS, Zoyata и др.) с импортом/активацией, Power Killer, массовое отключение 200+ служб с бэкапом `.reg` и безопасным fallback.
- 🔋 **Электропитание** — Power Killer теперь представлен в виде карточек с возможностью применения «Смертельного Максимума (всё сразу)», таблица результатов тестирования планов, ~80 источников питания (XOS, ImmortalOS, SystemX, Igromanoff, VainOS, SynergyOS, Другое).
- 🖼️ **Обои** — новая под-вкладка в настройках: добавление своих файлов, загрузка по ссылке, смена папки, применение и удаление.
- 🎨 **8 CSS-стилей:** Material 3, Pixel, Material You, Pretty Kitty, Cyberpunk 2077, Mini Punk, Alt Punk, Material Mini.
- 🌈 **~100+ тем** в 12 группах: Material 3, светлые, тёмные ttkbootstrap, тёмные от разработчика, от Антона, от Русланчика, игровые, Catppuccin ×4, Dark Reader ×22, Curated 2.0 ×17.
- 🛠 **Настройки** — новый режим запуска твиков `minsudo`, переключатель «Разрешить выделение чекбоксов», режим отображения чекбоксов `expandable` (Sapphire).

---

# ⚡ Планы электропитания VampireOS

В рамках установки VampireOS создаются **три фирменные схемы электропитания**. Они базируются на стандартных планах Windows, но содержат ряд безопасных твиков, направленных на стабильность работы дисковой подсистемы и USB-устройств.

> 🛡️ **Важно:** Скрипт идемпотентен. При повторном запуске старые копии схем удаляются, а затем создаются заново. Это гарантирует отсутствие дубликатов в системе.

---

## 📋 Список создаваемых схем

| Название схемы | Базируется на | GUID |
| :--- | :--- | :--- |
| **Balanced Performance VampireOS** | Сбалансированная | `90a358c8-3bbc-4fb3-8b4e-d7ab065d2614` |
| **Maximum Performance VampireOS** | Высокая производительность | `a1b2c3d4-e5f6-4789-a0ab-cdef12345678` |
| **Power Saving VampireOS** | Экономия энергии | `d8e76bb7-6943-4b7c-ab30-441296b72264` |

По умолчанию после завершения скрипта активируется схема **Balanced Performance VampireOS**.

---

## 🛠️ Безопасные твики (применяются ко всем трём схемам)

Скрипт вносит изменения в три ключевые подсистемы, чтобы предотвратить микро-фризы и проблемы с периферией, не нанося вреда ноутбукам.

### 💾 Диск (HDD / SSD)
- **Параметр:** `6738e2c4-e8a5-4a42-b16a-e040e769756e`
- **Значение:** `0` (Никогда не отключать)
- **Что это даёт:** Предотвращает частую остановку и раскрутку механических жёстких дисков (HDD). На SSD эта настройка не оказывает влияния, но полностью безопасна.

### 🔌 USB-порты
- **Параметр:** `48e6b7a6-50f5-4782-a5d4-53bb8f07e226`
- **Значение:** `0` (Отключить выборочную приостановку / Selective Suspend)
- **Что это даёт:** Внешние диски, мыши, клавиатуры и хабы перестают «засыпать». Это устраняет задержки при пробуждении USB-устройств во время игры или работы.

### 🖥️ Таймауты экрана (безопасные значения)

Скрипт устанавливает разумные лимиты отключения экрана, чтобы не расходовать батарею впустую, но и не мешать работе.

| Схема | От сети (AC) | От батареи (DC) |
| :--- | :--- | :--- |
| **Balanced Performance** | 15 минут | 5 минут |
| **Maximum Performance** | 15 минут | 10 минут |
| **Power Saving** | 5 минут | 2 минуты |

---

## 🔄 Логика работы скрипта

1. **Проверка прав:** Скрипт требует запуска от имени администратора (`fltmc`).
2. **Сброс:** Принудительно переключается на стандартную схему «Сбалансированная» (Windows не позволяет удалить активную схему).
3. **Очистка:** Удаляет предыдущие версии схем VampireOS по их GUID.
4. **Создание:** Клонирует стандартные схемы Windows и присваивает им новые имена.
5. **Твики:** Применяет настройки диска, USB и таймаутов экрана.
6. **Активация:** Включает **Balanced Performance VampireOS**.

> 💡 **Совет:** Для ноутбуков при работе от батареи лучше вручную переключиться на схему **Power Saving VampireOS** или использовать стандартный план Windows, чтобы maximize время автономной работы.

---

## ✨ Возможности

### 🎨 Интерфейс
- **Material You (Material 3 Expressiv)** — скругления 16–32px, tonal-контейнеры, state layers
- **Cyberpunk 2077** — неон, глитчи, жёлто-голубая палитра, моноширинные шрифты
- **100+ тем** в 12 группах с превью
- **8 CSS-стилей**: Material 3 · Pixel · Material You · Pretty Kitty · Cyberpunk 2077 · Mini Punk · Alt Punk · Material Mini
- **6 шрифтовых слотов** (heading / body / mono × latin / cyr) + веса 100–900
- **Splash-screen** с прогрессом
- **Панель лога** с автопрокруткой и стримом
- **Toast-уведомления**
- **Звуки** на Web Audio API (клик, hover, успех, ошибка)
- **Эффект стекла**: `none` / `glass` / `aero` (Mica/Acrylic)

### 🛡️ 13 вкладок

| # | Вкладка | Что делает |
|---|---|---|
| 1 | 🏠 **Главная** | Приветствие, живой polling CPU/GPU/RAM/диск, быстрый переход |
| 2 | 🛡️ **Безопасность** | 3 аудита (21+14+13), Firewall, NetMon, HTML-отчёты |
| 3 | 🚀 **Автозагрузка** | Папки, реестр, задачи, службы + категоризация + защита критичных |
| 4 | ⚡ **Оптимизация** | 7 источников + вендор-панель (NVIDIA/AMD/Intel/DX/OpenGL) |
| 5 | 🧹 **Очистка** | 12 секций: шейдеры, логи, кэши, Windows Update, Temp, диск |
| 6 | ⚜️ **Исправления** | DISM, SFC, CHKDSK, сеть, устройства, игры, hero-блок отката |
| 7 | 🎮 **Игровой режим** | Планы электропитания (14), Power Killer (6), службы (200+) |
| 8 | 🧛 **Вампир** | VampireOS: 13 категорий изменений, Power Max / Power Save, откат |
| 9 | 🔋 **Электропитание** | Power Killer + таблица планов + 100+ источников схем + `.pow` |
| 10 | ⚙️ **Службы** | Таблица служб: поиск, статусы, массовое вкл/выкл, бэкап `.reg` |
| 11 | 🎨 **Кастомизация** | Курсоры с превью + 4 источника твиков (XOS/Marty/Synergy/Vain) |
| 12 | 📦 **Приложения** | Appx, Defender/Edge/OneDrive/WebView2 в 4 режимах, removal-батники |
| 13 | ⚙️ **Настройки** | 6 под-вкладок (Внешний вид, Шрифты, Интерфейс, Утилиты, Обои, О программе) |

### ⚙️ Механики
- **7 режимов запуска твиков**: `default` · `no_launcher` · `launcher` · `powerrun` · `nsudolg` (TrustedInstaller) · `minsudo` · `cmd`
- **Патчинг `.bat`**: вырезает `pause`/`timeout`/`choice`, превращает `start` → `start /b ""`
- **Стрим вывода** с авто-декодингом UTF-8 → cp866 fallback
- **Пары «твик ↔ отмена»** с кнопкой ↩
- **Preload** тяжёлых данных (startup, apps, audits) + lazy-вкладки
- **Portable mode**: всё в `extreme_data/` рядом с `.exe`
- **Безопасный бэкап служб**: `.reg`-файл + fallback на `Start=3`
- **Проверка дубликатов** при импорте планов электропитания
- **Отключение выделения чекбоксов** — защита от случайного запуска твиков
- **Живой стрим логов** в тяжёлых операциях (VampireOS, Power Killer)

---

## 🧛 Вампир (VampireOS) — 1.1.0

Глобальная оптимизация Windows. **Изменения вносятся в реестр, службы и системные файлы. Часть изменений (Defender, OneDrive) необратима.**

| Категория | Что делает |
|---|---|
| 📊 **Телеметрия и диагностика** | Уровень телеметрии = 0, отключение DiagTrack/WER/TIP, блокировка задач через IFEO |
| 🔄 **Обновления и Store** | Отключение wuauserv/UsoSvc/BITS/DoSvc/edgeupdate, блокировка авто-обновлений Edge |
| 🧠 **Система и ядро** | Win32PrioritySeparation=38, отключение Memory Compression, MSI mode, DMA remapping, BCD-твики |
| 🌐 **Сеть и TCP** | DefaultTTL=65, TCPNoDelay=1, отключение Wi-Fi Sense и авто-подключения к хотспотам |
| 🖥️ **Проводник, UI** | Классическое контекстное меню, MenuShowDelay=0, отключение анимаций, скрытие лишних элементов |
| 🖱️ **Мышь, ввод** | MouseSpeed=0, отключение автозамены и предиктивного ввода |
| 🖨️ **Службы, принтер** | Отключение Spooler, Fax, диагностических служб (DPS, WerSvc) |
| 📜 **Журналы и события** | Отключение AutoBackupLogFiles, очистка всех журналов через `wevtutil` |
| 🧹 **Прочее** | Отключение ReserveManager, Storage Sense, GameDVR, FSO, Office-логов |
| 📂 **Меню «Создать»** | Добавление пунктов .bat, .reg, .ps1, .vbs в контекстное меню, подменю питания на рабочем столе |
| ⚡ **Питание** | Создание 3 схем VampireOS (Balanced, Maximum, Power Saving) с безопасными твиками |

> ⚠️ **Убить KCAS и Xeon** — только для десктопов. **Режим Деда** — для ноутбуков. Перед запуском создайте точку восстановления.

---

## 🎮 Игровой режим 2.0

### 📦 Готовые планы электропитания (14)

| План | Описание |
|---|---|
| `Amit_v1_lowlatency` | Низкая задержка ввода, баланс |
| `Amit_v2_extreme performance` | Максимум без компромиссов |
| `Amit_v3_low latency` | Минимальная задержка в играх |
| `Atlas Power Plan` | Агрессивная оптимизация от AtlasOS |
| `Bitsum Highest Performance` | Максимальная частота CPU |
| `Calypto` | Баланс для игр и работы |
| `GGOSv0_8_5_Idle_Enabled` | GGOS с idle-режимом |
| `Light pow v` | Лёгкий план |
| `Muren_Idle_Enabled` | Muren с idle |
| `Quaked Ultimate Performance Idle Off` | Максимум, idle off |
| `Quaked Ultimate Performance` | Абсолютный максимум |
| `Unixcorn_Idle_Enabled` | Unixcorn с idle |
| `XOS imribiy` | От XOS — для игр |
| `Zoyata_Low Latency` | Для шутеров |

🛡️ **Защита от дубликатов:** если план уже импортирован — повторно не создаётся.
💡 **Совет:** для ноутбуков выбирайте планы с `Idle_Enabled`.

### 🔧 Power Killer — 6 функций

| Функция | Что делает |
|---|---|
| 🕒 **Таймауты AC/DC** | Запрет сна монитора/диска/системы |
| 🧠 **CPU Throttle off** | CPU всегда на максимуме |
| ⚙️ **Power Throttling & Dynamic Tick** | Снижение DPC latency |
| 🔌 **USB Power (LPM/D3Cold)** | USB-порты не «засыпают» |
| 🎛️ **PCI D3Cold** | Запрет глубокого сна GPU/NVMe |
| 📓 **Диагностические журналы** | SleepStudy, Kernel-Processor-Power off |

### 🛡️ Оптимизация служб
- **200+ служб** в списке `SAFE_SERVICES` (телеметрия, реклама, фоновые)
- **Защищённые категории:** питание 🔋, ввод ⌨️, сеть 🌐, темы 🎨, ядра ⚙️ (Start 0-2)
- **Автобэкап** реестра служб в `.reg` перед отключением (переключатель)
- **Восстановление** из бэкапа + fallback на `Start=3` при отсутствии файла
- **Выбор чекбоксами** — можно оставить нужные службы включёнными

---

## ⚙️ Службы (выделенная вкладка)

Полноценный менеджер служб Windows:

- **Таблица** с колонками: имя, описание, статус (boot/system/auto/manual/disabled), действия, «отключена в» (сборки)
- **Поиск** по имени и описанию
- **Массовое управление**: выбрать все / снять все / отключить выбранные / включить выбранные
- **Статусы** через `Get_Services_Status.bat` → `services_status.json`
- **Кнопки в строке**: ▶ Вкл / ⏹ Выкл для каждой службы, выбор типа запуска из выпадающего списка
- **Бэкап** `Services_Backup.reg` и **восстановление**
- **Индикаторы**: цветные бейджи статусов + теги сборок (ReviOS, AtlasOS, XOS, VainOS и т.д.)

---

## 📥 Скачать

<table>
<tr>
<td align="center" width="50%">

### 📥 Setup
Установщик NSIS, ярлык в меню Пуск, автозапуск от админа.

[**Скачать Setup .exe →**](https://github.com/ZikaSVG/Anton-Vampire/releases/download/v1.1.0/Anton.Vampire.Setup.1.1.0.exe)

</td>
<td align="center" width="50%">

### 📦 Portable
Архив `.rar`, без установки, всё в `extreme_data/`.

[**Скачать Portable .rar →**](https://github.com/ZikaSVG/Anton-Vampire/releases/download/v1.1.0/Anton.Vampire.Portable.rar)

</td>
</tr>
</table>

### Установка одной командой

Откройте `cmd` (Win+R → cmd) и вставьте:

```cmd
curl -g -k -L -# -o "%temp%\AntonVampire.Setup.exe" "https://github.com/ZikaSVG/Anton-Vampire/releases/download/v1.1.0/Anton.Vampire.Setup.1.1.0.exe" && start "" "%temp%\AntonVampire.Setup.exe"
```

### Из исходников

```bash
git clone https://github.com/ZikaSVG/Anton-Vampire.git
cd Anton-Vampire
npm install
npm start        # dev-режим
npm run dev      # dev + DevTools
npm run build    # сборка NSIS installer
```

---

## 🧱 Стек

| Слой | Технологии |
|---|---|
| Runtime | Electron 44 · Node.js |
| Renderer | Vanilla JS (ES-модули) · HTML · CSS |
| Стили | 8 CSS-файлов + CSS-переменные |
| Темы | `renderer/themes.js` (100+ тем) |
| Шрифты | локальные `.woff2` из `assets/fonts/` |
| Сборка | `electron-builder` → NSIS |
| Утилиты | PowerShell · `7z.exe` · `NSudoLG.exe` · `PowerRun.exe` · `MinSudo.exe` |
| Данные | JSON · UTF-8 · `extreme_data/settings.json` |

---

## 📁 Структура проекта

```
Anton-Vampire/
├── main.js                    # точка входа
├── preload.js                 # contextBridge → window.api
├── package.json
│
├── src/
│   ├── main/                  # main-процесс
│   │   ├── config.js          # ConfigManager
│   │   ├── logger.js          # файловый логгер
│   │   ├── tweak-runner.js    # + патчинг .bat
│   │   ├── startup.js         # автозагрузка
│   │   └── tabs-data.js       # загрузка JSON
│   │
│   ├── renderer/              # UI-процесс
│   │   ├── app.js             # оркестратор
│   │   ├── sections.js        # список разделов
│   │   ├── sidebar.js         # сайдбар
│   │   ├── themes.js          # 100+ тем + шрифты
│   │   ├── logger.js          # панель лога
│   │   ├── components/        # checkbox, dropdown
│   │   ├── styles/            # style-loader.js (8 стилей)
│   │   ├── tabs/              # 13 вкладок
│   │   │   ├── home.js
│   │   │   ├── optimization.js
│   │   │   ├── power.js
│   │   │   ├── fixes.js
│   │   │   ├── cleaner.js
│   │   │   ├── game-mode.js
│   │   │   ├── hard-optimization.js  # 🧛 Вампир (VampireOS)
│   │   │   ├── services.js           # ⚙️ Менеджер служб
│   │   │   ├── startup.js
│   │   │   ├── security/
│   │   │   ├── customization.js
│   │   │   ├── app-uninstaller.js
│   │   │   ├── settings.js
│   │   │   └── sources.js
│   │   └── utils/             # icons.js и др.
│   │
│   └── styles/
│       ├── default.css        # Material 3
│       ├── pixel.css          # 8-bit ретро
│       ├── material3.css      # Material You
│       ├── kitty.css          # Pretty Kitty
│       ├── cyberpunk.css      # Cyberpunk 2077
│       ├── minipunk.css       # Mini Punk
│       ├── altpunk.css        # Alt Punk
│       └── materialmini.css   # Material Mini
│
├── tweaks/                    # база твиков (в релизном архиве)
│   ├── tabs.json
│   ├── drivers_tabs.json
│   ├── apps_optimization_tabs.json
│   ├── removal_tabs.json
│   ├── *_customization_tabs.json
│   ├── *_power_tabs.json
│   ├── *_privacy_tabs.json
│   ├── *_comfort_tabs.json
│   ├── *_security_tabs.json
│   ├── descriptions.txt
│   └── _backups/
│
├── assets/
│   ├── icon.png / icon.ico
│   ├── logo.png
│   ├── background.png
│   ├── fonts/
│   ├── papirus/               # иконки (GPL-3.0)
│   ├── cursor_icons/
│   └── wallpapers/
│
├── Utils/                     # сторонние утилиты
│   ├── 7z.exe / 7z.dll
│   ├── PowerRun.exe
│   ├── NSudoLG.exe
│   ├── MinSudo.exe
│   └── launcher.exe
│
├── extreme_data/              # портативные данные
│   ├── settings.json
│   ├── logs/
│   ├── backgrounds/
│   ├── wallpapers/
│   ├── cursors_cache/
│   ├── cursor_icons/
│   ├── config_backups/
│   └── electron_userdata/
│
├── LICENSE
└── README.md
```

---

## ⚙️ Конфиг

`extreme_data/settings.json` · UTF-8 · debounce 250 мс

```json
{
  "General": {
    "theme": "vampire_the_masquerade",
    "ui_style": "material3",
    "visual_effect": "glass",
    "font_heading_latin": "Silkscreen",
    "font_heading_cyr": "JetBrains Mono",
    "font_body_latin": "JetBrains Mono",
    "font_body_cyr": "JetBrains Mono",
    "font_mono": "JetBrains Mono",
    "heading_font_size": 15,
    "body_font_size": 13,
    "heading_font_weight": 700,
    "body_font_weight": 400,
    "corner_radius": 12,
    "ui_density": "comfortable",
    "sidebar_opacity": 40,
    "unified_button_color": true,
    "checkbox_display_mode": "rectangle",
    "checkbox_selection_enabled": true,
    "show_cancel_buttons": true,
    "tweak_execution_mode": "nsudolg",
    "tweak_timeout_ms": 300000,
    "lazy_tabs": true,
    "show_splash": true,
    "preload_heavy_tabs": false,
    "preload_audits": false,
    "security_auto_audit": true,
    "logs_enabled": false,
    "netmon_host_mode": "none",
    "initial_tab": "main",
    "wallpaper_last_dir": ""
  },
  "Window": { "fullscreen": false },
  "Columns": { "default": 3 }
}
```

При старте: `mergeDeep(DEFAULTS, raw)` + `coerceToDefaults`.

---

## 💼 Portable mode

Все данные — в `extreme_data/` рядом с `AntonVampire.exe`:

```
AntonVampire.exe
extreme_data/
├── settings.json
├── logs/{user}_log_{ts}.log
├── backgrounds/
├── wallpapers/
├── cursor_icons/
├── cursors_cache/
├── cursors_temp/
├── config_backups/{app}/{ts}__{label}/
└── electron_userdata/
    ├── session/
    ├── cache/
    ├── chromium_logs/
    └── crashDumps/
```

В `%APPDATA%` и `%LOCALAPPDATA%` **ничего не пишется**. Можно запускать с флешки.

---

## 🎨 Добавить свои твики

1. Положите `.bat` / `.ps1` / `.exe` / `.reg` / `.pow` в нужную папку `tweaks/<button>/<tab>/`
2. Добавьте описание в `tweaks/descriptions.txt` (формат `filename.bat=Описание`)
3. Откройте **Настройки → Утилиты → build_all_tabs.py → ▶ Запустить**
4. Готово — твик появится во вкладке

Требуется **Python 3.8+** в `PATH` (только для сборщиков JSON).

---

## 🛠 Утилиты сборки

| Скрипт | Назначение |
|---|---|
| `build_all_tabs.py` | Оркестратор — запускает все скрипты ниже |
| `build_tabs.py` | `tabs.json` — сборки ОС-секций |
| `build_full_tabs.py` | `tabs.json` — расширенный |
| `build_hardening_json.py` | HardeningKitty (Безопасность / Удобство) |
| `build_apps_json.py` | `apps_optimization_tabs.json` |
| `build_drivers_json.py` | `drivers_tabs.json` (NVIDIA/AMD/Intel/DX/OpenGL) |
| `build_removal_json.py` | `removal_tabs.json` |
| `audit_tweaks.py` | Проверка целостности JSON ↔ диск |

---

## 🩺 Troubleshooting

### Приложение не запускается
- Запустите от имени администратора
- Если UAC отменён — приложение закроется. Нажмите «Перезапустить» в диалоге
- Включите `logs_enabled` в `settings.json` и посмотрите `extreme_data/logs/`

### Антивирус ругается
Три причины:
1. **Нет цифровой подписи** (сертификат $300–500/год)
2. **Меняет реестр / службы / системные файлы**
3. **Использует `NSudoLG.exe`, `PowerRun.exe`, `MinSudo.exe`, `cmd.exe`**

→ Добавьте папку в исключения. Код открыт — можно проверить каждую строчку.

### Твик зависает
- По умолчанию таймаут **5 минут**. Увеличьте в **Настройки → Интерфейс**
- Смените режим запуска: `nsudolg` → `powerrun` → `minsudo` → `cmd`
- Добавьте папку в исключения антивируса

### Кракозябры в логе
Твик выводит в OEM-кодировке (cp866). Приложение пытается декодировать UTF-8, при ошибке — fallback на cp866. Если кракозябры всё равно — пересохраните `.bat` в UTF-8.

### План электропитания не активируется
- Сначала нажмите **📥 Импортировать план**
- Затем — **⚡ Активировать план**
- Если план уже есть в системе — дубликат не создаётся, активация пройдёт сразу

### Службы не восстанавливаются из бэкапа
- Проверьте наличие `Services_Backup.reg` в папке `tweaks/Службы/`
- Если файла нет — приложение применит безопасный сброс `Start=3`
- Создайте бэкап заново через **💾 Создать бэкап служб**

### Курсоры не применяются
- Убедитесь, что в архиве есть `.cur` / `.ani`
- Проверьте папку `C:\Windows\Cursors\<name>\`
- Попробуйте «▶️ Применить» ещё раз
- Сбросьте всё через «🗑️ Удалить все»

---

## ⌨️ Горячие клавиши

| Клавиша | Действие |
|---|---|
| <kbd>F1</kbd> | Открыть сайт проекта |
| <kbd>F5</kbd> | Перезагрузить renderer |
| <kbd>F11</kbd> | Fullscreen |
| <kbd>Ctrl</kbd> + <kbd>F</kbd> | Фокус в поиск |
| <kbd>Esc</kbd> | Закрыть dropdown / меню |

---

## 🔒 Безопасность

- Приложение работает **только от администратора** — это требование
- **Никакой телеметрии** — нет `telebot` и авто-отправки логов
- **Всё локально** — нет внешних API, кроме явных действий пользователя
- **Portable** — ничего в `%APPDATA%`
- **Прозрачный код** — `main.js`, `preload.js`, `renderer/` открыты
- **Бэкапы** — службы, реестр, конфиги сохраняются в `extreme_data/`

---

## 📜 Лицензия

**Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)**

| | |
|---|---|
| ✅ **Можно** | Форкать, изменять, распространять, использовать в личных проектах |
| ❌ **Нельзя** | Продавать, закрывать код производных версий, коммерческое использование |
| 📌 **Обязательно** | Указывать авторство, сохранять уведомления о лицензии |

Юридически значимый текст — в файле [`LICENSE`](LICENSE).

### Сторонние ресурсы

Anton Vampire **агрегирует** ресурсы с собственными лицензиями:

| Ресурс | Лицензия | Что это значит |
|---|---|---|
| **Papirus icons** | GPL-3.0 / LGPL-3.0 / CC-BY-SA-4.0 | При распространении нужно раскрыть исходники иконок |
| **XOS / SOS / IMOS tweaks** | Лицензии авторов сборок | Остаются под условиями создателей |
| **Utils/** | Собственные лицензии | Распространяются «как есть» |

---

## ❤️ Благодарности

- **[Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)** — иконки
- **XOS / SapphireOS / ImmortalOS / SystemX / Igromanoff / VainOS / SynergyOS / MartyFiles / scode18** — твики
- **[7-Zip](https://www.7-zip.org/)** — распаковка курсоров
- **[NSudo](https://github.com/M2Team/NSudo)** — TrustedInstaller запуск
- **[PowerRun](https://www.sordum.org/9416/powerrun-v1-7-run-with-the-highest-privileges/)** — elevate

---

## ⚠️ Отказ от ответственности

**Anton Vampire изменяет системные настройки Windows.** Используйте на свой страх и риск.

- Автор **не несёт ответственности** за сломанную систему, потерянные данные или неработоспособное железо
- **Всегда создавайте бэкап системы** перед применением твиков
- **Начинайте с базовых пресетов**
- **VampireOS и Смертельная оптимизация необратимы** — запускайте только на стационарных ПК с бэкапом
- На некоторых конфигурациях агрессивная оптимизация приводит к нестабильности
- Программа предоставляется «**как есть**», без гарантий

---

<p align="center">
  <b>🩸 Anton Vampire</b> · v1.1.0 · 2026<br/>
</p>

<p align="center">
  <a href="https://github.com/ZikaSVG/Anton-Vampire/releases/latest">📥 Скачать</a> ·
  <a href="https://t.me/all_tweaker">✈️ Telegram</a> ·
  <a href="https://www.tinkoff.ru/cf/2VBH9zSztcW">☕ Поддержать</a>
</p>