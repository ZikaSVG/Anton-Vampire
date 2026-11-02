@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить телеметрию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить телеметрию
echo.

:: --- Службы телеметрии
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop DiagTrack >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop dmwappushservice >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: --- AllowTelemetry = 0
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowTelemetry" /v "value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitDiagnosticLogCollection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitDumpCollection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitEnhancedDiagnosticDataWindowsAnalytics" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d "1" /f >nul 2>&1

:: --- ETW автологгер DiagTrack
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey" /v "EnableEventTranscript" /t REG_DWORD /d "0" /f >nul 2>&1

:: --- Удалить накопленные ETL
del /f /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\DiagTrack*" >nul 2>&1
del /f /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\DiagTrack*" >nul 2>&1

:: --- Переменные окружения
setx POWERSHELL_TELEMETRY_OPTOUT 1 >nul 2>&1
setx DOTNET_CLI_TELEMETRY_OPTOUT 1 >nul 2>&1
setx DOTNET_TRY_CLI_TELEMETRY_OPTOUT 1 >nul 2>&1
setx CLOUDSDK_CORE_DISABLE_PROMPTS 1 >nul 2>&1
setx DOCKER_CLI_TELEMETRY_OPTOUT 1 >nul 2>&1
setx npm_config_loglevel silent >nul 2>&1
setx VS_TELEMETRY_OPT_OUT 1 >nul 2>&1

echo.
echo [OK] Готово: Отключить телеметрию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
