@echo off
chcp 65001 >nul
title xOS: Отключение служб ноутбуков и планшетов (ТОЛЬКО ДЛЯ ПК)

echo.
echo ================================================================================
echo              xOS PLAYBOOK - ОТКЛЮЧЕНИЕ СЛУЖБ НОУТБУКОВ И ПЛАНШЕТОВ
echo                       (ТОЛЬКО ДЛЯ ПК БЕЗ ТАЧПАДА!)
echo ================================================================================
echo.
echo [ ОПИСАНИЕ ]
echo --------------------------------------------------------------------------------
echo Отключает службы тачпада (Synaptics / ELAN / Alps / Dell) и драйвер батареи.
echo Если службы нет в системе — она молча пропускается.
echo.
echo Отключаемые службы:
echo   - SynTPEnh           - Synaptics TouchPad Enhancements
echo   - SynTPEnhService    - Synaptics TouchPad Service
echo   - SynTP              - Synaptics TouchPad Driver
echo   - ETDService         - ELAN Touchpad Service
echo   - ETDCtrl            - ELAN Touchpad Control
echo   - ETDControl         - ELAN Touchpad Control (alt)
echo   - ApfiltrService     - Alps Touchpad Filter
echo   - DellTouchpad       - Dell Touchpad
echo   - TouchPad           - Generic Touchpad
echo   - TPP                - TouchPad Processor
echo   - Cmbatt             - Microsoft Battery Driver
echo.
echo Все службы переводятся в режим "Отключена" (Start = 4).
echo.
echo [ ПЛЮСЫ ]
echo --------------------------------------------------------------------------------
echo   [+] Убирает лишние драйверы из памяти на десктопе
echo   [+] Снижает количество фоновых процессов
echo   [+] Ускоряет загрузку системы
echo   [+] Тачпад и батарея на десктопе всё равно не используются
echo.
echo [ МИНУСЫ ]
echo --------------------------------------------------------------------------------
echo   [-] НА НОУТБУКЕ ЭТИ СЛУЖБЫ ОТКЛЮЧАТЬ НЕЛЬЗЯ (тачпад перестанет работать!)
echo   [-] На планшетах и трансформерах тачскрин/тачпад перестанут работать
echo   [-] На некоторых десктопах может повлиять на ACPI-кнопку питания
echo.
echo [ РЕКОМЕНДАЦИИ ]
echo --------------------------------------------------------------------------------
echo   [1] ЗАПУСКАТЬ ТОЛЬКО НА СТАЦИОНАРНЫХ ДЕСКТОПАХ БЕЗ ТАЧПАДА!
echo   [2] На ноутбуках/планшетах - НЕ ЗАПУСКАТЬ!
echo   [3] Для отката используйте "Включение служб ноутбуков и планшетов.bat"
echo.
echo [ ПРИМЕНЕНИЕ ]
echo --------------------------------------------------------------------------------
echo.

echo Отключаю службы тачпада и батареи...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SynTPEnh"          /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SynTPEnhService"   /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SynTP"             /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ETDService"        /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ETDCtrl"           /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ETDControl"        /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ApfiltrService"    /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DellTouchpad"      /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TouchPad"          /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TPP"               /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Cmbatt"            /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

echo.
echo ================================================================================
echo            ГОТОВО! СЛУЖБЫ НОУТБУКОВ И ПЛАНШЕТОВ ОТКЛЮЧЕНЫ
echo ================================================================================
echo.
echo ВНИМАНИЕ!!!
echo   Этот скрипт ТОЛЬКО для десктопов без тачпада!
echo   Если вы на ноутбуке - немедленно запустите:
echo     "Включение служб ноутбуков и планшетов.bat"
echo.
echo Рекомендуется перезагрузка.

timeout /t 3 /nobreak >nul 2>&1
exit /b 0