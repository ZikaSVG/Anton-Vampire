@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить SvcHost Splitting

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить SvcHost Splitting
echo.

for %%S in (BFE DcomLaunch mpssvc PlugPlay Power SamSs EventSystem CryptSvc Dhcp Dnscache Appinfo BITS gpsvc IKEEXT iphlpsvc LanmanServer NcbService RasMan SENS ShellHWDetection Winmgmt EventLog LanmanWorkstation NlaSvc nsi ProfSvc Schedule SessionEnv Themes W32Time Wcmsvc) do (
  reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v SvcHostSplitDisable /t REG_DWORD /d 1 /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d 3489660927 /f

echo.
echo [OK] Готово: Отключить SvcHost Splitting
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
