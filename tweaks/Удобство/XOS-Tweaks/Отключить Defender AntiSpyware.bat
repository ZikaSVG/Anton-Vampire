@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Defender AntiSpyware

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Defender AntiSpyware
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v ServiceKeepAlive /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v PreviousRunningMode /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v IsServiceRunning /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v ServiceKeepAlive /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v PreviousRunningMode /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v IsServiceRunning /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v PassiveMode /t REG_DWORD /d 1 /f

:: MpCmdRun -DisableService
pushd "%ProgramFiles%\Windows Defender" 2>nul
if exist "MpCmdRun.exe" start /wait "" MpCmdRun.exe -DisableService -HighPriority >nul 2>&1
popd

:: Wait MsMpEng exit
powershell -NoProfile -Command "$w=14; while ((Get-Process MsMpEng -EA 0) -and $w -gt 0) { Start-Sleep 1; $w-- }" >nul 2>&1

:: Rename MpCmdRun.exe -> OFFmeansOFF.exe
for /f "tokens=2,*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v ImagePath 2^>nul ^| findstr /i "ImagePath"') do set "DEF_PATH=%%b"
set "DEF_PATH=!DEF_PATH:"=!"
for %%d in ("!DEF_PATH!") do set "DEF_DIR=%%~dpd"
if defined DEF_DIR (
  pushd "!DEF_DIR!" 2>nul
  if exist "MpCmdRun.exe" if not exist "OFFmeansOFF.exe" ren "MpCmdRun.exe" "OFFmeansOFF.exe" >nul 2>&1
  popd
)

:: Clear per-user toggle notifications
powershell -NoProfile -Command ^
  "Get-Item 'Registry::HKEY_Users\S-1-5-21*\Software\Microsoft\Windows\CurrentVersion' -EA 0 | ForEach-Object { $n1 = Join-Path $_.PSPath 'Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance'; New-Item $n1 -Force -EA 0 | Out-Null; Remove-Item $n1.Replace('Settings','Current') -Recurse -Force -EA 0; Set-ItemProperty $n1 -Name 'Enabled' -Value 0 -Type DWord -Force -EA 0 }; Remove-Item 'HKLM:\Software\Microsoft\Windows Security Health\State\Persist' -Recurse -Force -EA 0" >nul 2>&1

:: Clear scan history
del /f /q "%ProgramData%\Microsoft\Windows Defender\Scans\mpenginedb.db" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\History\Service" >nul 2>&1

:: Service Start=4
for %%S in (MDCoreSvc WinDefend WdFilter WdBoot WdNisDrv WdNisSvc) do reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
for %%S in (Sense MsSecCore wscsvc MsSecWfp MsSecFlt SgrmBroker wtd webthreatdefusersvc webthreatdefsvc SecurityHealthService) do reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

echo.
echo [OK] Готово: Отключить Defender AntiSpyware
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
