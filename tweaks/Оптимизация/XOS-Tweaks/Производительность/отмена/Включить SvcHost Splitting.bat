@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить SvcHost Splitting

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить SvcHost Splitting
echo.

for %%S in (BFE DcomLaunch mpssvc PlugPlay Power SamSs EventSystem CryptSvc Dhcp Dnscache Appinfo BITS gpsvc IKEEXT iphlpsvc LanmanServer NcbService RasMan SENS ShellHWDetection Winmgmt EventLog LanmanWorkstation NlaSvc nsi ProfSvc Schedule SessionEnv Themes W32Time Wcmsvc) do (
  reg delete "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v SvcHostSplitDisable /f >nul 2>&1
)
reg delete "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /f >nul 2>&1

echo.
echo [OK] Отменено: Включить SvcHost Splitting
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
