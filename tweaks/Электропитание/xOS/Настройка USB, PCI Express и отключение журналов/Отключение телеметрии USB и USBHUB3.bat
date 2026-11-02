@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ОТКЛЮЧЕНИЕ ТЕЛЕМЕТРИИ USB
echo                         И USBHUB3 (CEIP)
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт отключает сбор телеметрии и диагностических данных
echo для USB-устройств и USB 3.0 контроллера.
echo.
echo Отключаются следующие параметры:
echo.
echo   1. Ceip (Customer Experience Improvement Program) для USBHUB3
echo      - Программа улучшения качества пользовательского опыта
echo      - Собирает данные об использовании USB-устройств
echo      - Отправляет телеметрию в Microsoft
echo.
echo   2. DisableSelectiveSuspendUI
echo      - Отключает интерфейс выборочного отключения USB
echo      - Часть телеметрии питания USB
echo.
echo   3. DisableLPM (Link Power Management)
echo      - Отключает управление питанием USB 3.0
echo      - Может отправлять данные об энергопотреблении
echo.
echo   4. D3ColdSupported
echo      - Отключает диагностику холодного состояния USB
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ОТКЛЮЧАЕТ ОТПРАВКУ ТЕЛЕМЕТРИИ USB В MICROSOFT
echo [+] Снижает фоновую активность USB-контроллера
echo [+] Уменьшает количество сетевых запросов (если есть отправка данных)
echo [+] Повышает конфиденциальность (меньше собираемых данных)
echo [+] Убирает лишнюю диагностику USB-устройств
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Microsoft не получает данные для улучшения USB-стекa
echo [-] Диагностика проблем с USB может быть затруднена
echo [-] Техподдержка может запросить включение телеметрии
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Рекомендуется всем, кто заботится о конфиденциальности
echo [2] Особенно актуально для корпоративных и рабочих ПК
echo [3] Отлично сочетается с другими твиками отключения телеметрии
echo [4] Не влияет на работоспособность USB-устройств
echo [5] Для отката используйте скрипт включения телеметрии
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [1/4] Отключение Ceip (Customer Experience Improvement Program) для USBHUB3...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "Ceip" /t REG_DWORD /d "0" /f
echo [OK] Ceip отключен

echo [2/4] Отключение DisableSelectiveSuspendUI...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "DisableSelectiveSuspendUI" /t REG_DWORD /d "1" /f
echo [OK] DisableSelectiveSuspendUI отключен

echo [3/4] Отключение DisableLPM (Link Power Management)...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "DisableLPM" /t REG_DWORD /d "1" /f
echo [OK] DisableLPM отключен

echo [4/4] Отключение D3ColdSupported...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "D3ColdSupported" /t REG_DWORD /d "0" /f
echo [OK] D3ColdSupported отключен

echo.
echo ================================================================================
echo               ГОТОВО! ТЕЛЕМЕТРИЯ USB И USBHUB3 ОТКЛЮЧЕНА
echo ================================================================================
echo.
echo Что отключено:
echo   - Ceip (Customer Experience Improvement Program) - отправка телеметрии
echo   - DisableSelectiveSuspendUI - интерфейс выборочного отключения
echo   - DisableLPM - управление питанием USB 3.0
echo   - D3ColdSupported - диагностика холодного состояния
echo.
echo Все параметры отключены. USB-устройства работают как обычно,
echo но перестают отправлять диагностические данные в Microsoft.
echo Для возврата телеметрии используйте скрипт "Включение телеметрии USB и USBHUB3.bat"
echo.

echo.