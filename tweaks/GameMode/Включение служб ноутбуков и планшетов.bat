@echo off
chcp 65001 >nul
title xOS: Включение служб ноутбуков и планшетов

echo.
echo ================================================================================
echo              xOS PLAYBOOK - ВКЛЮЧЕНИЕ СЛУЖБ НОУТБУКОВ И ПЛАНШЕТОВ
echo ================================================================================
echo.
echo [ ОПИСАНИЕ ]
echo --------------------------------------------------------------------------------
echo Возвращает службы тачпада и драйвер батареи в стандартный режим (Start = 3).
echo Используйте этот скрипт, если:
echo   - вы случайно запустили отключение на ноутбуке/планшете;
echo   - тачпад перестал работать после оптимизации;
echo   - нужно вернуть батарею на ноутбуке.
echo.
echo Включаемые службы (Start = 3 — Manual):
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
echo [ ПЛЮСЫ ]
echo --------------------------------------------------------------------------------
echo   [+] Восстанавливает стандартное поведение системы
echo   [+] Возвращает работу тачпада и батареи
echo   [+] Решает проблемы с питанием после оптимизации
echo.
echo [ РЕКОМЕНДАЦИИ ]
echo --------------------------------------------------------------------------------
echo   [1] Запустите этот скрипт, если вы на ноутбуке/планшете
echo   [2] После включения рекомендуется перезагрузиться
echo.
echo [ ПРИМЕНЕНИЕ ]
echo --------------------------------------------------------------------------------
echo.

echo Включаю службы тачпада и батареи...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SynTPEnh"          /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SynTPEnhService"   /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SynTP"             /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ETDService"        /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ETDCtrl"           /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ETDControl"        /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ApfiltrService"    /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DellTouchpad"      /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TouchPad"          /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TPP"               /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Cmbatt"            /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1

echo.
echo ================================================================================
echo              ГОТОВО! СЛУЖБЫ НОУТБУКОВ И ПЛАНШЕТОВ ВКЛЮЧЕНЫ
echo ================================================================================
echo.
echo Настройки возвращены к стандартным (Start = 3 - Manual).
echo Рекомендуется перезагрузить компьютер.

timeout /t 3 /nobreak >nul 2>&1
exit /b 0