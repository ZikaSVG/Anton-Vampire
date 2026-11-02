@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ВОЗВРАТ НАСТРОЕК USB
echo            (СТАНДАРТНЫЕ НАСТРОЙКИ WINDOWS + ХОЛОДНОЕ СОСТОЯНИЕ)
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт ВОССТАНАВЛИВАЕТ стандартные настройки USB Windows.
echo Это полный откат для скрипта "Настройка USB (100%% производительность + USBHUB3)"
echo.
echo ЧАСТЬ 1 - Возврат настроек USB через Power Settings:
echo   - Возвращает стандартные значения энергосбережения USB
echo   - USB-устройства снова могут засыпать
echo.
echo ЧАСТЬ 2 - Возврат настроек USBHUB3 (USB 3.0 контроллер):
echo   - DisableLPM (включение Link Power Management)
echo   - D3ColdSupported (включение холодного состояния)
echo   - DisableSelectiveSuspendUI (включение выборочного отключения)
echo   - Ceip (включение телеметрии)
echo.
echo ЧАСТЬ 3 - Включение холодного состояния D3 для USB:
echo   - Включение D3Cold для USBHUB3
echo   - Включение D3Cold для usbccgp
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] Восстанавливает стандартное энергосбережение USB
echo [+] На ноутбуках увеличивает время автономной работы
echo [+] Уменьшает нагрев USB-контроллера
echo [+] Возвращает настройки к состоянию по умолчанию
echo [+] Экономит энергию в режиме сна
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Могут вернуться задержки мыши после бездействия
echo [-] USB-устройства могут "засыпать" и просыпаться с задержкой
echo [-] Возможны микро-лаги в играх из-за энергосбережения USB
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте на ноутбуках для экономии батареи
echo [2] Запускайте если после оптимизации возникли проблемы с USB
echo [3] После возврата рекомендуется перезагрузить компьютер
echo [4] Это стандартные настройки Windows
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo.
echo [ЧАСТЬ 1] Возврат настроек USB через Power Settings (стандарт)...
echo.

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "Attributes" /t REG_DWORD /d 1 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 50
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 50

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\ea062031-0e34-4ff1-9b6d-eb1059334028" /v "Attributes" /t REG_DWORD /d 1 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 ea062031-0e34-4ff1-9b6d-eb1059334028 50
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 ea062031-0e34-4ff1-9b6d-eb1059334028 50

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1" /v "Attributes" /t REG_DWORD /d 1 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 943c8cb6-6f93-4227-ad87-e9a3feec08d1 50
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 943c8cb6-6f93-4227-ad87-e9a3feec08d1 50

powercfg -setactive SCHEME_CURRENT

echo [OK] Часть 1 завершена
echo.

echo [ЧАСТЬ 2] Возврат настроек USBHUB3 (стандартные значения Windows)...
echo.

Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "DisableLPM" /f >nul 2>&1
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "D3ColdSupported" /f >nul 2>&1
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "Ceip" /f >nul 2>&1
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "DisableSelectiveSuspendUI" /f >nul 2>&1

echo [OK] Часть 2 завершена
echo.

echo [ЧАСТЬ 3] Включение холодного состояния D3 для USB...
echo.

Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\usbccgp\Parameters" /v "D3ColdSupported" /f >nul 2>&1
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\usbccgp\Parameters" /v "D3ColdSupported" /f >nul 2>&1

echo [OK] Часть 3 завершена
echo.

echo ================================================================================
echo                    ГОТОВО! НАСТРОЙКИ USB ВОССТАНОВЛЕНЫ
echo ================================================================================
echo.
echo Что сделано:
echo   - USB порты возвращены к стандартным настройкам энергосбережения
echo   - Восстановлен Link Power Management (LPM) для USB 3.0
echo   - Включено холодное состояние D3 для USBHUB3
echo   - Включено холодное состояние D3 для usbccgp
echo   - Включен сбор телеметрии Ceip
echo   - Настройки Windows возвращены к стандарту
echo.
echo Для полного применения изменений рекомендуется перезагрузить компьютер.
echo.

echo.