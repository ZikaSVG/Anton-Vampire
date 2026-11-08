@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ВКЛЮЧЕНИЕ WAKE-ON-LAN (WoL)
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Включает обратно функции пробуждения компьютера по сети:
echo   - Пробуждение по магическому пакету (Magic Packet)
echo   - Пробуждение по шаблону (Pattern)
echo   - Пробуждение при подключении кабеля (WakeOnLink)
echo   - Пробуждение из S5 (полного выключения)
echo   - Современный режим ожидания WoL
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] Возвращает возможность удаленного включения компьютера
echo [+] Восстанавливает стандартные настройки Windows
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Могут вернуться случайные пробуждения компьютера
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

for /f %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr "HKEY"') do (

    for /f %%i in ('reg query "%%a" /v "*WakeOnMagicPacket" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*WakeOnMagicPacket" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*WakeOnPattern" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*WakeOnPattern" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "S5WakeOnLan" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "S5WakeOnLan" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeOnLink" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "WakeOnLink" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeOnSlot" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "WakeOnSlot" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeOnLinkChg" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "WakeOnLinkChg" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeOnLinkUp" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "WakeOnLinkUp" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeUpModeCap" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "WakeUpModeCap" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeOnMagicPacketFromS5" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "WakeOnMagicPacketFromS5" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeFromS5" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "WakeFromS5" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeOn" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "WakeOn" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "WakeFromPowerOff" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "WakeFromPowerOff" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "ForceWakeFromMagicPacketOnModernStandby" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "ForceWakeFromMagicPacketOnModernStandby" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*ModernStandbyWoLMagicPacket" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*ModernStandbyWoLMagicPacket" /f >nul 2>&1

    for /f %%i in ('reg query "%%a" /v "WolShutdownLinkSpeed" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "WolShutdownLinkSpeed" /f >nul 2>&1
)

echo.
echo ================================================================================
echo                    ГОТОВО! WAKE-ON-LAN ВКЛЮЧЕН
echo ================================================================================

echo.