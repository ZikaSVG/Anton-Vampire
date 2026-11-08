@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ОТКЛЮЧЕНИЕ WAKE-ON-LAN (WoL)
echo                       И НАСТРОЙКА WOL SHUTDOWN LINK SPEED
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт объединяет две настройки для управления пробуждением по сети:
echo.
echo ЧАСТЬ 1 - Отключение Wake-on-LAN (WoL):
echo   - Пробуждение по магическому пакету (Magic Packet)
echo   - Пробуждение по шаблону (Pattern)
echo   - Пробуждение при подключении кабеля (WakeOnLink)
echo   - Пробуждение из S5 (полного выключения)
echo   - Современный режим ожидания WoL
echo.
echo ЧАСТЬ 2 - Настройка WolShutdownLinkSpeed:
echo   - Устанавливает скорость линка при выключении для Wake-on-LAN
echo   - Значение 2 - автоматическое определение скорости
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ПРЕДОТВРАЩАЕТ СЛУЧАЙНЫЕ ПРОБУЖДЕНИЯ КОМПЬЮТЕРА
echo [+] Снижает энергопотребление в режиме сна
echo [+] Полезно для ноутбуков (батарея не разряжается в рюкзаке)
echo [+] Оптимальная совместимость с WoL (если он вдруг понадобится)
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Нельзя удаленно включить компьютер по сети
echo [-] Функция Wake-on-LAN перестает работать
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Отключайте если ПК просыпается сам
echo [2] На ноутбуках - ОБЯЗАТЕЛЬНО отключайте
echo [3] Если нужен удаленный доступ - не отключайте
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [ЧАСТЬ 1] Отключение Wake-on-LAN...
echo.

for /f %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr "HKEY"') do (

    for /f %%i in ('reg query "%%a" /v "*WakeOnMagicPacket" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*WakeOnMagicPacket" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*WakeOnPattern" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*WakeOnPattern" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "S5WakeOnLan" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "S5WakeOnLan" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeOnLink" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "WakeOnLink" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeOnSlot" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "WakeOnSlot" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeOnLinkChg" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "WakeOnLinkChg" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeOnLinkUp" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "WakeOnLinkUp" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeUpModeCap" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "WakeUpModeCap" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeOnMagicPacketFromS5" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "WakeOnMagicPacketFromS5" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeFromS5" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "WakeFromS5" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeOn" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "WakeOn" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeFromPowerOff" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "WakeFromPowerOff" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "ForceWakeFromMagicPacketOnModernStandby" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "ForceWakeFromMagicPacketOnModernStandby" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*ModernStandbyWoLMagicPacket" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*ModernStandbyWoLMagicPacket" /t REG_SZ /d "0" /f >nul 2>&1
)

echo [OK] Часть 1 завершена
echo.

echo [ЧАСТЬ 2] Настройка WolShutdownLinkSpeed...
echo.

for /f %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr "HKEY"') do (
    for /f %%i in ('reg query "%%a" /v "WolShutdownLinkSpeed" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "WolShutdownLinkSpeed" /t REG_SZ /d "2" /f >nul 2>&1
)

echo [OK] Часть 2 завершена
echo.

echo ================================================================================
echo               ГОТОВО! WAKE-ON-LAN ОТКЛЮЧЕН, WoL SPEED НАСТРОЕН
echo ================================================================================
echo.
echo Что сделано:
echo   - Отключены все функции пробуждения по сети
echo   - Установлена автоматическая скорость линка для WoL (значение 2)
echo.
echo Компьютер больше не будет просыпаться случайно по сети.
echo Для отката используйте соответствующий скрипт отмены.

echo.