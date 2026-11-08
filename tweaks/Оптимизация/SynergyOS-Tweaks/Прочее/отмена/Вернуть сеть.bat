@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить сеть

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Настроить сеть
echo.

:: --- Вернуть Nagle
for /f "tokens=*" %%i in ('powershell -NoProfile -Command "(Get-CimInstance -ClassName Win32_NetworkAdapter | Select-Object -ExpandProperty GUID | Where-Object { $_ -like '*{*' })"' ) do (
  Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TcpAckFrequency" /f >nul 2>&1
  Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TcpDelAckTicks" /f >nul 2>&1
)

:: --- Вернуть привязки
powershell -NoProfile -ExecutionPolicy Bypass -Command "Enable-NetAdapterBinding -Name '*' -ComponentID ms_lldp, ms_lltdio, ms_implat, ms_tcpip6, ms_rspndr, ms_server, ms_msclient -EA 0" >nul 2>&1

:: --- Вернуть RSC и Packet Coalescing
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing Enabled -EA 0" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-NetOffloadGlobalSetting -PacketCoalescingFilter Enabled -EA 0" >nul 2>&1

:: --- Вернуть NIC-ключи
for /f %%a in ('Reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s 2^>nul ^| findstr "HKEY"') do (
  Reg.exe delete %%a /v "AutoDisableGigabit" /f >nul 2>&1
  Reg.exe delete %%a /v "AutoPowerSaveMode" /f >nul 2>&1
  Reg.exe delete %%a /v "AdvancedEEE" /f >nul 2>&1
  Reg.exe delete %%a /v "AutoPowerSaveModeEnabled" /f >nul 2>&1
  Reg.exe delete %%a /v "*EEE" /f >nul 2>&1
  Reg.exe delete %%a /v "EnableGreenEthernet" /f >nul 2>&1
  Reg.exe delete %%a /v "EnablePME" /f >nul 2>&1
  Reg.exe delete %%a /v "GigaLite" /f >nul 2>&1
  Reg.exe delete %%a /v "*JumboPacket" /f >nul 2>&1
  Reg.exe delete %%a /v "*LsoV2IPv4" /f >nul 2>&1
  Reg.exe delete %%a /v "*LsoV2IPv6" /f >nul 2>&1
  Reg.exe delete %%a /v "PowerSavingMode" /f >nul 2>&1
  Reg.exe delete %%a /v "PowerDownPll" /f >nul 2>&1
  Reg.exe delete %%a /v "*PMARPOffload" /f >nul 2>&1
  Reg.exe delete %%a /v "ULPMode" /f >nul 2>&1
  Reg.exe delete %%a /v "*WakeOnMagicPacket" /f >nul 2>&1
  Reg.exe delete %%a /v "*WakeOnPattern" /f >nul 2>&1
)

echo.
echo [OK] Отменено: Вернуть сеть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
