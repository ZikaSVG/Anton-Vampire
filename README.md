<h1 align="center">
  <img src="assets/icon.png" alt="Anton Vampire" width="130" /><br/>
  Anton Vampire
</h1>

  <p align="center">
  <b>Windows-оптимизатор на Electron</b><br/>
</p>

<p align="center">
  <a href="https://github.com/ZikaSVG/Anton-Vampire/releases/download/v1.2.0-beta/Anton.Vampire.Setup.1.2.0-beta.exe">
    <img src="https://img.shields.io/badge/%F0%9F%93%A5_Download-Setup_.exe-EA38B8?style=for-the-badge" alt="Download Setup" />
  </a>
  <a href="https://github.com/ZikaSVG/Anton-Vampire/releases/download/v1.2.0-beta/Anton.Vampire.Portable.rar">
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
    <img src="web/screenshot.jpg" alt="Anton Vampire v1.2.0-beta — главный экран" width="90%" style="border-radius: 8px;" />
  </a>
</p>

Внутри — **1000+ твиков**, сгруппированных по 13 вкладкам, **100+ тем**
(включая игровые, Catppuccin, Dark Reader, Cyberpunk),
аудит безопасности, управление автозагрузкой, службами, курсорами, обои
и портативный режим.

> ⚠️ Требуются **права администратора**. Приложение проверяет `fltmc` при старте
> и предлагает перезапуск через UAC.

---

## ✨ Новое в 1.2.0-beta

- 📖 **Полная техническая документация по кастомным планам VampireOS.** Каждый шаг `powercfg` разобран: логика скрипта, назначение каждого GUID, эффект каждой команды, риски и рекомендации.
- 🧩 **Кнопка «📖 Как это работает»** в master-detail планов VampireOS — открывает модальное окно с разбором `powercfg` для выбранного плана.
- 📋 **Справочные таблицы GUID.** `SUB_PROCESSOR`, `SUB_VIDEO`, `SUB_DISK`, `SUB_USB` — теперь с псевдонимами, диапазонами и назначением.
- 🔍 **Пояснение AC/DC-логики.** Явно показано, что `/setacvalueindex` применяется от сети, `/setdcvalueindex` — от батареи, и как это влияет на десктопы и ноутбуки.
- 🧩 **Разделение «безопасных» и «агрессивных» твиков.** `Balanced/Maximum/Power Saving` помечены как безопасные, `Energetic Death/Power Killer` — как экстремальные.
- 🛡️ **Blood Energy: пояснение разделителей.** `CommandFlags = 32` создаёт разделитель в контекстном меню, а не отдельный пункт.
- 🩹 **Исправлена опечатка** в `PK_Activate_InputLag.bat` — параметр `bc5038f7` приведён в соответствие с таблицей плана.
- 🎨 **Новые дефолты:** CSS-стиль `materialmini` и тема `vampire_the_masquerade`.

### 🧪 Статус бета

Версия помечена как **beta**: документация дополняется для редких параметров (`HETEROCLASS`, `LATENCYHINTPOLICY`), часть формулировок UI может меняться. Функционально все BAT-файлы и планы стабильны.

---

## 🧛 Планы электропитания VampireOS

В рамках установки VampireOS создаются **три фирменные схемы** (`Balanced Performance`, `Maximum Performance`, `Power Saving`) с безопасными твиками, плюс пять игровых (`NFS Racing`, `Shooter Low-Latency`, `Minimal Input Lag`, `Energetic Death`, `Power Killer`).

> 🛡️ **Скрипт идемпотентен.** При повторном запуске старые копии схем удаляются и создаются заново — дубликатов не будет.

### 📋 Список схем

| Название | База | GUID | Назначение |
| :--- | :--- | :--- | :--- |
| **Balanced Performance** | Сбалансированная | `90a358c8-3bbc-4fb3-8b4e-d7ab065d2614` | Повседневная работа |
| **Maximum Performance** | Высокая производительность | `a1b2c3d4-e5f6-4789-a0ab-cdef12345678` | Игры, тяжёлое ПО |
| **Power Saving** | Экономия энергии | `d8e76bb7-6943-4b7c-ab30-441296b72264` | Максимум автономности |
| **NFS Racing** | Высокая производительность | `b2c3d4e5-f6a7-4890-b1c2-def345678901` | Гонки, стабильный фреймтайм |
| **Shooter Low-Latency** | Высокая производительность | `c3d4e5f6-a7b8-4901-c2d3-ef4567890123` | Шутеры |
| **Minimal Input Lag** | Высокая производительность | `d4e5f6a7-b8c9-4012-d3e4-f56789012345` | Киберспорт |
| **Energetic Death** | Высокая производительность | `7f8e9d0c-1b2a-4c3d-9e8f-a0b1c2d3e4f5` | Экстрим / бенчмарки |
| **Power Killer** | Высокая производительность | `8f0a1b2c-3d4e-5f60-a1b2-c3d4e5f60718` | Абсолютный максимум |

После завершения `Add_Blood_Energy.bat` активной становится **Balanced Performance**.

---

## ⚡ Техническая документация `powercfg`

### 1. Архитектура скрипта

Скрипт написан на Batch и использует `powercfg.exe`. Каждый блок, создающий план, следует шаблону:

1. **Проверка существования:** `powercfg /list | findstr /i "%GUID%" >nul` — предотвращает дубликаты.
2. **Создание:** `powercfg /duplicatescheme <базовый_GUID> %GUID%` — клонирует стандартный план.
3. **Переименование:** `powercfg /changename %GUID% "Имя" "Описание"`.
4. **Настройка:** `powercfg /setacvalueindex` (AC) и `/setdcvalueindex` (DC).

Подавление `>nul` убирает техвывод, `2>&1` — страховка от неподдерживаемых параметров (виртуалки, старое железо).

### 2. Ключевые GUID

#### Группы настроек (Subgroup GUIDs)

| GUID | Псевдоним | Назначение |
|---|---|---|
| `54533251-82be-4824-96c1-47b60b740d00` | `SUB_PROCESSOR` | Питание процессора |
| `7516b95f-f776-4464-8c53-06167f40cc99` | `SUB_VIDEO` | Питание дисплея |
| `0012ee47-9041-4b5d-9b77-535fba8b1442` | `SUB_DISK` | Питание дисков |
| `2a737441-1930-4402-8d77-b2bebba308a3` | `SUB_USB` | Питание USB |

#### Конкретные параметры (Setting GUIDs)

| GUID | Псевдоним | Описание | Диапазон / значения |
|---|---|---|---|
| `893dee8e-2bef-41e0-89c6-b55d0929964c` | `PROCTHROTTLEMIN` | Минимальное состояние CPU (%) | 0–100 |
| `bc5038f7-23e0-4960-96da-33abaf5935ec` | `PROCTHROTTLEMAX` | Максимальное состояние CPU (%) | 0–100 |
| `3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e` | `VIDEOIDLE` | Отключение дисплея (сек) | `900`=15м, `0`=никогда |
| `5d76a2ca-e8c0-402f-a133-2158492d58ad` | `IDLEDISABLE` | Запрет простоя (C-states) | `0`=разрешён, `1`=запрещён |
| `465e1f50-b610-473a-ab58-00d1077dc418` | `PERFBOOSTMODE` | Режим Turbo Boost | `0`=off, `1`=on, `2`=aggressive |
| `40fbefc7-2e9d-4d25-a185-0cfd8574bac6` | `PERFBOOSTPOL` | Политика Turbo Boost | `0`=низкая, `1`=высокая |
| `36687f9e-e3a5-4dbf-b1dc-15eb381c6863` | `PERFEPP` | Energy Performance Preference | `0`=performance, `100`=efficiency |
| `be337238-0d82-4146-a960-4f3749d470c7` | `PERFDISTRIBUTETYPE` | Распределение по ядрам | `0`=auto, `1`=perf, `2`=aggressive |
| `94d3a615-a899-4ac5-ae2b-e4d8f634367f` | `SYSCOOLPOL` | Политика охлаждения | `0`=passive, `1`=active |
| `0cc5b647-c1df-4637-891a-dec35c318583` | `CPMINCORES` | Мин. непаркованных ядер (%) | 0–100 |
| `ea062031-0e34-4ff1-9b6d-eb1059334028` | `CPMAXCORES` | Макс. паркованных ядер (%) | 0–100 |
| `6738e2c4-e8a5-4a42-b16a-e040e769756e` | `DISKIDLE` | Отключение диска (сек) | `0`=никогда |
| `48e6b7a6-50f5-4782-a5d4-53bb8f07e226` | `USBSUSPEND` | Выборочная приостановка USB | `0`=off, `1`=on |

### 3. Детальный разбор планов

#### 3.1 Balanced Performance

**База:** `381b4222-...` (Сбалансированный).

| Параметр | AC | DC | Эффект |
|---|---|---|---|
| `VIDEOIDLE` | 900 (15 мин) | 300 (5 мин) | Экран гаснет реже от сети, быстрее от батареи. |

**Итог:** стабильный план без агрессивных CPU-твиков.

#### 3.2 Maximum Performance

**База:** `8c5e7fda-...` (Высокая производительность).

| Параметр | AC | DC | Эффект |
|---|---|---|---|
| `VIDEOIDLE` | 900 | 600 | 15/10 минут — компромисс для игр без розетки. |

**Итог:** усиленная стандартная схема, безопасна.

#### 3.3 Power Saving

**База:** `a1841308-...` (Экономия энергии).

| Параметр | AC | DC | Эффект |
|---|---|---|---|
| `VIDEOIDLE` | 300 | 120 | Агрессивное отключение экрана. |

**Итог:** максимальная автономность.

#### 3.4 NFS Racing

**База:** Высокая производительность.

| Параметр | AC | DC | Эффект |
|---|---|---|---|
| `PROCTHROTTLEMIN` | 100 | 100 | CPU не опускается ниже 100% |
| `PROCTHROTTLEMAX` | 100 | 100 | Потолок снят |
| `CPMINCORES` | 100 | 100 | Все ядра активны |
| `VIDEOIDLE` | 900 | 600 | Экран не гаснет 15/10 мин |

**Итог:** «зажимает» CPU в состояние максимальной готовности. Ровный фреймтайм, но выше нагрев.

#### 3.5 Shooter Low-Latency

Наследует **NFS Racing** и добавляет:

| Параметр | AC | DC | Эффект |
|---|---|---|---|
| `PERFBOOSTMODE` | 2 | 2 | Агрессивный Turbo Boost |
| `PERFBOOSTPOL` | 1 | 1 | Высокая политика буста |

**Итог:** отзывчивее в пиковых нагрузках. Теоретически ниже задержка между действием и реакцией.

#### 3.6 Minimal Input Lag

Наследует **Shooter** и добавляет:

| Параметр | AC | DC | Эффект |
|---|---|---|---|
| `IDLEDISABLE` | 1 | 1 | Запрет C-states — ядра всегда C0 |

**Итог:** самый агрессивный профиль по отклику. Только для десктопов с хорошим охлаждением. На ноутбуках — быстрый разряд и нагрев.

#### 3.7 Energetic Death

Объединяет почти все агрессивные настройки:

| Параметр | AC/DC | Значение |
|---|---|---|
| `PROCTHROTTLEMIN/MAX` | оба | 100/100 |
| `CPMINCORES` | оба | 100 |
| `IDLEDISABLE` | оба | 1 |
| `PERFBOOSTMODE` | оба | 2 |
| `PERFBOOSTPOL` | оба | 0 |
| `PERFEPP` | оба | 0 |
| `PERFDISTRIBUTETYPE` | оба | 2 |
| `SYSCOOLPOL` | оба | 1 (Active) |
| `VIDEOIDLE` | оба | 0 |
| `DISKIDLE` | оба | 0 |
| `USBSUSPEND` | оба | 0 |

**Итог:** максимум возможного. Энергопотребление и тепло — максимальны.

#### 3.8 Power Killer

Наследует **Energetic Death** и добавляет:

| Параметр | AC/DC | Значение |
|---|---|---|
| `CPMAXCORES` | оба | 100 |

**Итог:** гарантирует, что ни одно ядро не припарковано. Разница с Energetic Death минимальна, заметна только на многоядерных CPU.

### 4. Важные замечания

1. **Скрытые параметры.** Многие GUID (`PERFEPP`, `IDLEDISABLE`, `PERFBOOSTMODE`) скрыты в GUI. `powercfg` меняет их напрямую.
2. **Аппаратная зависимость.** Эффект `PERFEPP`, `PERFBOOSTMODE`, `PERFDISTRIBUTETYPE` зависит от архитектуры CPU (Intel Speed Shift, AMD CPPC) и прошивки.
3. **Риски перегрева.** Планы `Minimal Input Lag`, `Energetic Death`, `Power Killer` отключают энергосбережение. На ноутбуках — троттлинг по температуре.
4. **Автоматического применения нет.** Скрипт создаёт планы, но не активирует их.
5. **Идемпотентность.** Повторный запуск не создаёт дубликатов, но и не обновляет уже существующие планы.

### 5. Сводная таблица

| План | База | Особенность | Рекомендация |
|---|---|---|---|
| Balanced Performance | Сбалансированный | Увеличенный тайм-аут дисплея | Офис, браузинг |
| Maximum Performance | Высокая производительность | Усиленный стандарт | Игры, тяжёлое ПО |
| Power Saving | Экономия энергии | Агрессивное отключение экрана | Автономность |
| NFS Racing | Высокая производительность | 100% мин/макс CPU, все ядра | Гонки |
| Shooter Low-Latency | Высокая производительность | Агрессивный Turbo Boost | Шутеры |
| Minimal Input Lag | Высокая производительность | Запрет C-states | Киберспорт (десктоп) |
| Energetic Death | Высокая производительность | EPP=0, активное охлаждение | Бенчмарки |
| Power Killer | Высокая производительность | Запрет парковки ядер | Максимум многопотока |

> 💡 **Совет.** На ноутбуке при работе от батареи переключитесь на `Power Saving` — `Energetic Death` и `Power Killer` приведут к быстрому разряду.

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
- **Звуки** на Web Audio API
- **Эффект стекла**: `none` / `glass` / `aero` (Mica/Acrylic)

### 🛡️ 13 вкладок

| # | Вкладка | Что делает |
|---|---|---|
| 1 | 🏠 **Главная** | Приветствие, polling CPU/GPU/RAM/диск |
| 2 | 🛡️ **Безопасность** | 3 аудита (21+14+13), Firewall, NetMon, HTML-отчёты |
| 3 | 🚀 **Автозагрузка** | Папки, реестр, задачи, службы + категоризация |
| 4 | ⚡ **Оптимизация** | 7 источников + вендор-панель |
| 5 | 🧹 **Очистка** | 12 секций: шейдеры, логи, кэши, Temp |
| 6 | ⚜️ **Исправления** | DISM, SFC, CHKDSK, сеть, устройства, игры |
| 7 | 🎮 **Игровой режим** | Планы (14), Power Killer (6), службы (200+) |
| 8 | 🧛 **Вампир** | VampireOS: 13 категорий, Power Max / Power Save |
| 9 | 🔋 **Электропитание** | Power Killer + таблица планов + 100+ источников + разбор powercfg |
| 10 | ⚙️ **Службы** | Таблица: поиск, статусы, бэкап `.reg` |
| 11 | 🎨 **Кастомизация** | Курсоры с превью + 4 источника |
| 12 | 📦 **Приложения** | Appx, Defender/Edge/OneDrive/WebView2 |
| 13 | ⚙️ **Настройки** | 6 под-вкладок |

### ⚙️ Механики
- **7 режимов запуска твиков**: `default` · `no_launcher` · `launcher` · `powerrun` · `nsudolg` · `minsudo` · `cmd`
- **Патчинг `.bat`**: вырезает `pause`/`timeout`/`choice`, превращает `start` → `start /b ""`
- **Стрим вывода** UTF-8 → cp866 fallback
- **Пары «твик ↔ отмена»** с кнопкой ↩
- **Portable mode**: всё в `extreme_data/`
- **Безопасный бэкап служб**: `.reg` + fallback `Start=3`
- **Проверка дубликатов** при импорте планов
- **Отключение выделения чекбоксов** — защита от случайного запуска

---

## 🧛 Вампир (VampireOS)

Глобальная оптимизация Windows. **Изменения вносятся в реестр, службы и системные файлы. Часть изменений (Defender, OneDrive) необратима.**

| Категория | Что делает |
|---|---|
| 📊 **Телеметрия** | Уровень = 0, отключение DiagTrack/WER/TIP, блокировка через IFEO |
| 🔄 **Обновления** | Отключение wuauserv/UsoSvc/BITS/DoSvc, блокировка Edge |
| 🧠 **Система и ядро** | Win32PrioritySeparation=38, Memory Compression off, MSI mode, BCD |
| 🌐 **Сеть** | DefaultTTL=65, TCPNoDelay=1, Wi-Fi Sense off |
| 🖥️ **Проводник** | Классическое контекстное меню, MenuShowDelay=0 |
| 🖱️ **Мышь** | MouseSpeed=0, автозамена off |
| 🖨️ **Службы** | Spooler, Fax, DPS, WerSvc off |
| 📜 **Журналы** | AutoBackupLogFiles off, очистка через `wevtutil` |
| 🧹 **Прочее** | ReserveManager, Storage Sense, GameDVR, FSO off |
| 📂 **Меню «Создать»** | .bat, .reg, .ps1, .vbs, подменю питания |
| ⚡ **Питание** | 8 схем VampireOS с разбором `powercfg` |

> ⚠️ **Убить KCAS и Xeon** — только десктопы. **Режим Деда** — ноутбуки.

---

## 🎮 Игровой режим 2.0

### 📦 Готовые планы (14)

| План | Описание |
|---|---|
| `Amit_v1_lowlatency` | Низкая задержка ввода |
| `Amit_v2_extreme performance` | Максимум |
| `Amit_v3_low latency` | Минимальная задержка |
| `Atlas Power Plan` | От AtlasOS |
| `Bitsum Highest Performance` | Максимальная частота |
| `Calypto` | Баланс |
| `GGOSv0_8_5_Idle_Enabled` | GGOS с idle |
| `Light pow v` | Лёгкий |
| `Muren_Idle_Enabled` | Muren с idle |
| `Quaked Ultimate Performance Idle Off` | Максимум, idle off |
| `Quaked Ultimate Performance` | Абсолютный максимум |
| `Unixcorn_Idle_Enabled` | Unixcorn с idle |
| `XOS imribiy` | От XOS |
| `Zoyata_Low Latency` | Для шутеров |

🛡️ **Защита от дубликатов** при импорте.
💡 **Совет:** для ноутбуков — планы с `Idle_Enabled`.

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
- **200+ служб** в `SAFE_SERVICES`
- **Защищённые категории:** питание, ввод, сеть, темы, ядра
- **Автобэкап** реестра в `.reg`
- **Fallback** `Start=3` при отсутствии бэкапа

---

## ⚙️ Службы (выделенная вкладка)

- **Таблица**: имя, описание, статус, действия, теги сборок
- **Поиск** по имени и описанию
- **Массовое управление**
- **Статусы** через `Get_Services_Status.bat`
- **Кнопки** ▶ Вкл / ⏹ Выкл в каждой строке
- **Бэкап** `Services_Backup.reg` + восстановление
- **Теги сборок** (ReviOS, AtlasOS, XOS, VainOS)

---

## 📥 Скачать

<table>
<tr>
<td align="center" width="50%">

### 📥 Setup
Установщик NSIS.

[**Скачать Setup .exe →**](https://github.com/ZikaSVG/Anton-Vampire/releases/download/v1.2.0-beta/Anton.Vampire.Setup.1.2.0-beta.exe)

</td>
<td align="center" width="50%">

### 📦 Portable
Архив `.rar`, всё в `extreme_data/`.

[**Скачать Portable .rar →**](https://github.com/ZikaSVG/Anton-Vampire/releases/download/v1.2.0-beta/Anton.Vampire.Portable.rar)

</td>
</tr>
</table>

### Установка одной командой

```cmd
curl -g -k -L -# -o "%temp%\AntonVampire.Setup.exe" "https://github.com/ZikaSVG/Anton-Vampire/releases/download/v1.2.0-beta/Anton.Vampire.Setup.1.2.0-beta.exe" && start "" "%temp%\AntonVampire.Setup.exe"
```

### Из исходников

```bash
git clone https://github.com/ZikaSVG/Anton-Vampire.git
cd Anton-Vampire
npm install
npm start
npm run build
```

---

## 🧱 Стек

| Слой | Технологии |
|---|---|
| Runtime | Electron 44 · Node.js |
| Renderer | Vanilla JS · HTML · CSS |
| Стили | 8 CSS-файлов + CSS-переменные |
| Темы | `renderer/themes.js` (100+ тем) |
| Шрифты | локальные `.woff2` |
| Сборка | `electron-builder` → NSIS |
| Утилиты | PowerShell · `7z.exe` · `NSudoLG.exe` · `PowerRun.exe` · `MinSudo.exe` |
| Данные | JSON · UTF-8 · `extreme_data/settings.json` |

---

## 📁 Структура проекта

```
Anton-Vampire/
├── main.js
├── preload.js
├── package.json
├── src/
│   ├── main/
│   │   ├── config.js
│   │   ├── logger.js
│   │   ├── tweak-runner.js
│   │   ├── startup.js
│   │   └── tabs-data.js
│   ├── renderer/
│   │   ├── app.js
│   │   ├── sections.js
│   │   ├── sidebar.js
│   │   ├── themes.js
│   │   ├── logger.js
│   │   ├── components/
│   │   ├── styles/
│   │   ├── tabs/
│   │   └── utils/
│   └── styles/
│       ├── default.css
│       ├── pixel.css
│       ├── material3.css
│       ├── kitty.css
│       ├── cyberpunk.css
│       ├── minipunk.css
│       ├── altpunk.css
│       └── materialmini.css
├── tweaks/
├── assets/
├── Utils/
├── extreme_data/
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
    "ui_style": "materialmini",
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

```
AntonVampire.exe
extreme_data/
├── settings.json
├── logs/
├── backgrounds/
├── wallpapers/
├── cursor_icons/
├── cursors_cache/
├── cursors_temp/
├── config_backups/
└── electron_userdata/
```

В `%APPDATA%` и `%LOCALAPPDATA%` **ничего не пишется**.

---

## 🎨 Добавить свои твики

1. Положите файл в `tweaks/<button>/<tab>/`
2. Добавьте описание в `tweaks/descriptions.txt`
3. **Настройки → Утилиты → build_all_tabs.py → ▶ Запустить**
4. Готово

---

## 🛠 Утилиты сборки

| Скрипт | Назначение |
|---|---|
| `build_all_tabs.py` | Оркестратор |
| `build_tabs.py` | `tabs.json` |
| `build_full_tabs.py` | расширенный |
| `build_hardening_json.py` | HardeningKitty |
| `build_apps_json.py` | `apps_optimization_tabs.json` |
| `build_drivers_json.py` | `drivers_tabs.json` |
| `build_removal_json.py` | `removal_tabs.json` |
| `audit_tweaks.py` | Проверка целостности |

---

## 🩺 Troubleshooting

### Приложение не запускается
- Запустите от администратора
- Включите `logs_enabled` → `extreme_data/logs/`

### Антивирус ругается
- Нет цифровой подписи
- Меняет реестр / службы
- Использует `NSudoLG.exe`, `PowerRun.exe`, `MinSudo.exe`

→ Добавьте папку в исключения.

### Твик зависает
- Таймаут 5 минут. Увеличьте в **Настройки → Интерфейс**
- Смените режим: `nsudolg` → `powerrun` → `minsudo` → `cmd`

### Кракозябры в логе
Пересохраните `.bat` в UTF-8.

### План не активируется
- 📥 Импортировать → ⚡ Активировать
- Если план уже есть — дубликат не создаётся

### Службы не восстанавливаются
- Проверьте `Services_Backup.reg`
- Fallback `Start=3`
- Создайте бэкап заново

### Курсоры не применяются
- Проверьте `.cur` / `.ani` в архиве
- Папка `C:\Windows\Cursors\<name>\`
- «🗑️ Удалить все» для сброса

---

## ⌨️ Горячие клавиши

| Клавиша | Действие |
|---|---|
| <kbd>F1</kbd> | Сайт проекта |
| <kbd>F5</kbd> | Перезагрузить renderer |
| <kbd>F11</kbd> | Fullscreen |
| <kbd>Ctrl</kbd>+<kbd>F</kbd> | Фокус в поиск |
| <kbd>Esc</kbd> | Закрыть dropdown |

---

## 🔒 Безопасность

- Только администратор
- **Никакой телеметрии**
- Всё локально
- Portable
- Прозрачный код
- Бэкапы в `extreme_data/`

---

## 📜 Лицензия

**CC BY-NC-SA 4.0**

| | |
|---|---|
| ✅ Можно | Форкать, изменять, распространять |
| ❌ Нельзя | Продавать, закрывать код |
| 📌 Обязательно | Указывать авторство |

### Сторонние ресурсы

| Ресурс | Лицензия |
|---|---|
| Papirus icons | GPL-3.0 / LGPL-3.0 / CC-BY-SA-4.0 |
| XOS / SOS / IMOS tweaks | Лицензии авторов |
| Utils/ | Собственные лицензии |

---

## ❤️ Благодарности

- **[Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)** — иконки
- **XOS / SapphireOS / ImmortalOS / SystemX / Igromanoff / VainOS / SynergyOS / MartyFiles / scode18** — твики
- **[7-Zip](https://www.7-zip.org/)**
- **[NSudo](https://github.com/M2Team/NSudo)**
- **[PowerRun](https://www.sordum.org/9416/powerrun-v1-7-run-with-the-highest-privileges/)**

---

## ⚠️ Отказ от ответственности

**Anton Vampire изменяет системные настройки Windows.** Используйте на свой страх и риск.

- Автор не несёт ответственности
- Всегда создавайте бэкап
- Начинайте с базовых пресетов
- **VampireOS необратим** — только с бэкапом
- Программа «как есть»

---

<p align="center">
  <b>🩸 Anton Vampire</b> · v1.2.0-beta · 2026<br/>
</p>

<p align="center">
  <a href="https://github.com/ZikaSVG/Anton-Vampire/releases/latest">📥 Скачать</a> ·
  <a href="https://t.me/all_tweaker">✈️ Telegram</a> ·
  <a href="https://www.tinkoff.ru/cf/2VBH9zSztcW">☕ Поддержать</a>
</p>