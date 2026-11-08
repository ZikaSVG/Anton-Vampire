@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить сеть

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Настроить сеть
echo.

:: --- Отключить Nagle (TcpAckFrequency, TcpDelAckTicks)
for /f "tokens=*" %%i in ('powershell -NoProfile -Command "(Get-CimInstance -ClassName Win32_NetworkAdapter | Select-Object -ExpandProperty GUID | Where-Object { $_ -like '*{*' })"' ) do (
  Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f >nul 2>&1
  Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f >nul 2>&1
)

:: --- Отключить лишние привязки
powershell -NoProfile -ExecutionPolicy Bypass -Command "Disable-NetAdapterBinding -Name '*' -ComponentID ms_lldp, ms_lltdio, ms_implat, ms_tcpip6, ms_rspndr, ms_server, ms_msclient -EA 0" >nul 2>&1

:: --- Отключить RSC и Packet Coalescing
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing Disabled -EA 0" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-NetOffloadGlobalSetting -PacketCoalescingFilter Disabled -EA 0" >nul 2>&1

:: --- Отключить энергосбережение NIC
for /f %%a in ('Reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s 2^>nul ^| findstr "HKEY"') do (
  Reg.exe add %%a /v "AutoDisableGigabit" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "AutoPowerSaveMode" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "AdvancedEEE" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "AutoPowerSaveModeEnabled" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "*EEE" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "EnableGreenEthernet" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "EnablePME" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "GigaLite" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "*JumboPacket" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "*LsoV2IPv4" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "*LsoV2IPv6" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "PowerSavingMode" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "PowerDownPll" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "*PMARPOffload" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "ULPMode" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "*WakeOnMagicPacket" /t Reg_SZ /d "0" /f >nul 2>&1
  Reg.exe add %%a /v "*WakeOnPattern" /t Reg_SZ /d "0" /f >nul 2>&1
)

echo.
echo [OK] Готово: Настроить сеть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
