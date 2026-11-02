@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ДОБАВЛЕНИЕ ВСЕХ ПУНКТОВ ПИТАНИЯ
echo                      В КОНТЕКСТНОЕ МЕНЮ РАБОЧЕГО СТОЛА
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт добавляет в контекстное меню рабочего стола пункт "Choose Power Plan".
echo При нажатии появляется подменю со следующими пунктами:
echo.
echo   [1] Power Saver (Экономия энергии)     - снижает частоту CPU, экономит заряд
echo   [2] Balanced (Сбалансированная)        - стандартный режим Windows по умолчанию
echo   [3] High Performance (Высокая произв.) - фиксирует CPU на максимальной частоте
echo   [4] XOS Power Plan                     - кастомный план производительности xOS
echo   [5] Disable Idle                       - отключает C-состояния процессора
echo   [6] Enable Idle                        - включает C-состояния процессора
echo   [7] Power Options                      - открывает классическую панель питания
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] Переключение схем в два клика, не открывая панель управления
echo [+] Полезно для игр - быстро включить High Performance и отключить Idle
echo [+] На ноутбуке - быстро переключить на Экономию при работе от батареи
echo [+] Не требует перезагрузки, применяется мгновновенно
echo [+] Disable Idle помогает снизить задержки в играх и аудио/видеоредакторах
echo [+] Удобное переключение режимов работы процессора в два клика
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Добавляет дополнительные пункты в контекстное меню (для кого-то мусор)
echo [-] Случайное нажатие может переключить схему в неподходящий момент
echo [-] XOS Power Plan будет работать только если схема импортирована в систему
echo [-] Disable Idle - увеличивает энергопотребление
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте от имени Администратора
echo [2] Запускайте один раз - изменения сохраняются навсегда
echo [3] Disable Idle - рекомендуется включать ПЕРЕД игрой
echo [4] Enable Idle - рекомендуется включать ПОСЛЕ игры
echo [5] На десктопах можно оставить Disable Idle постоянно
echo [6] На ноутбуках используйте Disable Idle только от сети
echo [7] Чтобы удалить пункты меню, запустите скрипт отмены
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ОШИБКА] Запустите от имени Администратора!
    echo.
    exit /b 1
)

echo [ЧАСТЬ 1] ИМПОРТ XOS POWER PLAN...
echo.

set POWER_PLAN_PATH="C:\Apps\Extreme\tweaks\Электропитание\Все планы электропитания\XOS Power Plan.pow"

if exist %POWER_PLAN_PATH% (
    echo Файл XOS Power Plan.pow найден, выполняю импорт...
    powercfg -import %POWER_PLAN_PATH% 31693169-3169-3169-3169-316931693169 >nul 2>&1
    echo [OK] Импорт выполнен
) else (
    echo [ПРЕДУПРЕЖДЕНИЕ] Файл XOS Power Plan.pow НЕ НАЙДЕН!
    echo Проверьте путь: C:\Apps\Extreme\tweaks\Электропитание\Все планы электропитания\
    echo Пункт XOS Power Plan будет недоступен.
)
echo.

echo [ЧАСТЬ 2] ДОБАВЛЕНИЕ ОСНОВНОГО МЕНЮ POWERPLAN...
echo.

Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan" /v "Icon" /t REG_SZ /d "powercpl.dll" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan" /v "MUIVerb" /t REG_SZ /d "Choose Power Plan" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan" /v "Position" /t REG_SZ /d "Middle" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan" /v "SubCommands" /t REG_SZ /d "" /f >nul
echo [OK] Основное меню PowerPlan создано
echo.

echo [ЧАСТЬ 3] ДОБАВЛЕНИЕ ПУНКТОВ СХЕМ ПИТАНИЯ...
echo.

echo [1/7] Добавление Power Saver (Экономия энергии)...
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\01menu" /v "MUIVerb" /t REG_SZ /d "Power Saver" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\01menu" /v "Icon" /t REG_SZ /d "powercpl.dll" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\01menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive a1841308-3541-4fab-bc81-f71556f20b4a" /f >nul
echo [OK] Power Saver добавлен
echo.

echo [2/7] Добавление Balanced (Сбалансированная)...
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\02menu" /v "MUIVerb" /t REG_SZ /d "Balanced" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\02menu" /v "Icon" /t REG_SZ /d "powercpl.dll" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\02menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive 381b4222-f694-41f0-9685-ff5bb260df2e" /f >nul
echo [OK] Balanced добавлен
echo.

echo [3/7] Добавление High Performance (Высокая производительность)...
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\03menu" /v "MUIVerb" /t REG_SZ /d "High Performance" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\03menu" /v "Icon" /t REG_SZ /d "powercpl.dll" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\03menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" /f >nul
echo [OK] High Performance добавлен
echo.

echo [4/7] Добавление XOS Power Plan...
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\04menu" /v "MUIVerb" /t REG_SZ /d "XOS Power Plan" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\04menu" /v "Icon" /t REG_SZ /d "powercpl.dll" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\04menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive 31693169-3169-3169-3169-316931693169" /f >nul
echo [OK] XOS Power Plan добавлен
echo.

echo [ЧАСТЬ 4] ДОБАВЛЕНИЕ ПУНКТОВ УПРАВЛЕНИЯ IDLE...
echo.

echo [5/7] Добавление Disable Idle (отключение простоя процессора)...
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v "MUIVerb" /t REG_SZ /d "Disable Idle" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v "Icon" /t REG_SZ /d "powercpl.dll" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v "CommandFlags" /t REG_DWORD /d "32" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 && powercfg -setactive scheme_current" /f >nul
echo [OK] Disable Idle добавлен
echo.

echo [6/7] Добавление Enable Idle (включение простоя процессора)...
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /v "MUIVerb" /t REG_SZ /d "Enable Idle" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /v "Icon" /t REG_SZ /d "powercpl.dll" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 && powercfg -setactive scheme_current" /f >nul
echo [OK] Enable Idle добавлен
echo.

echo [ЧАСТЬ 5] ДОБАВЛЕНИЕ ПУНКТА POWER OPTIONS...
echo.

echo [7/7] Добавление Power Options (панель управления питанием)...
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\07menu" /v "MUIVerb" /t REG_SZ /d "Power Options" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\07menu" /v "Icon" /t REG_SZ /d "powercpl.dll" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\07menu" /v "CommandFlags" /t REG_DWORD /d "32" /f >nul
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\07menu\command" /ve /t REG_SZ /d "control.exe powercfg.cpl" /f >nul
echo [OK] Power Options добавлен
echo.

echo ================================================================================
echo               ГОТОВО! ВСЕ ПУНКТЫ ДОБАВЛЕНЫ В КОНТЕКСТНОЕ МЕНЮ
echo ================================================================================
echo.
echo Что добавлено:
echo   - Power Saver (Экономия энергии)
echo   - Balanced (Сбалансированная)
echo   - High Performance (Высокая производительность)
echo   - XOS Power Plan (кастомный план xOS)
echo   - Disable Idle (отключение простоя процессора)
echo   - Enable Idle (включение простоя процессора)
echo   - Power Options (панель управления питанием)
echo.
echo Как использовать:
echo   - Нажмите ПКМ на рабочем столе
echo   - Выберите "Choose Power Plan"
echo   - Выберите нужный пункт
echo.
echo Результат:
echo   - Power Saver: экономия энергии для ноутбуков
echo   - Balanced: стандартный режим Windows
echo   - High Performance: максимальная производительность
echo   - XOS Power Plan: кастомный план xOS
echo   - Disable Idle: процессор всегда на максимальной частоте
echo   - Enable Idle: процессор снижает частоту в простое
echo   - Power Options: открывает панель управления питанием
echo.
echo Для удаления пунктов используйте скрипт "Удаление всех пунктов питания из контекстного меню.bat"
echo.

echo.