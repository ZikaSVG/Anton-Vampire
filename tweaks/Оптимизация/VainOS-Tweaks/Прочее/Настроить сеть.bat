@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить сеть

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить сеть
echo.

:: --- Меню
echo  [1] Default network settings
echo  [2] Vain network settings
set /p "CH=Выбор [1/2]: "
if "%CH%"=="1" goto :default
if "%CH%"=="2" goto :vain
echo [!] Неверный выбор.
pause & exit /b 1

:default
netsh int ip reset >nul 2>&1
netsh interface ipv4 reset >nul 2>&1
netsh interface ipv6 reset >nul 2>&1
netsh interface tcp reset >nul 2>&1
netsh winsock reset >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "foreach ($dev in Get-PnpDevice -Class Net -Status 'OK') { pnputil /remove-device $dev.InstanceId }" >nul 2>&1
pnputil /scan-devices >nul 2>&1
for /f %%n in ('wmic path win32_networkadapter get GUID 2^>nul ^| findstr "{"') do (
  reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%n" /v "TcpAckFrequency" /f >nul 2>&1
  reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%n" /v "TcpDelAckTicks" /f >nul 2>&1
  reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%n" /v "TCPNoDelay" /f >nul 2>&1
)
for /f "delims=" %%u in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces" /s /f "NetbiosOptions" 2^>nul ^| findstr "HKEY"') do (
  reg add "%%u" /v "NetbiosOptions" /t REG_DWORD /d 0 /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "EnableLMHOSTS" /t REG_DWORD /d 1 /f >nul 2>&1
echo Default network settings restored.
pause & exit /b 0

:vain
netsh int ip reset >nul 2>&1
netsh interface ipv4 reset >nul 2>&1
netsh interface ipv6 reset >nul 2>&1
netsh interface tcp reset >nul 2>&1
netsh winsock reset >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "foreach ($dev in Get-PnpDevice -Class Net -Status 'OK') { pnputil /remove-device $dev.InstanceId }" >nul 2>&1
pnputil /scan-devices >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Disable-NetAdapterBinding -Name '*' -ComponentID vmware_bridge, ms_lldp, ms_lltdio, ms_implat, ms_rspndr, ms_server, ms_msclient -EA 0" >nul 2>&1
netsh int tcp set security profiles=disabled >nul 2>&1
netsh int udp set global uro=disabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
echo Vain settings configured.
pause & exit /b 0

echo.
echo [OK] Готово: Настроить сеть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
