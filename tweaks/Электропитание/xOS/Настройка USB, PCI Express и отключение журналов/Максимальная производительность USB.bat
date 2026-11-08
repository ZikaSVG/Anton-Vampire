@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ПОЛНАЯ НАСТРОЙКА USB
echo        (100%% ПРОИЗВОДИТЕЛЬНОСТЬ + USBHUB3 + USBCCGP ОПТИМИЗАЦИЯ)
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт объединяет настройки для максимальной производительности
echo USB-устройств:
echo.
echo ЧАСТЬ 1 - Настройка USB через Power Settings:
echo   - Устанавливает 100%% производительности для USB
echo   - Отключает энергосбережение USB
echo   - USB-устройства никогда не засыпают
echo.
echo ЧАСТЬ 2 - Настройка USBHUB3 (USB 3.0 контроллер):
echo   - DisableLPM (отключение Link Power Management)
echo   - D3ColdSupported (отключение холодного состояния)
echo   - DisableSelectiveSuspendUI (отключение выборочного отключения)
echo   - Ceip (отключение телеметрии)
echo.
echo ЧАСТЬ 3 - Настройка usbccgp (составные USB-устройства):
echo   - D3ColdSupported (отключение холодного состояния)
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] УСТРАНЯЕТ ЗАДЕРЖКИ МЫШИ И КЛАВИАТУРЫ
echo [+] ГЕЙМПАДЫ НЕ "ОТВАЛИВАЮТСЯ" в играх
echo [+] USB-ЗВУК РАБОТАЕТ БЕЗ ТРЕСКА И ЩЕЛЧКОВ
echo [+] USB 3.0 ПОРТЫ РАБОТАЮТ СТАБИЛЬНЕЕ
echo [+] РЕШАЕТ ПРОБЛЕМЫ С ОТКЛЮЧЕНИЕМ USB-ХАБОВ
echo [+] КЛАВИАТУРЫ С ХАБАМИ НЕ ОТВАЛИВАЮТСЯ
echo [+] ОСОБЕННО ПОЛЕЗНО ДЛЯ VR-ШЛЕМОВ
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Увеличивается энергопотребление USB-портов в простое
echo [-] На ноутбуках быстрее садится батарея (на 5-15%)
echo [-] USB-контроллер всегда активен
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] ДЕСКТОПЫ - ОДНОЗНАЧНО РЕКОМЕНДУЕТСЯ для геймеров
echo [2] НОУТБУКИ - ТОЛЬКО ПРИ ИГРЕ ОТ СЕТИ
echo [3] Если после применения мышь/клава перестали работать - перезагрузитесь
echo [4] При проблемах с VR-шлемом - этот скрипт обязателен
echo [5] При проблемах с USB-хабами - этот скрипт решит их
echo [6] Для отката используйте скрипт отмены в папке Undo
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo.
echo [ЧАСТЬ 1] Настройка USB через Power Settings (100%% производительность)...
echo.

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "Attributes" /t REG_DWORD /d 2 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\ea062031-0e34-4ff1-9b6d-eb1059334028" /v "Attributes" /t REG_DWORD /d 2 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 ea062031-0e34-4ff1-9b6d-eb1059334028 100
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 ea062031-0e34-4ff1-9b6d-eb1059334028 100

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1" /v "Attributes" /t REG_DWORD /d 2 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 943c8cb6-6f93-4227-ad87-e9a3feec08d1 100
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 943c8cb6-6f93-4227-ad87-e9a3feec08d1 100

powercfg -setactive SCHEME_CURRENT

echo [OK] Часть 1 завершена
echo.

echo [ЧАСТЬ 2] Настройка USBHUB3 (USB 3.0 контроллер)...
echo.

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "DisableLPM" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "D3ColdSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "Ceip" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "DisableSelectiveSuspendUI" /t REG_DWORD /d "1" /f

echo [OK] Часть 2 завершена
echo.

echo [ЧАСТЬ 3] Настройка usbccgp (составные USB-устройства)...
echo.

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\usbccgp\Parameters" /v "D3ColdSupported" /t REG_DWORD /d "0" /f

echo [OK] Часть 3 завершена
echo.

echo ================================================================================
echo                         ГОТОВО! ПОЛНАЯ НАСТРОЙКА USB ВЫПОЛНЕНА
echo ================================================================================
echo.
echo Что сделано:
echo   - USB порты работают на 100%% производительности (без сна)
echo   - Отключено энергосбережение USB через Power Settings
echo   - Отключен Link Power Management (LPM) для USB 3.0
echo   - Отключено холодное состояние D3 для USBHUB3
echo   - Отключено холодное состояние D3 для usbccgp
echo   - Отключен сбор телеметрии Ceip
echo   - Отключен интерфейс выборочного отключения
echo.
echo Для полного применения изменений рекомендуется перезагрузить компьютер.
echo.

echo.