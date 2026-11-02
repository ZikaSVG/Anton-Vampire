@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить телеметрию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить телеметрию
echo.

:: --- Вернуть службы
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
sc start DiagTrack >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v Start /t REG_DWORD /d 3 /f >nul 2>&1

:: --- AllowTelemetry = 3
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "3" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowTelemetry" /v "value" /t REG_DWORD /d "3" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitDiagnosticLogCollection" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitDumpCollection" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitEnhancedDiagnosticDataWindowsAnalytics" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /f >nul 2>&1

:: --- ETW вернуть
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Diagtrack-Listener" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey" /v "EnableEventTranscript" /f >nul 2>&1

:: --- Вернуть переменные
setx POWERSHELL_TELEMETRY_OPTOUT "" >nul 2>&1
setx DOTNET_CLI_TELEMETRY_OPTOUT "" >nul 2>&1
setx DOTNET_TRY_CLI_TELEMETRY_OPTOUT "" >nul 2>&1
setx CLOUDSDK_CORE_DISABLE_PROMPTS "" >nul 2>&1
setx DOCKER_CLI_TELEMETRY_OPTOUT "" >nul 2>&1
setx npm_config_loglevel "" >nul 2>&1
setx VS_TELEMETRY_OPT_OUT "" >nul 2>&1

echo.
echo [OK] Отменено: Включить телеметрию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
