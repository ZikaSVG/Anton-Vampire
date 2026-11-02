@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить службы

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Настроить службы
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\AxInstSV" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdates" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BluetoothUserService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BcastDVRUserService_389fd" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NaturalAuthentication" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lltdsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetTcpPortSharing" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CscService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\QWAVE" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ShellHWDetection" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ScDeviceEnum" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SSDPSRV" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WiaRpc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\upnphost" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UevAgentService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Fax" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServer" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServerMonitor" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stisvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpnService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpnUserService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\icssvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

echo.
echo [OK] Готово: Настроить службы
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
