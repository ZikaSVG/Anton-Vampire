@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Включить Defender AntiSpyware

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Включить Defender AntiSpyware
echo.

:: Rename OFFmeansOFF.exe -> MpCmdRun.exe
for /f "tokens=2,*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v ImagePath 2^>nul ^| findstr /i "ImagePath"') do set "DEF_PATH=%%b"
set "DEF_PATH=!DEF_PATH:"=!"
for %%d in ("!DEF_PATH!") do set "DEF_DIR=%%~dpd"
if defined DEF_DIR (
  pushd "!DEF_DIR!" 2>nul
  if exist "OFFmeansOFF.exe" if not exist "MpCmdRun.exe" ren "OFFmeansOFF.exe" "MpCmdRun.exe" >nul 2>&1
  popd
)

:: Rename smartscreen.old -> smartscreen.exe
if exist "%SystemRoot%\System32\smartscreen.old" ren "%SystemRoot%\System32\smartscreen.old" "smartscreen.exe" >nul 2>&1

:: Remove PassiveMode и политики
for %%K in (
  "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender"
  "HKLM\SOFTWARE\Microsoft\Windows Defender"
) do (
  reg delete "%%~K" /v PassiveMode /f >nul 2>&1
  reg delete "%%~K" /v ServiceKeepAlive /f >nul 2>&1
  reg delete "%%~K" /v PreviousRunningMode /f >nul 2>&1
  reg delete "%%~K" /v IsServiceRunning /f >nul 2>&1
  reg delete "%%~K" /v DisableAntiSpyware /f >nul 2>&1
  reg delete "%%~K" /v DisableAntiVirus /f >nul 2>&1
)

:: TamperProtection = 1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtectionSource /t REG_DWORD /d 5 /f

:: Запустить службы
sc start WinDefend >nul 2>&1
sc start wscsvc >nul 2>&1

:: WER вернуть
reg delete "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Удалить задачу XOS-DefenderDisable
schtasks /delete /tn XOS-DefenderDisable /f >nul 2>&1
del /f /q "C:\Windows\XOS-DD.ps1" >nul 2>&1

echo.
echo [OK] Отменено: Включить Defender AntiSpyware
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
