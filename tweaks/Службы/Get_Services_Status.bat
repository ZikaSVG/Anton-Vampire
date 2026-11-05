@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Определение статусов служб
net session >nul 2>&1 || (
    echo [!] Запустите от имени администратора.
    pause & exit /b 1
)

echo { > "%~dp0services_status.json"

REM Проверка службы DiagTrack
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_DiagTrack=boot"
    if "!START_VAL!"=="0x1" set "STATUS_DiagTrack=system"
    if "!START_VAL!"=="0x2" set "STATUS_DiagTrack=auto"
    if "!START_VAL!"=="0x3" set "STATUS_DiagTrack=manual"
    if "!START_VAL!"=="0x4" set "STATUS_DiagTrack=disabled"
    if not defined STATUS_DiagTrack set "STATUS_DiagTrack=unknown"
) else (
    set "STATUS_DiagTrack=notfound"
)
echo   "DiagTrack": "!STATUS_DiagTrack!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_DiagTrack="

REM Проверка службы dmwappushservice
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_dmwappushservice=boot"
    if "!START_VAL!"=="0x1" set "STATUS_dmwappushservice=system"
    if "!START_VAL!"=="0x2" set "STATUS_dmwappushservice=auto"
    if "!START_VAL!"=="0x3" set "STATUS_dmwappushservice=manual"
    if "!START_VAL!"=="0x4" set "STATUS_dmwappushservice=disabled"
    if not defined STATUS_dmwappushservice set "STATUS_dmwappushservice=unknown"
) else (
    set "STATUS_dmwappushservice=notfound"
)
echo   "dmwappushservice": "!STATUS_dmwappushservice!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_dmwappushservice="

REM Проверка службы diagnosticshub.standardcollector.service
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_diagnosticshub.standardcollector.service=boot"
    if "!START_VAL!"=="0x1" set "STATUS_diagnosticshub.standardcollector.service=system"
    if "!START_VAL!"=="0x2" set "STATUS_diagnosticshub.standardcollector.service=auto"
    if "!START_VAL!"=="0x3" set "STATUS_diagnosticshub.standardcollector.service=manual"
    if "!START_VAL!"=="0x4" set "STATUS_diagnosticshub.standardcollector.service=disabled"
    if not defined STATUS_diagnosticshub.standardcollector.service set "STATUS_diagnosticshub.standardcollector.service=unknown"
) else (
    set "STATUS_diagnosticshub.standardcollector.service=notfound"
)
echo   "diagnosticshub.standardcollector.service": "!STATUS_diagnosticshub.standardcollector.service!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_diagnosticshub.standardcollector.service="

REM Проверка службы NvTelemetryContainer
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NvTelemetryContainer" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_NvTelemetryContainer=boot"
    if "!START_VAL!"=="0x1" set "STATUS_NvTelemetryContainer=system"
    if "!START_VAL!"=="0x2" set "STATUS_NvTelemetryContainer=auto"
    if "!START_VAL!"=="0x3" set "STATUS_NvTelemetryContainer=manual"
    if "!START_VAL!"=="0x4" set "STATUS_NvTelemetryContainer=disabled"
    if not defined STATUS_NvTelemetryContainer set "STATUS_NvTelemetryContainer=unknown"
) else (
    set "STATUS_NvTelemetryContainer=notfound"
)
echo   "NvTelemetryContainer": "!STATUS_NvTelemetryContainer!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_NvTelemetryContainer="

REM Проверка службы Telemetry
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Telemetry" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_Telemetry=boot"
    if "!START_VAL!"=="0x1" set "STATUS_Telemetry=system"
    if "!START_VAL!"=="0x2" set "STATUS_Telemetry=auto"
    if "!START_VAL!"=="0x3" set "STATUS_Telemetry=manual"
    if "!START_VAL!"=="0x4" set "STATUS_Telemetry=disabled"
    if not defined STATUS_Telemetry set "STATUS_Telemetry=unknown"
) else (
    set "STATUS_Telemetry=notfound"
)
echo   "Telemetry": "!STATUS_Telemetry!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_Telemetry="

REM Проверка службы WdiServiceHost
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WdiServiceHost=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WdiServiceHost=system"
    if "!START_VAL!"=="0x2" set "STATUS_WdiServiceHost=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WdiServiceHost=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WdiServiceHost=disabled"
    if not defined STATUS_WdiServiceHost set "STATUS_WdiServiceHost=unknown"
) else (
    set "STATUS_WdiServiceHost=notfound"
)
echo   "WdiServiceHost": "!STATUS_WdiServiceHost!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WdiServiceHost="

REM Проверка службы WdiSystemHost
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WdiSystemHost=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WdiSystemHost=system"
    if "!START_VAL!"=="0x2" set "STATUS_WdiSystemHost=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WdiSystemHost=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WdiSystemHost=disabled"
    if not defined STATUS_WdiSystemHost set "STATUS_WdiSystemHost=unknown"
) else (
    set "STATUS_WdiSystemHost=notfound"
)
echo   "WdiSystemHost": "!STATUS_WdiSystemHost!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WdiSystemHost="

REM Проверка службы WerSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WerSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WerSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_WerSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WerSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WerSvc=disabled"
    if not defined STATUS_WerSvc set "STATUS_WerSvc=unknown"
) else (
    set "STATUS_WerSvc=notfound"
)
echo   "WerSvc": "!STATUS_WerSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WerSvc="

REM Проверка службы wercplsupport
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\wercplsupport" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_wercplsupport=boot"
    if "!START_VAL!"=="0x1" set "STATUS_wercplsupport=system"
    if "!START_VAL!"=="0x2" set "STATUS_wercplsupport=auto"
    if "!START_VAL!"=="0x3" set "STATUS_wercplsupport=manual"
    if "!START_VAL!"=="0x4" set "STATUS_wercplsupport=disabled"
    if not defined STATUS_wercplsupport set "STATUS_wercplsupport=unknown"
) else (
    set "STATUS_wercplsupport=notfound"
)
echo   "wercplsupport": "!STATUS_wercplsupport!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_wercplsupport="

REM Проверка службы Wecsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_Wecsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_Wecsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_Wecsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_Wecsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_Wecsvc=disabled"
    if not defined STATUS_Wecsvc set "STATUS_Wecsvc=unknown"
) else (
    set "STATUS_Wecsvc=notfound"
)
echo   "Wecsvc": "!STATUS_Wecsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_Wecsvc="

REM Проверка службы TroubleshootingSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\TroubleshootingSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_TroubleshootingSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_TroubleshootingSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_TroubleshootingSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_TroubleshootingSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_TroubleshootingSvc=disabled"
    if not defined STATUS_TroubleshootingSvc set "STATUS_TroubleshootingSvc=unknown"
) else (
    set "STATUS_TroubleshootingSvc=notfound"
)
echo   "TroubleshootingSvc": "!STATUS_TroubleshootingSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_TroubleshootingSvc="

REM Проверка службы PcaSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_PcaSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_PcaSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_PcaSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_PcaSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_PcaSvc=disabled"
    if not defined STATUS_PcaSvc set "STATUS_PcaSvc=unknown"
) else (
    set "STATUS_PcaSvc=notfound"
)
echo   "PcaSvc": "!STATUS_PcaSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_PcaSvc="

REM Проверка службы pla
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\pla" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_pla=boot"
    if "!START_VAL!"=="0x1" set "STATUS_pla=system"
    if "!START_VAL!"=="0x2" set "STATUS_pla=auto"
    if "!START_VAL!"=="0x3" set "STATUS_pla=manual"
    if "!START_VAL!"=="0x4" set "STATUS_pla=disabled"
    if not defined STATUS_pla set "STATUS_pla=unknown"
) else (
    set "STATUS_pla=notfound"
)
echo   "pla": "!STATUS_pla!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_pla="

REM Проверка службы DPS
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_DPS=boot"
    if "!START_VAL!"=="0x1" set "STATUS_DPS=system"
    if "!START_VAL!"=="0x2" set "STATUS_DPS=auto"
    if "!START_VAL!"=="0x3" set "STATUS_DPS=manual"
    if "!START_VAL!"=="0x4" set "STATUS_DPS=disabled"
    if not defined STATUS_DPS set "STATUS_DPS=unknown"
) else (
    set "STATUS_DPS=notfound"
)
echo   "DPS": "!STATUS_DPS!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_DPS="

REM Проверка службы WSearch
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WSearch" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WSearch=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WSearch=system"
    if "!START_VAL!"=="0x2" set "STATUS_WSearch=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WSearch=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WSearch=disabled"
    if not defined STATUS_WSearch set "STATUS_WSearch=unknown"
) else (
    set "STATUS_WSearch=notfound"
)
echo   "WSearch": "!STATUS_WSearch!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WSearch="

REM Проверка службы SysMain
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SysMain=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SysMain=system"
    if "!START_VAL!"=="0x2" set "STATUS_SysMain=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SysMain=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SysMain=disabled"
    if not defined STATUS_SysMain set "STATUS_SysMain=unknown"
) else (
    set "STATUS_SysMain=notfound"
)
echo   "SysMain": "!STATUS_SysMain!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SysMain="

REM Проверка службы WpnService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WpnService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WpnService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WpnService=system"
    if "!START_VAL!"=="0x2" set "STATUS_WpnService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WpnService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WpnService=disabled"
    if not defined STATUS_WpnService set "STATUS_WpnService=unknown"
) else (
    set "STATUS_WpnService=notfound"
)
echo   "WpnService": "!STATUS_WpnService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WpnService="

REM Проверка службы WpnUserService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WpnUserService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WpnUserService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WpnUserService=system"
    if "!START_VAL!"=="0x2" set "STATUS_WpnUserService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WpnUserService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WpnUserService=disabled"
    if not defined STATUS_WpnUserService set "STATUS_WpnUserService=unknown"
) else (
    set "STATUS_WpnUserService=notfound"
)
echo   "WpnUserService": "!STATUS_WpnUserService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WpnUserService="

REM Проверка службы XblAuthManager
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_XblAuthManager=boot"
    if "!START_VAL!"=="0x1" set "STATUS_XblAuthManager=system"
    if "!START_VAL!"=="0x2" set "STATUS_XblAuthManager=auto"
    if "!START_VAL!"=="0x3" set "STATUS_XblAuthManager=manual"
    if "!START_VAL!"=="0x4" set "STATUS_XblAuthManager=disabled"
    if not defined STATUS_XblAuthManager set "STATUS_XblAuthManager=unknown"
) else (
    set "STATUS_XblAuthManager=notfound"
)
echo   "XblAuthManager": "!STATUS_XblAuthManager!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_XblAuthManager="

REM Проверка службы XblGameSave
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_XblGameSave=boot"
    if "!START_VAL!"=="0x1" set "STATUS_XblGameSave=system"
    if "!START_VAL!"=="0x2" set "STATUS_XblGameSave=auto"
    if "!START_VAL!"=="0x3" set "STATUS_XblGameSave=manual"
    if "!START_VAL!"=="0x4" set "STATUS_XblGameSave=disabled"
    if not defined STATUS_XblGameSave set "STATUS_XblGameSave=unknown"
) else (
    set "STATUS_XblGameSave=notfound"
)
echo   "XblGameSave": "!STATUS_XblGameSave!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_XblGameSave="

REM Проверка службы XboxNetApiSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_XboxNetApiSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_XboxNetApiSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_XboxNetApiSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_XboxNetApiSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_XboxNetApiSvc=disabled"
    if not defined STATUS_XboxNetApiSvc set "STATUS_XboxNetApiSvc=unknown"
) else (
    set "STATUS_XboxNetApiSvc=notfound"
)
echo   "XboxNetApiSvc": "!STATUS_XboxNetApiSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_XboxNetApiSvc="

REM Проверка службы XboxGipSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_XboxGipSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_XboxGipSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_XboxGipSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_XboxGipSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_XboxGipSvc=disabled"
    if not defined STATUS_XboxGipSvc set "STATUS_XboxGipSvc=unknown"
) else (
    set "STATUS_XboxGipSvc=notfound"
)
echo   "XboxGipSvc": "!STATUS_XboxGipSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_XboxGipSvc="

REM Проверка службы Spooler
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_Spooler=boot"
    if "!START_VAL!"=="0x1" set "STATUS_Spooler=system"
    if "!START_VAL!"=="0x2" set "STATUS_Spooler=auto"
    if "!START_VAL!"=="0x3" set "STATUS_Spooler=manual"
    if "!START_VAL!"=="0x4" set "STATUS_Spooler=disabled"
    if not defined STATUS_Spooler set "STATUS_Spooler=unknown"
) else (
    set "STATUS_Spooler=notfound"
)
echo   "Spooler": "!STATUS_Spooler!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_Spooler="

REM Проверка службы PrintNotify
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_PrintNotify=boot"
    if "!START_VAL!"=="0x1" set "STATUS_PrintNotify=system"
    if "!START_VAL!"=="0x2" set "STATUS_PrintNotify=auto"
    if "!START_VAL!"=="0x3" set "STATUS_PrintNotify=manual"
    if "!START_VAL!"=="0x4" set "STATUS_PrintNotify=disabled"
    if not defined STATUS_PrintNotify set "STATUS_PrintNotify=unknown"
) else (
    set "STATUS_PrintNotify=notfound"
)
echo   "PrintNotify": "!STATUS_PrintNotify!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_PrintNotify="

REM Проверка службы PrintWorkflowUserSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_PrintWorkflowUserSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_PrintWorkflowUserSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_PrintWorkflowUserSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_PrintWorkflowUserSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_PrintWorkflowUserSvc=disabled"
    if not defined STATUS_PrintWorkflowUserSvc set "STATUS_PrintWorkflowUserSvc=unknown"
) else (
    set "STATUS_PrintWorkflowUserSvc=notfound"
)
echo   "PrintWorkflowUserSvc": "!STATUS_PrintWorkflowUserSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_PrintWorkflowUserSvc="

REM Проверка службы stisvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\stisvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_stisvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_stisvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_stisvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_stisvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_stisvc=disabled"
    if not defined STATUS_stisvc set "STATUS_stisvc=unknown"
) else (
    set "STATUS_stisvc=notfound"
)
echo   "stisvc": "!STATUS_stisvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_stisvc="

REM Проверка службы WiaRpc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WiaRpc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WiaRpc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WiaRpc=system"
    if "!START_VAL!"=="0x2" set "STATUS_WiaRpc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WiaRpc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WiaRpc=disabled"
    if not defined STATUS_WiaRpc set "STATUS_WiaRpc=unknown"
) else (
    set "STATUS_WiaRpc=notfound"
)
echo   "WiaRpc": "!STATUS_WiaRpc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WiaRpc="

REM Проверка службы MapsBroker
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_MapsBroker=boot"
    if "!START_VAL!"=="0x1" set "STATUS_MapsBroker=system"
    if "!START_VAL!"=="0x2" set "STATUS_MapsBroker=auto"
    if "!START_VAL!"=="0x3" set "STATUS_MapsBroker=manual"
    if "!START_VAL!"=="0x4" set "STATUS_MapsBroker=disabled"
    if not defined STATUS_MapsBroker set "STATUS_MapsBroker=unknown"
) else (
    set "STATUS_MapsBroker=notfound"
)
echo   "MapsBroker": "!STATUS_MapsBroker!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_MapsBroker="

REM Проверка службы lfsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_lfsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_lfsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_lfsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_lfsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_lfsvc=disabled"
    if not defined STATUS_lfsvc set "STATUS_lfsvc=unknown"
) else (
    set "STATUS_lfsvc=notfound"
)
echo   "lfsvc": "!STATUS_lfsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_lfsvc="

REM Проверка службы SensorService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SensorService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SensorService=system"
    if "!START_VAL!"=="0x2" set "STATUS_SensorService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SensorService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SensorService=disabled"
    if not defined STATUS_SensorService set "STATUS_SensorService=unknown"
) else (
    set "STATUS_SensorService=notfound"
)
echo   "SensorService": "!STATUS_SensorService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SensorService="

REM Проверка службы SensrSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SensrSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SensrSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_SensrSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SensrSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SensrSvc=disabled"
    if not defined STATUS_SensrSvc set "STATUS_SensrSvc=unknown"
) else (
    set "STATUS_SensrSvc=notfound"
)
echo   "SensrSvc": "!STATUS_SensrSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SensrSvc="

REM Проверка службы SensorDataService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SensorDataService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SensorDataService=system"
    if "!START_VAL!"=="0x2" set "STATUS_SensorDataService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SensorDataService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SensorDataService=disabled"
    if not defined STATUS_SensorDataService set "STATUS_SensorDataService=unknown"
) else (
    set "STATUS_SensorDataService=notfound"
)
echo   "SensorDataService": "!STATUS_SensorDataService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SensorDataService="

REM Проверка службы RemoteRegistry
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_RemoteRegistry=boot"
    if "!START_VAL!"=="0x1" set "STATUS_RemoteRegistry=system"
    if "!START_VAL!"=="0x2" set "STATUS_RemoteRegistry=auto"
    if "!START_VAL!"=="0x3" set "STATUS_RemoteRegistry=manual"
    if "!START_VAL!"=="0x4" set "STATUS_RemoteRegistry=disabled"
    if not defined STATUS_RemoteRegistry set "STATUS_RemoteRegistry=unknown"
) else (
    set "STATUS_RemoteRegistry=notfound"
)
echo   "RemoteRegistry": "!STATUS_RemoteRegistry!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_RemoteRegistry="

REM Проверка службы RemoteAccess
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_RemoteAccess=boot"
    if "!START_VAL!"=="0x1" set "STATUS_RemoteAccess=system"
    if "!START_VAL!"=="0x2" set "STATUS_RemoteAccess=auto"
    if "!START_VAL!"=="0x3" set "STATUS_RemoteAccess=manual"
    if "!START_VAL!"=="0x4" set "STATUS_RemoteAccess=disabled"
    if not defined STATUS_RemoteAccess set "STATUS_RemoteAccess=unknown"
) else (
    set "STATUS_RemoteAccess=notfound"
)
echo   "RemoteAccess": "!STATUS_RemoteAccess!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_RemoteAccess="

REM Проверка службы NetTcpPortSharing
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NetTcpPortSharing" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_NetTcpPortSharing=boot"
    if "!START_VAL!"=="0x1" set "STATUS_NetTcpPortSharing=system"
    if "!START_VAL!"=="0x2" set "STATUS_NetTcpPortSharing=auto"
    if "!START_VAL!"=="0x3" set "STATUS_NetTcpPortSharing=manual"
    if "!START_VAL!"=="0x4" set "STATUS_NetTcpPortSharing=disabled"
    if not defined STATUS_NetTcpPortSharing set "STATUS_NetTcpPortSharing=unknown"
) else (
    set "STATUS_NetTcpPortSharing=notfound"
)
echo   "NetTcpPortSharing": "!STATUS_NetTcpPortSharing!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_NetTcpPortSharing="

REM Проверка службы SSDPSRV
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SSDPSRV" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SSDPSRV=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SSDPSRV=system"
    if "!START_VAL!"=="0x2" set "STATUS_SSDPSRV=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SSDPSRV=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SSDPSRV=disabled"
    if not defined STATUS_SSDPSRV set "STATUS_SSDPSRV=unknown"
) else (
    set "STATUS_SSDPSRV=notfound"
)
echo   "SSDPSRV": "!STATUS_SSDPSRV!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SSDPSRV="

REM Проверка службы upnphost
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\upnphost" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_upnphost=boot"
    if "!START_VAL!"=="0x1" set "STATUS_upnphost=system"
    if "!START_VAL!"=="0x2" set "STATUS_upnphost=auto"
    if "!START_VAL!"=="0x3" set "STATUS_upnphost=manual"
    if "!START_VAL!"=="0x4" set "STATUS_upnphost=disabled"
    if not defined STATUS_upnphost set "STATUS_upnphost=unknown"
) else (
    set "STATUS_upnphost=notfound"
)
echo   "upnphost": "!STATUS_upnphost!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_upnphost="

REM Проверка службы lltdsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\lltdsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_lltdsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_lltdsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_lltdsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_lltdsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_lltdsvc=disabled"
    if not defined STATUS_lltdsvc set "STATUS_lltdsvc=unknown"
) else (
    set "STATUS_lltdsvc=notfound"
)
echo   "lltdsvc": "!STATUS_lltdsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_lltdsvc="

REM Проверка службы lmhosts
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\lmhosts" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_lmhosts=boot"
    if "!START_VAL!"=="0x1" set "STATUS_lmhosts=system"
    if "!START_VAL!"=="0x2" set "STATUS_lmhosts=auto"
    if "!START_VAL!"=="0x3" set "STATUS_lmhosts=manual"
    if "!START_VAL!"=="0x4" set "STATUS_lmhosts=disabled"
    if not defined STATUS_lmhosts set "STATUS_lmhosts=unknown"
) else (
    set "STATUS_lmhosts=notfound"
)
echo   "lmhosts": "!STATUS_lmhosts!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_lmhosts="

REM Проверка службы WebClient
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WebClient" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WebClient=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WebClient=system"
    if "!START_VAL!"=="0x2" set "STATUS_WebClient=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WebClient=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WebClient=disabled"
    if not defined STATUS_WebClient set "STATUS_WebClient=unknown"
) else (
    set "STATUS_WebClient=notfound"
)
echo   "WebClient": "!STATUS_WebClient!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WebClient="

REM Проверка службы WinRM
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WinRM" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WinRM=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WinRM=system"
    if "!START_VAL!"=="0x2" set "STATUS_WinRM=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WinRM=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WinRM=disabled"
    if not defined STATUS_WinRM set "STATUS_WinRM=unknown"
) else (
    set "STATUS_WinRM=notfound"
)
echo   "WinRM": "!STATUS_WinRM!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WinRM="

REM Проверка службы NetBT
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NetBT" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_NetBT=boot"
    if "!START_VAL!"=="0x1" set "STATUS_NetBT=system"
    if "!START_VAL!"=="0x2" set "STATUS_NetBT=auto"
    if "!START_VAL!"=="0x3" set "STATUS_NetBT=manual"
    if "!START_VAL!"=="0x4" set "STATUS_NetBT=disabled"
    if not defined STATUS_NetBT set "STATUS_NetBT=unknown"
) else (
    set "STATUS_NetBT=notfound"
)
echo   "NetBT": "!STATUS_NetBT!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_NetBT="

REM Проверка службы icssvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\icssvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_icssvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_icssvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_icssvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_icssvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_icssvc=disabled"
    if not defined STATUS_icssvc set "STATUS_icssvc=unknown"
) else (
    set "STATUS_icssvc=notfound"
)
echo   "icssvc": "!STATUS_icssvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_icssvc="

REM Проверка службы iphlpsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_iphlpsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_iphlpsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_iphlpsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_iphlpsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_iphlpsvc=disabled"
    if not defined STATUS_iphlpsvc set "STATUS_iphlpsvc=unknown"
) else (
    set "STATUS_iphlpsvc=notfound"
)
echo   "iphlpsvc": "!STATUS_iphlpsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_iphlpsvc="

REM Проверка службы IpxlatCfgSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\IpxlatCfgSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_IpxlatCfgSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_IpxlatCfgSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_IpxlatCfgSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_IpxlatCfgSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_IpxlatCfgSvc=disabled"
    if not defined STATUS_IpxlatCfgSvc set "STATUS_IpxlatCfgSvc=unknown"
) else (
    set "STATUS_IpxlatCfgSvc=notfound"
)
echo   "IpxlatCfgSvc": "!STATUS_IpxlatCfgSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_IpxlatCfgSvc="

REM Проверка службы NcaSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NcaSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_NcaSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_NcaSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_NcaSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_NcaSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_NcaSvc=disabled"
    if not defined STATUS_NcaSvc set "STATUS_NcaSvc=unknown"
) else (
    set "STATUS_NcaSvc=notfound"
)
echo   "NcaSvc": "!STATUS_NcaSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_NcaSvc="

REM Проверка службы NcbService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NcbService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_NcbService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_NcbService=system"
    if "!START_VAL!"=="0x2" set "STATUS_NcbService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_NcbService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_NcbService=disabled"
    if not defined STATUS_NcbService set "STATUS_NcbService=unknown"
) else (
    set "STATUS_NcbService=notfound"
)
echo   "NcbService": "!STATUS_NcbService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_NcbService="

REM Проверка службы NcdAutoSetup
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NcdAutoSetup" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_NcdAutoSetup=boot"
    if "!START_VAL!"=="0x1" set "STATUS_NcdAutoSetup=system"
    if "!START_VAL!"=="0x2" set "STATUS_NcdAutoSetup=auto"
    if "!START_VAL!"=="0x3" set "STATUS_NcdAutoSetup=manual"
    if "!START_VAL!"=="0x4" set "STATUS_NcdAutoSetup=disabled"
    if not defined STATUS_NcdAutoSetup set "STATUS_NcdAutoSetup=unknown"
) else (
    set "STATUS_NcdAutoSetup=notfound"
)
echo   "NcdAutoSetup": "!STATUS_NcdAutoSetup!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_NcdAutoSetup="

REM Проверка службы Netlogon
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_Netlogon=boot"
    if "!START_VAL!"=="0x1" set "STATUS_Netlogon=system"
    if "!START_VAL!"=="0x2" set "STATUS_Netlogon=auto"
    if "!START_VAL!"=="0x3" set "STATUS_Netlogon=manual"
    if "!START_VAL!"=="0x4" set "STATUS_Netlogon=disabled"
    if not defined STATUS_Netlogon set "STATUS_Netlogon=unknown"
) else (
    set "STATUS_Netlogon=notfound"
)
echo   "Netlogon": "!STATUS_Netlogon!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_Netlogon="

REM Проверка службы p2pimsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\p2pimsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_p2pimsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_p2pimsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_p2pimsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_p2pimsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_p2pimsvc=disabled"
    if not defined STATUS_p2pimsvc set "STATUS_p2pimsvc=unknown"
) else (
    set "STATUS_p2pimsvc=notfound"
)
echo   "p2pimsvc": "!STATUS_p2pimsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_p2pimsvc="

REM Проверка службы p2psvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\p2psvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_p2psvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_p2psvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_p2psvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_p2psvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_p2psvc=disabled"
    if not defined STATUS_p2psvc set "STATUS_p2psvc=unknown"
) else (
    set "STATUS_p2psvc=notfound"
)
echo   "p2psvc": "!STATUS_p2psvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_p2psvc="

REM Проверка службы PNRPAutoReg
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\PNRPAutoReg" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_PNRPAutoReg=boot"
    if "!START_VAL!"=="0x1" set "STATUS_PNRPAutoReg=system"
    if "!START_VAL!"=="0x2" set "STATUS_PNRPAutoReg=auto"
    if "!START_VAL!"=="0x3" set "STATUS_PNRPAutoReg=manual"
    if "!START_VAL!"=="0x4" set "STATUS_PNRPAutoReg=disabled"
    if not defined STATUS_PNRPAutoReg set "STATUS_PNRPAutoReg=unknown"
) else (
    set "STATUS_PNRPAutoReg=notfound"
)
echo   "PNRPAutoReg": "!STATUS_PNRPAutoReg!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_PNRPAutoReg="

REM Проверка службы PNRPsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\PNRPsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_PNRPsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_PNRPsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_PNRPsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_PNRPsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_PNRPsvc=disabled"
    if not defined STATUS_PNRPsvc set "STATUS_PNRPsvc=unknown"
) else (
    set "STATUS_PNRPsvc=notfound"
)
echo   "PNRPsvc": "!STATUS_PNRPsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_PNRPsvc="

REM Проверка службы PolicyAgent
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_PolicyAgent=boot"
    if "!START_VAL!"=="0x1" set "STATUS_PolicyAgent=system"
    if "!START_VAL!"=="0x2" set "STATUS_PolicyAgent=auto"
    if "!START_VAL!"=="0x3" set "STATUS_PolicyAgent=manual"
    if "!START_VAL!"=="0x4" set "STATUS_PolicyAgent=disabled"
    if not defined STATUS_PolicyAgent set "STATUS_PolicyAgent=unknown"
) else (
    set "STATUS_PolicyAgent=notfound"
)
echo   "PolicyAgent": "!STATUS_PolicyAgent!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_PolicyAgent="

REM Проверка службы SstpSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SstpSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SstpSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SstpSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_SstpSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SstpSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SstpSvc=disabled"
    if not defined STATUS_SstpSvc set "STATUS_SstpSvc=unknown"
) else (
    set "STATUS_SstpSvc=notfound"
)
echo   "SstpSvc": "!STATUS_SstpSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SstpSvc="

REM Проверка службы RasAuto
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\RasAuto" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_RasAuto=boot"
    if "!START_VAL!"=="0x1" set "STATUS_RasAuto=system"
    if "!START_VAL!"=="0x2" set "STATUS_RasAuto=auto"
    if "!START_VAL!"=="0x3" set "STATUS_RasAuto=manual"
    if "!START_VAL!"=="0x4" set "STATUS_RasAuto=disabled"
    if not defined STATUS_RasAuto set "STATUS_RasAuto=unknown"
) else (
    set "STATUS_RasAuto=notfound"
)
echo   "RasAuto": "!STATUS_RasAuto!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_RasAuto="

REM Проверка службы RasMan
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\RasMan" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_RasMan=boot"
    if "!START_VAL!"=="0x1" set "STATUS_RasMan=system"
    if "!START_VAL!"=="0x2" set "STATUS_RasMan=auto"
    if "!START_VAL!"=="0x3" set "STATUS_RasMan=manual"
    if "!START_VAL!"=="0x4" set "STATUS_RasMan=disabled"
    if not defined STATUS_RasMan set "STATUS_RasMan=unknown"
) else (
    set "STATUS_RasMan=notfound"
)
echo   "RasMan": "!STATUS_RasMan!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_RasMan="

REM Проверка службы SNMPTRAP
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMPTRAP" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SNMPTRAP=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SNMPTRAP=system"
    if "!START_VAL!"=="0x2" set "STATUS_SNMPTRAP=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SNMPTRAP=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SNMPTRAP=disabled"
    if not defined STATUS_SNMPTRAP set "STATUS_SNMPTRAP=unknown"
) else (
    set "STATUS_SNMPTRAP=notfound"
)
echo   "SNMPTRAP": "!STATUS_SNMPTRAP!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SNMPTRAP="

REM Проверка службы WFDSConMgrSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WFDSConMgrSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WFDSConMgrSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WFDSConMgrSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_WFDSConMgrSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WFDSConMgrSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WFDSConMgrSvc=disabled"
    if not defined STATUS_WFDSConMgrSvc set "STATUS_WFDSConMgrSvc=unknown"
) else (
    set "STATUS_WFDSConMgrSvc=notfound"
)
echo   "WFDSConMgrSvc": "!STATUS_WFDSConMgrSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WFDSConMgrSvc="

REM Проверка службы WMPNetworkSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WMPNetworkSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WMPNetworkSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_WMPNetworkSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WMPNetworkSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WMPNetworkSvc=disabled"
    if not defined STATUS_WMPNetworkSvc set "STATUS_WMPNetworkSvc=unknown"
) else (
    set "STATUS_WMPNetworkSvc=notfound"
)
echo   "WMPNetworkSvc": "!STATUS_WMPNetworkSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WMPNetworkSvc="

REM Проверка службы bthserv
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_bthserv=boot"
    if "!START_VAL!"=="0x1" set "STATUS_bthserv=system"
    if "!START_VAL!"=="0x2" set "STATUS_bthserv=auto"
    if "!START_VAL!"=="0x3" set "STATUS_bthserv=manual"
    if "!START_VAL!"=="0x4" set "STATUS_bthserv=disabled"
    if not defined STATUS_bthserv set "STATUS_bthserv=unknown"
) else (
    set "STATUS_bthserv=notfound"
)
echo   "bthserv": "!STATUS_bthserv!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_bthserv="

REM Проверка службы BTAGService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_BTAGService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_BTAGService=system"
    if "!START_VAL!"=="0x2" set "STATUS_BTAGService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_BTAGService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_BTAGService=disabled"
    if not defined STATUS_BTAGService set "STATUS_BTAGService=unknown"
) else (
    set "STATUS_BTAGService=notfound"
)
echo   "BTAGService": "!STATUS_BTAGService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_BTAGService="

REM Проверка службы BthAvctpSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_BthAvctpSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_BthAvctpSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_BthAvctpSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_BthAvctpSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_BthAvctpSvc=disabled"
    if not defined STATUS_BthAvctpSvc set "STATUS_BthAvctpSvc=unknown"
) else (
    set "STATUS_BthAvctpSvc=notfound"
)
echo   "BthAvctpSvc": "!STATUS_BthAvctpSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_BthAvctpSvc="

REM Проверка службы BluetoothUserService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\BluetoothUserService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_BluetoothUserService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_BluetoothUserService=system"
    if "!START_VAL!"=="0x2" set "STATUS_BluetoothUserService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_BluetoothUserService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_BluetoothUserService=disabled"
    if not defined STATUS_BluetoothUserService set "STATUS_BluetoothUserService=unknown"
) else (
    set "STATUS_BluetoothUserService=notfound"
)
echo   "BluetoothUserService": "!STATUS_BluetoothUserService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_BluetoothUserService="

REM Проверка службы ShellHWDetection
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\ShellHWDetection" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_ShellHWDetection=boot"
    if "!START_VAL!"=="0x1" set "STATUS_ShellHWDetection=system"
    if "!START_VAL!"=="0x2" set "STATUS_ShellHWDetection=auto"
    if "!START_VAL!"=="0x3" set "STATUS_ShellHWDetection=manual"
    if "!START_VAL!"=="0x4" set "STATUS_ShellHWDetection=disabled"
    if not defined STATUS_ShellHWDetection set "STATUS_ShellHWDetection=unknown"
) else (
    set "STATUS_ShellHWDetection=notfound"
)
echo   "ShellHWDetection": "!STATUS_ShellHWDetection!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_ShellHWDetection="

REM Проверка службы WPDBusEnum
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WPDBusEnum" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WPDBusEnum=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WPDBusEnum=system"
    if "!START_VAL!"=="0x2" set "STATUS_WPDBusEnum=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WPDBusEnum=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WPDBusEnum=disabled"
    if not defined STATUS_WPDBusEnum set "STATUS_WPDBusEnum=unknown"
) else (
    set "STATUS_WPDBusEnum=notfound"
)
echo   "WPDBusEnum": "!STATUS_WPDBusEnum!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WPDBusEnum="

REM Проверка службы ScDeviceEnum
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\ScDeviceEnum" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_ScDeviceEnum=boot"
    if "!START_VAL!"=="0x1" set "STATUS_ScDeviceEnum=system"
    if "!START_VAL!"=="0x2" set "STATUS_ScDeviceEnum=auto"
    if "!START_VAL!"=="0x3" set "STATUS_ScDeviceEnum=manual"
    if "!START_VAL!"=="0x4" set "STATUS_ScDeviceEnum=disabled"
    if not defined STATUS_ScDeviceEnum set "STATUS_ScDeviceEnum=unknown"
) else (
    set "STATUS_ScDeviceEnum=notfound"
)
echo   "ScDeviceEnum": "!STATUS_ScDeviceEnum!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_ScDeviceEnum="

REM Проверка службы SCardSvr
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SCardSvr" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SCardSvr=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SCardSvr=system"
    if "!START_VAL!"=="0x2" set "STATUS_SCardSvr=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SCardSvr=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SCardSvr=disabled"
    if not defined STATUS_SCardSvr set "STATUS_SCardSvr=unknown"
) else (
    set "STATUS_SCardSvr=notfound"
)
echo   "SCardSvr": "!STATUS_SCardSvr!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SCardSvr="

REM Проверка службы SCPolicySvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SCPolicySvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SCPolicySvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SCPolicySvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_SCPolicySvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SCPolicySvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SCPolicySvc=disabled"
    if not defined STATUS_SCPolicySvc set "STATUS_SCPolicySvc=unknown"
) else (
    set "STATUS_SCPolicySvc=notfound"
)
echo   "SCPolicySvc": "!STATUS_SCPolicySvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SCPolicySvc="

REM Проверка службы DevicePickerUserSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\DevicePickerUserSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_DevicePickerUserSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_DevicePickerUserSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_DevicePickerUserSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_DevicePickerUserSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_DevicePickerUserSvc=disabled"
    if not defined STATUS_DevicePickerUserSvc set "STATUS_DevicePickerUserSvc=unknown"
) else (
    set "STATUS_DevicePickerUserSvc=notfound"
)
echo   "DevicePickerUserSvc": "!STATUS_DevicePickerUserSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_DevicePickerUserSvc="

REM Проверка службы DevicesFlowUserSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\DevicesFlowUserSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_DevicesFlowUserSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_DevicesFlowUserSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_DevicesFlowUserSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_DevicesFlowUserSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_DevicesFlowUserSvc=disabled"
    if not defined STATUS_DevicesFlowUserSvc set "STATUS_DevicesFlowUserSvc=unknown"
) else (
    set "STATUS_DevicesFlowUserSvc=notfound"
)
echo   "DevicesFlowUserSvc": "!STATUS_DevicesFlowUserSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_DevicesFlowUserSvc="

REM Проверка службы DevQueryBroker
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\DevQueryBroker" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_DevQueryBroker=boot"
    if "!START_VAL!"=="0x1" set "STATUS_DevQueryBroker=system"
    if "!START_VAL!"=="0x2" set "STATUS_DevQueryBroker=auto"
    if "!START_VAL!"=="0x3" set "STATUS_DevQueryBroker=manual"
    if "!START_VAL!"=="0x4" set "STATUS_DevQueryBroker=disabled"
    if not defined STATUS_DevQueryBroker set "STATUS_DevQueryBroker=unknown"
) else (
    set "STATUS_DevQueryBroker=notfound"
)
echo   "DevQueryBroker": "!STATUS_DevQueryBroker!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_DevQueryBroker="

REM Проверка службы DisplayEnhancementService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\DisplayEnhancementService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_DisplayEnhancementService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_DisplayEnhancementService=system"
    if "!START_VAL!"=="0x2" set "STATUS_DisplayEnhancementService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_DisplayEnhancementService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_DisplayEnhancementService=disabled"
    if not defined STATUS_DisplayEnhancementService set "STATUS_DisplayEnhancementService=unknown"
) else (
    set "STATUS_DisplayEnhancementService=notfound"
)
echo   "DisplayEnhancementService": "!STATUS_DisplayEnhancementService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_DisplayEnhancementService="

REM Проверка службы fhsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\fhsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_fhsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_fhsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_fhsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_fhsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_fhsvc=disabled"
    if not defined STATUS_fhsvc set "STATUS_fhsvc=unknown"
) else (
    set "STATUS_fhsvc=notfound"
)
echo   "fhsvc": "!STATUS_fhsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_fhsvc="

REM Проверка службы SDRSVC
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SDRSVC" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SDRSVC=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SDRSVC=system"
    if "!START_VAL!"=="0x2" set "STATUS_SDRSVC=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SDRSVC=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SDRSVC=disabled"
    if not defined STATUS_SDRSVC set "STATUS_SDRSVC=unknown"
) else (
    set "STATUS_SDRSVC=notfound"
)
echo   "SDRSVC": "!STATUS_SDRSVC!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SDRSVC="

REM Проверка службы swprv
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\swprv" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_swprv=boot"
    if "!START_VAL!"=="0x1" set "STATUS_swprv=system"
    if "!START_VAL!"=="0x2" set "STATUS_swprv=auto"
    if "!START_VAL!"=="0x3" set "STATUS_swprv=manual"
    if "!START_VAL!"=="0x4" set "STATUS_swprv=disabled"
    if not defined STATUS_swprv set "STATUS_swprv=unknown"
) else (
    set "STATUS_swprv=notfound"
)
echo   "swprv": "!STATUS_swprv!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_swprv="

REM Проверка службы VSS
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\VSS" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_VSS=boot"
    if "!START_VAL!"=="0x1" set "STATUS_VSS=system"
    if "!START_VAL!"=="0x2" set "STATUS_VSS=auto"
    if "!START_VAL!"=="0x3" set "STATUS_VSS=manual"
    if "!START_VAL!"=="0x4" set "STATUS_VSS=disabled"
    if not defined STATUS_VSS set "STATUS_VSS=unknown"
) else (
    set "STATUS_VSS=notfound"
)
echo   "VSS": "!STATUS_VSS!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_VSS="

REM Проверка службы wbengine
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\wbengine" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_wbengine=boot"
    if "!START_VAL!"=="0x1" set "STATUS_wbengine=system"
    if "!START_VAL!"=="0x2" set "STATUS_wbengine=auto"
    if "!START_VAL!"=="0x3" set "STATUS_wbengine=manual"
    if "!START_VAL!"=="0x4" set "STATUS_wbengine=disabled"
    if not defined STATUS_wbengine set "STATUS_wbengine=unknown"
) else (
    set "STATUS_wbengine=notfound"
)
echo   "wbengine": "!STATUS_wbengine!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_wbengine="

REM Проверка службы TieringEngineService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\TieringEngineService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_TieringEngineService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_TieringEngineService=system"
    if "!START_VAL!"=="0x2" set "STATUS_TieringEngineService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_TieringEngineService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_TieringEngineService=disabled"
    if not defined STATUS_TieringEngineService set "STATUS_TieringEngineService=unknown"
) else (
    set "STATUS_TieringEngineService=notfound"
)
echo   "TieringEngineService": "!STATUS_TieringEngineService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_TieringEngineService="

REM Проверка службы UsoSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_UsoSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_UsoSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_UsoSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_UsoSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_UsoSvc=disabled"
    if not defined STATUS_UsoSvc set "STATUS_UsoSvc=unknown"
) else (
    set "STATUS_UsoSvc=notfound"
)
echo   "UsoSvc": "!STATUS_UsoSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_UsoSvc="

REM Проверка службы WaaSMedicSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WaaSMedicSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WaaSMedicSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_WaaSMedicSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WaaSMedicSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WaaSMedicSvc=disabled"
    if not defined STATUS_WaaSMedicSvc set "STATUS_WaaSMedicSvc=unknown"
) else (
    set "STATUS_WaaSMedicSvc=notfound"
)
echo   "WaaSMedicSvc": "!STATUS_WaaSMedicSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WaaSMedicSvc="

REM Проверка службы wuauserv
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_wuauserv=boot"
    if "!START_VAL!"=="0x1" set "STATUS_wuauserv=system"
    if "!START_VAL!"=="0x2" set "STATUS_wuauserv=auto"
    if "!START_VAL!"=="0x3" set "STATUS_wuauserv=manual"
    if "!START_VAL!"=="0x4" set "STATUS_wuauserv=disabled"
    if not defined STATUS_wuauserv set "STATUS_wuauserv=unknown"
) else (
    set "STATUS_wuauserv=notfound"
)
echo   "wuauserv": "!STATUS_wuauserv!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_wuauserv="

REM Проверка службы DoSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_DoSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_DoSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_DoSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_DoSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_DoSvc=disabled"
    if not defined STATUS_DoSvc set "STATUS_DoSvc=unknown"
) else (
    set "STATUS_DoSvc=notfound"
)
echo   "DoSvc": "!STATUS_DoSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_DoSvc="

REM Проверка службы PushToInstall
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\PushToInstall" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_PushToInstall=boot"
    if "!START_VAL!"=="0x1" set "STATUS_PushToInstall=system"
    if "!START_VAL!"=="0x2" set "STATUS_PushToInstall=auto"
    if "!START_VAL!"=="0x3" set "STATUS_PushToInstall=manual"
    if "!START_VAL!"=="0x4" set "STATUS_PushToInstall=disabled"
    if not defined STATUS_PushToInstall set "STATUS_PushToInstall=unknown"
) else (
    set "STATUS_PushToInstall=notfound"
)
echo   "PushToInstall": "!STATUS_PushToInstall!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_PushToInstall="

REM Проверка службы vmicguestinterface
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\vmicguestinterface" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_vmicguestinterface=boot"
    if "!START_VAL!"=="0x1" set "STATUS_vmicguestinterface=system"
    if "!START_VAL!"=="0x2" set "STATUS_vmicguestinterface=auto"
    if "!START_VAL!"=="0x3" set "STATUS_vmicguestinterface=manual"
    if "!START_VAL!"=="0x4" set "STATUS_vmicguestinterface=disabled"
    if not defined STATUS_vmicguestinterface set "STATUS_vmicguestinterface=unknown"
) else (
    set "STATUS_vmicguestinterface=notfound"
)
echo   "vmicguestinterface": "!STATUS_vmicguestinterface!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_vmicguestinterface="

REM Проверка службы vmicheartbeat
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\vmicheartbeat" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_vmicheartbeat=boot"
    if "!START_VAL!"=="0x1" set "STATUS_vmicheartbeat=system"
    if "!START_VAL!"=="0x2" set "STATUS_vmicheartbeat=auto"
    if "!START_VAL!"=="0x3" set "STATUS_vmicheartbeat=manual"
    if "!START_VAL!"=="0x4" set "STATUS_vmicheartbeat=disabled"
    if not defined STATUS_vmicheartbeat set "STATUS_vmicheartbeat=unknown"
) else (
    set "STATUS_vmicheartbeat=notfound"
)
echo   "vmicheartbeat": "!STATUS_vmicheartbeat!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_vmicheartbeat="

REM Проверка службы vmickvpexchange
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\vmickvpexchange" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_vmickvpexchange=boot"
    if "!START_VAL!"=="0x1" set "STATUS_vmickvpexchange=system"
    if "!START_VAL!"=="0x2" set "STATUS_vmickvpexchange=auto"
    if "!START_VAL!"=="0x3" set "STATUS_vmickvpexchange=manual"
    if "!START_VAL!"=="0x4" set "STATUS_vmickvpexchange=disabled"
    if not defined STATUS_vmickvpexchange set "STATUS_vmickvpexchange=unknown"
) else (
    set "STATUS_vmickvpexchange=notfound"
)
echo   "vmickvpexchange": "!STATUS_vmickvpexchange!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_vmickvpexchange="

REM Проверка службы vmicrdv
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\vmicrdv" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_vmicrdv=boot"
    if "!START_VAL!"=="0x1" set "STATUS_vmicrdv=system"
    if "!START_VAL!"=="0x2" set "STATUS_vmicrdv=auto"
    if "!START_VAL!"=="0x3" set "STATUS_vmicrdv=manual"
    if "!START_VAL!"=="0x4" set "STATUS_vmicrdv=disabled"
    if not defined STATUS_vmicrdv set "STATUS_vmicrdv=unknown"
) else (
    set "STATUS_vmicrdv=notfound"
)
echo   "vmicrdv": "!STATUS_vmicrdv!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_vmicrdv="

REM Проверка службы vmicshutdown
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\vmicshutdown" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_vmicshutdown=boot"
    if "!START_VAL!"=="0x1" set "STATUS_vmicshutdown=system"
    if "!START_VAL!"=="0x2" set "STATUS_vmicshutdown=auto"
    if "!START_VAL!"=="0x3" set "STATUS_vmicshutdown=manual"
    if "!START_VAL!"=="0x4" set "STATUS_vmicshutdown=disabled"
    if not defined STATUS_vmicshutdown set "STATUS_vmicshutdown=unknown"
) else (
    set "STATUS_vmicshutdown=notfound"
)
echo   "vmicshutdown": "!STATUS_vmicshutdown!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_vmicshutdown="

REM Проверка службы vmictimesync
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\vmictimesync" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_vmictimesync=boot"
    if "!START_VAL!"=="0x1" set "STATUS_vmictimesync=system"
    if "!START_VAL!"=="0x2" set "STATUS_vmictimesync=auto"
    if "!START_VAL!"=="0x3" set "STATUS_vmictimesync=manual"
    if "!START_VAL!"=="0x4" set "STATUS_vmictimesync=disabled"
    if not defined STATUS_vmictimesync set "STATUS_vmictimesync=unknown"
) else (
    set "STATUS_vmictimesync=notfound"
)
echo   "vmictimesync": "!STATUS_vmictimesync!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_vmictimesync="

REM Проверка службы vmicvmsession
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\vmicvmsession" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_vmicvmsession=boot"
    if "!START_VAL!"=="0x1" set "STATUS_vmicvmsession=system"
    if "!START_VAL!"=="0x2" set "STATUS_vmicvmsession=auto"
    if "!START_VAL!"=="0x3" set "STATUS_vmicvmsession=manual"
    if "!START_VAL!"=="0x4" set "STATUS_vmicvmsession=disabled"
    if not defined STATUS_vmicvmsession set "STATUS_vmicvmsession=unknown"
) else (
    set "STATUS_vmicvmsession=notfound"
)
echo   "vmicvmsession": "!STATUS_vmicvmsession!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_vmicvmsession="

REM Проверка службы vmicvss
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\vmicvss" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_vmicvss=boot"
    if "!START_VAL!"=="0x1" set "STATUS_vmicvss=system"
    if "!START_VAL!"=="0x2" set "STATUS_vmicvss=auto"
    if "!START_VAL!"=="0x3" set "STATUS_vmicvss=manual"
    if "!START_VAL!"=="0x4" set "STATUS_vmicvss=disabled"
    if not defined STATUS_vmicvss set "STATUS_vmicvss=unknown"
) else (
    set "STATUS_vmicvss=notfound"
)
echo   "vmicvss": "!STATUS_vmicvss!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_vmicvss="

REM Проверка службы HvHost
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\HvHost" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_HvHost=boot"
    if "!START_VAL!"=="0x1" set "STATUS_HvHost=system"
    if "!START_VAL!"=="0x2" set "STATUS_HvHost=auto"
    if "!START_VAL!"=="0x3" set "STATUS_HvHost=manual"
    if "!START_VAL!"=="0x4" set "STATUS_HvHost=disabled"
    if not defined STATUS_HvHost set "STATUS_HvHost=unknown"
) else (
    set "STATUS_HvHost=notfound"
)
echo   "HvHost": "!STATUS_HvHost!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_HvHost="

REM Проверка службы RetailDemo
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\RetailDemo" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_RetailDemo=boot"
    if "!START_VAL!"=="0x1" set "STATUS_RetailDemo=system"
    if "!START_VAL!"=="0x2" set "STATUS_RetailDemo=auto"
    if "!START_VAL!"=="0x3" set "STATUS_RetailDemo=manual"
    if "!START_VAL!"=="0x4" set "STATUS_RetailDemo=disabled"
    if not defined STATUS_RetailDemo set "STATUS_RetailDemo=unknown"
) else (
    set "STATUS_RetailDemo=notfound"
)
echo   "RetailDemo": "!STATUS_RetailDemo!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_RetailDemo="

REM Проверка службы PhoneSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\PhoneSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_PhoneSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_PhoneSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_PhoneSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_PhoneSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_PhoneSvc=disabled"
    if not defined STATUS_PhoneSvc set "STATUS_PhoneSvc=unknown"
) else (
    set "STATUS_PhoneSvc=notfound"
)
echo   "PhoneSvc": "!STATUS_PhoneSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_PhoneSvc="

REM Проверка службы MessagingService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_MessagingService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_MessagingService=system"
    if "!START_VAL!"=="0x2" set "STATUS_MessagingService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_MessagingService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_MessagingService=disabled"
    if not defined STATUS_MessagingService set "STATUS_MessagingService=unknown"
) else (
    set "STATUS_MessagingService=notfound"
)
echo   "MessagingService": "!STATUS_MessagingService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_MessagingService="

REM Проверка службы SmsRouter
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SmsRouter" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SmsRouter=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SmsRouter=system"
    if "!START_VAL!"=="0x2" set "STATUS_SmsRouter=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SmsRouter=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SmsRouter=disabled"
    if not defined STATUS_SmsRouter set "STATUS_SmsRouter=unknown"
) else (
    set "STATUS_SmsRouter=notfound"
)
echo   "SmsRouter": "!STATUS_SmsRouter!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SmsRouter="

REM Проверка службы Fax
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Fax" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_Fax=boot"
    if "!START_VAL!"=="0x1" set "STATUS_Fax=system"
    if "!START_VAL!"=="0x2" set "STATUS_Fax=auto"
    if "!START_VAL!"=="0x3" set "STATUS_Fax=manual"
    if "!START_VAL!"=="0x4" set "STATUS_Fax=disabled"
    if not defined STATUS_Fax set "STATUS_Fax=unknown"
) else (
    set "STATUS_Fax=notfound"
)
echo   "Fax": "!STATUS_Fax!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_Fax="

REM Проверка службы TabletInputService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_TabletInputService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_TabletInputService=system"
    if "!START_VAL!"=="0x2" set "STATUS_TabletInputService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_TabletInputService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_TabletInputService=disabled"
    if not defined STATUS_TabletInputService set "STATUS_TabletInputService=unknown"
) else (
    set "STATUS_TabletInputService=notfound"
)
echo   "TabletInputService": "!STATUS_TabletInputService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_TabletInputService="

REM Проверка службы WbioSrvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WbioSrvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WbioSrvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WbioSrvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_WbioSrvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WbioSrvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WbioSrvc=disabled"
    if not defined STATUS_WbioSrvc set "STATUS_WbioSrvc=unknown"
) else (
    set "STATUS_WbioSrvc=notfound"
)
echo   "WbioSrvc": "!STATUS_WbioSrvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WbioSrvc="

REM Проверка службы SEMgrSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SEMgrSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SEMgrSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_SEMgrSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SEMgrSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SEMgrSvc=disabled"
    if not defined STATUS_SEMgrSvc set "STATUS_SEMgrSvc=unknown"
) else (
    set "STATUS_SEMgrSvc=notfound"
)
echo   "SEMgrSvc": "!STATUS_SEMgrSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SEMgrSvc="

REM Проверка службы WalletService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WalletService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WalletService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WalletService=system"
    if "!START_VAL!"=="0x2" set "STATUS_WalletService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WalletService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WalletService=disabled"
    if not defined STATUS_WalletService set "STATUS_WalletService=unknown"
) else (
    set "STATUS_WalletService=notfound"
)
echo   "WalletService": "!STATUS_WalletService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WalletService="

REM Проверка службы wisvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_wisvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_wisvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_wisvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_wisvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_wisvc=disabled"
    if not defined STATUS_wisvc set "STATUS_wisvc=unknown"
) else (
    set "STATUS_wisvc=notfound"
)
echo   "wisvc": "!STATUS_wisvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_wisvc="

REM Проверка службы NaturalAuthentication
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NaturalAuthentication" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_NaturalAuthentication=boot"
    if "!START_VAL!"=="0x1" set "STATUS_NaturalAuthentication=system"
    if "!START_VAL!"=="0x2" set "STATUS_NaturalAuthentication=auto"
    if "!START_VAL!"=="0x3" set "STATUS_NaturalAuthentication=manual"
    if "!START_VAL!"=="0x4" set "STATUS_NaturalAuthentication=disabled"
    if not defined STATUS_NaturalAuthentication set "STATUS_NaturalAuthentication=unknown"
) else (
    set "STATUS_NaturalAuthentication=notfound"
)
echo   "NaturalAuthentication": "!STATUS_NaturalAuthentication!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_NaturalAuthentication="

REM Проверка службы OneSyncSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_OneSyncSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_OneSyncSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_OneSyncSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_OneSyncSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_OneSyncSvc=disabled"
    if not defined STATUS_OneSyncSvc set "STATUS_OneSyncSvc=unknown"
) else (
    set "STATUS_OneSyncSvc=notfound"
)
echo   "OneSyncSvc": "!STATUS_OneSyncSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_OneSyncSvc="

REM Проверка службы CDPUserSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_CDPUserSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_CDPUserSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_CDPUserSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_CDPUserSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_CDPUserSvc=disabled"
    if not defined STATUS_CDPUserSvc set "STATUS_CDPUserSvc=unknown"
) else (
    set "STATUS_CDPUserSvc=notfound"
)
echo   "CDPUserSvc": "!STATUS_CDPUserSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_CDPUserSvc="

REM Проверка службы CDPSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_CDPSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_CDPSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_CDPSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_CDPSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_CDPSvc=disabled"
    if not defined STATUS_CDPSvc set "STATUS_CDPSvc=unknown"
) else (
    set "STATUS_CDPSvc=notfound"
)
echo   "CDPSvc": "!STATUS_CDPSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_CDPSvc="

REM Проверка службы BcastDVRUserService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\BcastDVRUserService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_BcastDVRUserService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_BcastDVRUserService=system"
    if "!START_VAL!"=="0x2" set "STATUS_BcastDVRUserService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_BcastDVRUserService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_BcastDVRUserService=disabled"
    if not defined STATUS_BcastDVRUserService set "STATUS_BcastDVRUserService=unknown"
) else (
    set "STATUS_BcastDVRUserService=notfound"
)
echo   "BcastDVRUserService": "!STATUS_BcastDVRUserService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_BcastDVRUserService="

REM Проверка службы CaptureService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\CaptureService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_CaptureService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_CaptureService=system"
    if "!START_VAL!"=="0x2" set "STATUS_CaptureService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_CaptureService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_CaptureService=disabled"
    if not defined STATUS_CaptureService set "STATUS_CaptureService=unknown"
) else (
    set "STATUS_CaptureService=notfound"
)
echo   "CaptureService": "!STATUS_CaptureService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_CaptureService="

REM Проверка службы cbdhsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\cbdhsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_cbdhsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_cbdhsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_cbdhsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_cbdhsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_cbdhsvc=disabled"
    if not defined STATUS_cbdhsvc set "STATUS_cbdhsvc=unknown"
) else (
    set "STATUS_cbdhsvc=notfound"
)
echo   "cbdhsvc": "!STATUS_cbdhsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_cbdhsvc="

REM Проверка службы ConsentUxUserSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\ConsentUxUserSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_ConsentUxUserSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_ConsentUxUserSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_ConsentUxUserSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_ConsentUxUserSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_ConsentUxUserSvc=disabled"
    if not defined STATUS_ConsentUxUserSvc set "STATUS_ConsentUxUserSvc=unknown"
) else (
    set "STATUS_ConsentUxUserSvc=notfound"
)
echo   "ConsentUxUserSvc": "!STATUS_ConsentUxUserSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_ConsentUxUserSvc="

REM Проверка службы SharedRealitySvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SharedRealitySvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SharedRealitySvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_SharedRealitySvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SharedRealitySvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SharedRealitySvc=disabled"
    if not defined STATUS_SharedRealitySvc set "STATUS_SharedRealitySvc=unknown"
) else (
    set "STATUS_SharedRealitySvc=notfound"
)
echo   "SharedRealitySvc": "!STATUS_SharedRealitySvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SharedRealitySvc="

REM Проверка службы MixedRealityOpenXRSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\MixedRealityOpenXRSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_MixedRealityOpenXRSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_MixedRealityOpenXRSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_MixedRealityOpenXRSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_MixedRealityOpenXRSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_MixedRealityOpenXRSvc=disabled"
    if not defined STATUS_MixedRealityOpenXRSvc set "STATUS_MixedRealityOpenXRSvc=unknown"
) else (
    set "STATUS_MixedRealityOpenXRSvc=notfound"
)
echo   "MixedRealityOpenXRSvc": "!STATUS_MixedRealityOpenXRSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_MixedRealityOpenXRSvc="

REM Проверка службы spectrum
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\spectrum" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_spectrum=boot"
    if "!START_VAL!"=="0x1" set "STATUS_spectrum=system"
    if "!START_VAL!"=="0x2" set "STATUS_spectrum=auto"
    if "!START_VAL!"=="0x3" set "STATUS_spectrum=manual"
    if "!START_VAL!"=="0x4" set "STATUS_spectrum=disabled"
    if not defined STATUS_spectrum set "STATUS_spectrum=unknown"
) else (
    set "STATUS_spectrum=notfound"
)
echo   "spectrum": "!STATUS_spectrum!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_spectrum="

REM Проверка службы perceptionsimulation
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\perceptionsimulation" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_perceptionsimulation=boot"
    if "!START_VAL!"=="0x1" set "STATUS_perceptionsimulation=system"
    if "!START_VAL!"=="0x2" set "STATUS_perceptionsimulation=auto"
    if "!START_VAL!"=="0x3" set "STATUS_perceptionsimulation=manual"
    if "!START_VAL!"=="0x4" set "STATUS_perceptionsimulation=disabled"
    if not defined STATUS_perceptionsimulation set "STATUS_perceptionsimulation=unknown"
) else (
    set "STATUS_perceptionsimulation=notfound"
)
echo   "perceptionsimulation": "!STATUS_perceptionsimulation!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_perceptionsimulation="

REM Проверка службы UevAgentService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\UevAgentService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_UevAgentService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_UevAgentService=system"
    if "!START_VAL!"=="0x2" set "STATUS_UevAgentService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_UevAgentService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_UevAgentService=disabled"
    if not defined STATUS_UevAgentService set "STATUS_UevAgentService=unknown"
) else (
    set "STATUS_UevAgentService=notfound"
)
echo   "UevAgentService": "!STATUS_UevAgentService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_UevAgentService="

REM Проверка службы UmRdpService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\UmRdpService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_UmRdpService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_UmRdpService=system"
    if "!START_VAL!"=="0x2" set "STATUS_UmRdpService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_UmRdpService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_UmRdpService=disabled"
    if not defined STATUS_UmRdpService set "STATUS_UmRdpService=unknown"
) else (
    set "STATUS_UmRdpService=notfound"
)
echo   "UmRdpService": "!STATUS_UmRdpService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_UmRdpService="

REM Проверка службы TermService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\TermService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_TermService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_TermService=system"
    if "!START_VAL!"=="0x2" set "STATUS_TermService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_TermService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_TermService=disabled"
    if not defined STATUS_TermService set "STATUS_TermService=unknown"
) else (
    set "STATUS_TermService=notfound"
)
echo   "TermService": "!STATUS_TermService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_TermService="

REM Проверка службы SessionEnv
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SessionEnv" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SessionEnv=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SessionEnv=system"
    if "!START_VAL!"=="0x2" set "STATUS_SessionEnv=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SessionEnv=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SessionEnv=disabled"
    if not defined STATUS_SessionEnv set "STATUS_SessionEnv=unknown"
) else (
    set "STATUS_SessionEnv=notfound"
)
echo   "SessionEnv": "!STATUS_SessionEnv!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SessionEnv="

REM Проверка службы shpamsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_shpamsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_shpamsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_shpamsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_shpamsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_shpamsvc=disabled"
    if not defined STATUS_shpamsvc set "STATUS_shpamsvc=unknown"
) else (
    set "STATUS_shpamsvc=notfound"
)
echo   "shpamsvc": "!STATUS_shpamsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_shpamsvc="

REM Проверка службы smphost
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\smphost" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_smphost=boot"
    if "!START_VAL!"=="0x1" set "STATUS_smphost=system"
    if "!START_VAL!"=="0x2" set "STATUS_smphost=auto"
    if "!START_VAL!"=="0x3" set "STATUS_smphost=manual"
    if "!START_VAL!"=="0x4" set "STATUS_smphost=disabled"
    if not defined STATUS_smphost set "STATUS_smphost=unknown"
) else (
    set "STATUS_smphost=notfound"
)
echo   "smphost": "!STATUS_smphost!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_smphost="

REM Проверка службы svsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\svsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_svsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_svsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_svsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_svsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_svsvc=disabled"
    if not defined STATUS_svsvc set "STATUS_svsvc=unknown"
) else (
    set "STATUS_svsvc=notfound"
)
echo   "svsvc": "!STATUS_svsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_svsvc="

REM Проверка службы TapiSrv
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_TapiSrv=boot"
    if "!START_VAL!"=="0x1" set "STATUS_TapiSrv=system"
    if "!START_VAL!"=="0x2" set "STATUS_TapiSrv=auto"
    if "!START_VAL!"=="0x3" set "STATUS_TapiSrv=manual"
    if "!START_VAL!"=="0x4" set "STATUS_TapiSrv=disabled"
    if not defined STATUS_TapiSrv set "STATUS_TapiSrv=unknown"
) else (
    set "STATUS_TapiSrv=notfound"
)
echo   "TapiSrv": "!STATUS_TapiSrv!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_TapiSrv="

REM Проверка службы TimeBrokerSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\TimeBrokerSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_TimeBrokerSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_TimeBrokerSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_TimeBrokerSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_TimeBrokerSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_TimeBrokerSvc=disabled"
    if not defined STATUS_TimeBrokerSvc set "STATUS_TimeBrokerSvc=unknown"
) else (
    set "STATUS_TimeBrokerSvc=notfound"
)
echo   "TimeBrokerSvc": "!STATUS_TimeBrokerSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_TimeBrokerSvc="

REM Проверка службы TokenBroker
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\TokenBroker" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_TokenBroker=boot"
    if "!START_VAL!"=="0x1" set "STATUS_TokenBroker=system"
    if "!START_VAL!"=="0x2" set "STATUS_TokenBroker=auto"
    if "!START_VAL!"=="0x3" set "STATUS_TokenBroker=manual"
    if "!START_VAL!"=="0x4" set "STATUS_TokenBroker=disabled"
    if not defined STATUS_TokenBroker set "STATUS_TokenBroker=unknown"
) else (
    set "STATUS_TokenBroker=notfound"
)
echo   "TokenBroker": "!STATUS_TokenBroker!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_TokenBroker="

REM Проверка службы TrkWks
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_TrkWks=boot"
    if "!START_VAL!"=="0x1" set "STATUS_TrkWks=system"
    if "!START_VAL!"=="0x2" set "STATUS_TrkWks=auto"
    if "!START_VAL!"=="0x3" set "STATUS_TrkWks=manual"
    if "!START_VAL!"=="0x4" set "STATUS_TrkWks=disabled"
    if not defined STATUS_TrkWks set "STATUS_TrkWks=unknown"
) else (
    set "STATUS_TrkWks=notfound"
)
echo   "TrkWks": "!STATUS_TrkWks!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_TrkWks="

REM Проверка службы tzautoupdate
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdate" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_tzautoupdate=boot"
    if "!START_VAL!"=="0x1" set "STATUS_tzautoupdate=system"
    if "!START_VAL!"=="0x2" set "STATUS_tzautoupdate=auto"
    if "!START_VAL!"=="0x3" set "STATUS_tzautoupdate=manual"
    if "!START_VAL!"=="0x4" set "STATUS_tzautoupdate=disabled"
    if not defined STATUS_tzautoupdate set "STATUS_tzautoupdate=unknown"
) else (
    set "STATUS_tzautoupdate=notfound"
)
echo   "tzautoupdate": "!STATUS_tzautoupdate!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_tzautoupdate="

REM Проверка службы UserDataSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_UserDataSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_UserDataSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_UserDataSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_UserDataSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_UserDataSvc=disabled"
    if not defined STATUS_UserDataSvc set "STATUS_UserDataSvc=unknown"
) else (
    set "STATUS_UserDataSvc=notfound"
)
echo   "UserDataSvc": "!STATUS_UserDataSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_UserDataSvc="

REM Проверка службы UnistoreSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\UnistoreSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_UnistoreSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_UnistoreSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_UnistoreSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_UnistoreSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_UnistoreSvc=disabled"
    if not defined STATUS_UnistoreSvc set "STATUS_UnistoreSvc=unknown"
) else (
    set "STATUS_UnistoreSvc=notfound"
)
echo   "UnistoreSvc": "!STATUS_UnistoreSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_UnistoreSvc="

REM Проверка службы VacSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\VacSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_VacSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_VacSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_VacSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_VacSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_VacSvc=disabled"
    if not defined STATUS_VacSvc set "STATUS_VacSvc=unknown"
) else (
    set "STATUS_VacSvc=notfound"
)
echo   "VacSvc": "!STATUS_VacSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_VacSvc="

REM Проверка службы VaultSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\VaultSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_VaultSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_VaultSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_VaultSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_VaultSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_VaultSvc=disabled"
    if not defined STATUS_VaultSvc set "STATUS_VaultSvc=unknown"
) else (
    set "STATUS_VaultSvc=notfound"
)
echo   "VaultSvc": "!STATUS_VaultSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_VaultSvc="

REM Проверка службы vds
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\vds" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_vds=boot"
    if "!START_VAL!"=="0x1" set "STATUS_vds=system"
    if "!START_VAL!"=="0x2" set "STATUS_vds=auto"
    if "!START_VAL!"=="0x3" set "STATUS_vds=manual"
    if "!START_VAL!"=="0x4" set "STATUS_vds=disabled"
    if not defined STATUS_vds set "STATUS_vds=unknown"
) else (
    set "STATUS_vds=notfound"
)
echo   "vds": "!STATUS_vds!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_vds="

REM Проверка службы W32Time
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\W32Time" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_W32Time=boot"
    if "!START_VAL!"=="0x1" set "STATUS_W32Time=system"
    if "!START_VAL!"=="0x2" set "STATUS_W32Time=auto"
    if "!START_VAL!"=="0x3" set "STATUS_W32Time=manual"
    if "!START_VAL!"=="0x4" set "STATUS_W32Time=disabled"
    if not defined STATUS_W32Time set "STATUS_W32Time=unknown"
) else (
    set "STATUS_W32Time=notfound"
)
echo   "W32Time": "!STATUS_W32Time!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_W32Time="

REM Проверка службы WarpJITSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WarpJITSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WarpJITSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WarpJITSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_WarpJITSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WarpJITSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WarpJITSvc=disabled"
    if not defined STATUS_WarpJITSvc set "STATUS_WarpJITSvc=unknown"
) else (
    set "STATUS_WarpJITSvc=notfound"
)
echo   "WarpJITSvc": "!STATUS_WarpJITSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WarpJITSvc="

REM Проверка службы WEPHOSTSVC
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WEPHOSTSVC" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WEPHOSTSVC=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WEPHOSTSVC=system"
    if "!START_VAL!"=="0x2" set "STATUS_WEPHOSTSVC=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WEPHOSTSVC=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WEPHOSTSVC=disabled"
    if not defined STATUS_WEPHOSTSVC set "STATUS_WEPHOSTSVC=unknown"
) else (
    set "STATUS_WEPHOSTSVC=notfound"
)
echo   "WEPHOSTSVC": "!STATUS_WEPHOSTSVC!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WEPHOSTSVC="

REM Проверка службы WpcMonSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WpcMonSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WpcMonSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_WpcMonSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WpcMonSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WpcMonSvc=disabled"
    if not defined STATUS_WpcMonSvc set "STATUS_WpcMonSvc=unknown"
) else (
    set "STATUS_WpcMonSvc=notfound"
)
echo   "WpcMonSvc": "!STATUS_WpcMonSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WpcMonSvc="

REM Проверка службы edgeupdate
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdate" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_edgeupdate=boot"
    if "!START_VAL!"=="0x1" set "STATUS_edgeupdate=system"
    if "!START_VAL!"=="0x2" set "STATUS_edgeupdate=auto"
    if "!START_VAL!"=="0x3" set "STATUS_edgeupdate=manual"
    if "!START_VAL!"=="0x4" set "STATUS_edgeupdate=disabled"
    if not defined STATUS_edgeupdate set "STATUS_edgeupdate=unknown"
) else (
    set "STATUS_edgeupdate=notfound"
)
echo   "edgeupdate": "!STATUS_edgeupdate!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_edgeupdate="

REM Проверка службы edgeupdatem
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdatem" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_edgeupdatem=boot"
    if "!START_VAL!"=="0x1" set "STATUS_edgeupdatem=system"
    if "!START_VAL!"=="0x2" set "STATUS_edgeupdatem=auto"
    if "!START_VAL!"=="0x3" set "STATUS_edgeupdatem=manual"
    if "!START_VAL!"=="0x4" set "STATUS_edgeupdatem=disabled"
    if not defined STATUS_edgeupdatem set "STATUS_edgeupdatem=unknown"
) else (
    set "STATUS_edgeupdatem=notfound"
)
echo   "edgeupdatem": "!STATUS_edgeupdatem!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_edgeupdatem="

REM Проверка службы MicrosoftEdgeElevationService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\MicrosoftEdgeElevationService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_MicrosoftEdgeElevationService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_MicrosoftEdgeElevationService=system"
    if "!START_VAL!"=="0x2" set "STATUS_MicrosoftEdgeElevationService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_MicrosoftEdgeElevationService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_MicrosoftEdgeElevationService=disabled"
    if not defined STATUS_MicrosoftEdgeElevationService set "STATUS_MicrosoftEdgeElevationService=unknown"
) else (
    set "STATUS_MicrosoftEdgeElevationService=notfound"
)
echo   "MicrosoftEdgeElevationService": "!STATUS_MicrosoftEdgeElevationService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_MicrosoftEdgeElevationService="

REM Проверка службы GpuEnergyDrv
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_GpuEnergyDrv=boot"
    if "!START_VAL!"=="0x1" set "STATUS_GpuEnergyDrv=system"
    if "!START_VAL!"=="0x2" set "STATUS_GpuEnergyDrv=auto"
    if "!START_VAL!"=="0x3" set "STATUS_GpuEnergyDrv=manual"
    if "!START_VAL!"=="0x4" set "STATUS_GpuEnergyDrv=disabled"
    if not defined STATUS_GpuEnergyDrv set "STATUS_GpuEnergyDrv=unknown"
) else (
    set "STATUS_GpuEnergyDrv=notfound"
)
echo   "GpuEnergyDrv": "!STATUS_GpuEnergyDrv!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_GpuEnergyDrv="

REM Проверка службы GraphicsPerfSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\GraphicsPerfSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_GraphicsPerfSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_GraphicsPerfSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_GraphicsPerfSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_GraphicsPerfSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_GraphicsPerfSvc=disabled"
    if not defined STATUS_GraphicsPerfSvc set "STATUS_GraphicsPerfSvc=unknown"
) else (
    set "STATUS_GraphicsPerfSvc=notfound"
)
echo   "GraphicsPerfSvc": "!STATUS_GraphicsPerfSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_GraphicsPerfSvc="

REM Проверка службы AppMgmt
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\AppMgmt" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_AppMgmt=boot"
    if "!START_VAL!"=="0x1" set "STATUS_AppMgmt=system"
    if "!START_VAL!"=="0x2" set "STATUS_AppMgmt=auto"
    if "!START_VAL!"=="0x3" set "STATUS_AppMgmt=manual"
    if "!START_VAL!"=="0x4" set "STATUS_AppMgmt=disabled"
    if not defined STATUS_AppMgmt set "STATUS_AppMgmt=unknown"
) else (
    set "STATUS_AppMgmt=notfound"
)
echo   "AppMgmt": "!STATUS_AppMgmt!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_AppMgmt="

REM Проверка службы AppReadiness
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\AppReadiness" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_AppReadiness=boot"
    if "!START_VAL!"=="0x1" set "STATUS_AppReadiness=system"
    if "!START_VAL!"=="0x2" set "STATUS_AppReadiness=auto"
    if "!START_VAL!"=="0x3" set "STATUS_AppReadiness=manual"
    if "!START_VAL!"=="0x4" set "STATUS_AppReadiness=disabled"
    if not defined STATUS_AppReadiness set "STATUS_AppReadiness=unknown"
) else (
    set "STATUS_AppReadiness=notfound"
)
echo   "AppReadiness": "!STATUS_AppReadiness!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_AppReadiness="

REM Проверка службы AssignedAccessManagerSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\AssignedAccessManagerSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_AssignedAccessManagerSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_AssignedAccessManagerSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_AssignedAccessManagerSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_AssignedAccessManagerSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_AssignedAccessManagerSvc=disabled"
    if not defined STATUS_AssignedAccessManagerSvc set "STATUS_AssignedAccessManagerSvc=unknown"
) else (
    set "STATUS_AssignedAccessManagerSvc=notfound"
)
echo   "AssignedAccessManagerSvc": "!STATUS_AssignedAccessManagerSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_AssignedAccessManagerSvc="

REM Проверка службы AxInstSV
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\AxInstSV" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_AxInstSV=boot"
    if "!START_VAL!"=="0x1" set "STATUS_AxInstSV=system"
    if "!START_VAL!"=="0x2" set "STATUS_AxInstSV=auto"
    if "!START_VAL!"=="0x3" set "STATUS_AxInstSV=manual"
    if "!START_VAL!"=="0x4" set "STATUS_AxInstSV=disabled"
    if not defined STATUS_AxInstSV set "STATUS_AxInstSV=unknown"
) else (
    set "STATUS_AxInstSV=notfound"
)
echo   "AxInstSV": "!STATUS_AxInstSV!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_AxInstSV="

REM Проверка службы COMSysApp
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\COMSysApp" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_COMSysApp=boot"
    if "!START_VAL!"=="0x1" set "STATUS_COMSysApp=system"
    if "!START_VAL!"=="0x2" set "STATUS_COMSysApp=auto"
    if "!START_VAL!"=="0x3" set "STATUS_COMSysApp=manual"
    if "!START_VAL!"=="0x4" set "STATUS_COMSysApp=disabled"
    if not defined STATUS_COMSysApp set "STATUS_COMSysApp=unknown"
) else (
    set "STATUS_COMSysApp=notfound"
)
echo   "COMSysApp": "!STATUS_COMSysApp!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_COMSysApp="

REM Проверка службы CscService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\CscService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_CscService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_CscService=system"
    if "!START_VAL!"=="0x2" set "STATUS_CscService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_CscService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_CscService=disabled"
    if not defined STATUS_CscService set "STATUS_CscService=unknown"
) else (
    set "STATUS_CscService=notfound"
)
echo   "CscService": "!STATUS_CscService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_CscService="

REM Проверка службы defragsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\defragsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_defragsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_defragsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_defragsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_defragsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_defragsvc=disabled"
    if not defined STATUS_defragsvc set "STATUS_defragsvc=unknown"
) else (
    set "STATUS_defragsvc=notfound"
)
echo   "defragsvc": "!STATUS_defragsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_defragsvc="

REM Проверка службы DmEnrollmentSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\DmEnrollmentSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_DmEnrollmentSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_DmEnrollmentSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_DmEnrollmentSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_DmEnrollmentSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_DmEnrollmentSvc=disabled"
    if not defined STATUS_DmEnrollmentSvc set "STATUS_DmEnrollmentSvc=unknown"
) else (
    set "STATUS_DmEnrollmentSvc=notfound"
)
echo   "DmEnrollmentSvc": "!STATUS_DmEnrollmentSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_DmEnrollmentSvc="

REM Проверка службы DsmSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\DsmSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_DsmSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_DsmSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_DsmSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_DsmSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_DsmSvc=disabled"
    if not defined STATUS_DsmSvc set "STATUS_DsmSvc=unknown"
) else (
    set "STATUS_DsmSvc=notfound"
)
echo   "DsmSvc": "!STATUS_DsmSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_DsmSvc="

REM Проверка службы DsSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\DsSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_DsSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_DsSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_DsSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_DsSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_DsSvc=disabled"
    if not defined STATUS_DsSvc set "STATUS_DsSvc=unknown"
) else (
    set "STATUS_DsSvc=notfound"
)
echo   "DsSvc": "!STATUS_DsSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_DsSvc="

REM Проверка службы DusmSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_DusmSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_DusmSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_DusmSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_DusmSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_DusmSvc=disabled"
    if not defined STATUS_DusmSvc set "STATUS_DusmSvc=unknown"
) else (
    set "STATUS_DusmSvc=notfound"
)
echo   "DusmSvc": "!STATUS_DusmSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_DusmSvc="

REM Проверка службы Eaphost
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eaphost" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_Eaphost=boot"
    if "!START_VAL!"=="0x1" set "STATUS_Eaphost=system"
    if "!START_VAL!"=="0x2" set "STATUS_Eaphost=auto"
    if "!START_VAL!"=="0x3" set "STATUS_Eaphost=manual"
    if "!START_VAL!"=="0x4" set "STATUS_Eaphost=disabled"
    if not defined STATUS_Eaphost set "STATUS_Eaphost=unknown"
) else (
    set "STATUS_Eaphost=notfound"
)
echo   "Eaphost": "!STATUS_Eaphost!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_Eaphost="

REM Проверка службы embeddedmode
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\embeddedmode" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_embeddedmode=boot"
    if "!START_VAL!"=="0x1" set "STATUS_embeddedmode=system"
    if "!START_VAL!"=="0x2" set "STATUS_embeddedmode=auto"
    if "!START_VAL!"=="0x3" set "STATUS_embeddedmode=manual"
    if "!START_VAL!"=="0x4" set "STATUS_embeddedmode=disabled"
    if not defined STATUS_embeddedmode set "STATUS_embeddedmode=unknown"
) else (
    set "STATUS_embeddedmode=notfound"
)
echo   "embeddedmode": "!STATUS_embeddedmode!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_embeddedmode="

REM Проверка службы EntAppSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\EntAppSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_EntAppSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_EntAppSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_EntAppSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_EntAppSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_EntAppSvc=disabled"
    if not defined STATUS_EntAppSvc set "STATUS_EntAppSvc=unknown"
) else (
    set "STATUS_EntAppSvc=notfound"
)
echo   "EntAppSvc": "!STATUS_EntAppSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_EntAppSvc="

REM Проверка службы fdPHost
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\fdPHost" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_fdPHost=boot"
    if "!START_VAL!"=="0x1" set "STATUS_fdPHost=system"
    if "!START_VAL!"=="0x2" set "STATUS_fdPHost=auto"
    if "!START_VAL!"=="0x3" set "STATUS_fdPHost=manual"
    if "!START_VAL!"=="0x4" set "STATUS_fdPHost=disabled"
    if not defined STATUS_fdPHost set "STATUS_fdPHost=unknown"
) else (
    set "STATUS_fdPHost=notfound"
)
echo   "fdPHost": "!STATUS_fdPHost!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_fdPHost="

REM Проверка службы FDResPub
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\FDResPub" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_FDResPub=boot"
    if "!START_VAL!"=="0x1" set "STATUS_FDResPub=system"
    if "!START_VAL!"=="0x2" set "STATUS_FDResPub=auto"
    if "!START_VAL!"=="0x3" set "STATUS_FDResPub=manual"
    if "!START_VAL!"=="0x4" set "STATUS_FDResPub=disabled"
    if not defined STATUS_FDResPub set "STATUS_FDResPub=unknown"
) else (
    set "STATUS_FDResPub=notfound"
)
echo   "FDResPub": "!STATUS_FDResPub!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_FDResPub="

REM Проверка службы FontCache
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\FontCache" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_FontCache=boot"
    if "!START_VAL!"=="0x1" set "STATUS_FontCache=system"
    if "!START_VAL!"=="0x2" set "STATUS_FontCache=auto"
    if "!START_VAL!"=="0x3" set "STATUS_FontCache=manual"
    if "!START_VAL!"=="0x4" set "STATUS_FontCache=disabled"
    if not defined STATUS_FontCache set "STATUS_FontCache=unknown"
) else (
    set "STATUS_FontCache=notfound"
)
echo   "FontCache": "!STATUS_FontCache!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_FontCache="

REM Проверка службы FontCache3.0.0.0
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\FontCache3.0.0.0" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_FontCache3.0.0.0=boot"
    if "!START_VAL!"=="0x1" set "STATUS_FontCache3.0.0.0=system"
    if "!START_VAL!"=="0x2" set "STATUS_FontCache3.0.0.0=auto"
    if "!START_VAL!"=="0x3" set "STATUS_FontCache3.0.0.0=manual"
    if "!START_VAL!"=="0x4" set "STATUS_FontCache3.0.0.0=disabled"
    if not defined STATUS_FontCache3.0.0.0 set "STATUS_FontCache3.0.0.0=unknown"
) else (
    set "STATUS_FontCache3.0.0.0=notfound"
)
echo   "FontCache3.0.0.0": "!STATUS_FontCache3.0.0.0!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_FontCache3.0.0.0="

REM Проверка службы FrameServer
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\FrameServer" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_FrameServer=boot"
    if "!START_VAL!"=="0x1" set "STATUS_FrameServer=system"
    if "!START_VAL!"=="0x2" set "STATUS_FrameServer=auto"
    if "!START_VAL!"=="0x3" set "STATUS_FrameServer=manual"
    if "!START_VAL!"=="0x4" set "STATUS_FrameServer=disabled"
    if not defined STATUS_FrameServer set "STATUS_FrameServer=unknown"
) else (
    set "STATUS_FrameServer=notfound"
)
echo   "FrameServer": "!STATUS_FrameServer!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_FrameServer="

REM Проверка службы FrameServerMonitor
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\FrameServerMonitor" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_FrameServerMonitor=boot"
    if "!START_VAL!"=="0x1" set "STATUS_FrameServerMonitor=system"
    if "!START_VAL!"=="0x2" set "STATUS_FrameServerMonitor=auto"
    if "!START_VAL!"=="0x3" set "STATUS_FrameServerMonitor=manual"
    if "!START_VAL!"=="0x4" set "STATUS_FrameServerMonitor=disabled"
    if not defined STATUS_FrameServerMonitor set "STATUS_FrameServerMonitor=unknown"
) else (
    set "STATUS_FrameServerMonitor=notfound"
)
echo   "FrameServerMonitor": "!STATUS_FrameServerMonitor!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_FrameServerMonitor="

REM Проверка службы IKEEXT
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_IKEEXT=boot"
    if "!START_VAL!"=="0x1" set "STATUS_IKEEXT=system"
    if "!START_VAL!"=="0x2" set "STATUS_IKEEXT=auto"
    if "!START_VAL!"=="0x3" set "STATUS_IKEEXT=manual"
    if "!START_VAL!"=="0x4" set "STATUS_IKEEXT=disabled"
    if not defined STATUS_IKEEXT set "STATUS_IKEEXT=unknown"
) else (
    set "STATUS_IKEEXT=notfound"
)
echo   "IKEEXT": "!STATUS_IKEEXT!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_IKEEXT="

REM Проверка службы InstallService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_InstallService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_InstallService=system"
    if "!START_VAL!"=="0x2" set "STATUS_InstallService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_InstallService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_InstallService=disabled"
    if not defined STATUS_InstallService set "STATUS_InstallService=unknown"
) else (
    set "STATUS_InstallService=notfound"
)
echo   "InstallService": "!STATUS_InstallService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_InstallService="

REM Проверка службы LicenseManager
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\LicenseManager" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_LicenseManager=boot"
    if "!START_VAL!"=="0x1" set "STATUS_LicenseManager=system"
    if "!START_VAL!"=="0x2" set "STATUS_LicenseManager=auto"
    if "!START_VAL!"=="0x3" set "STATUS_LicenseManager=manual"
    if "!START_VAL!"=="0x4" set "STATUS_LicenseManager=disabled"
    if not defined STATUS_LicenseManager set "STATUS_LicenseManager=unknown"
) else (
    set "STATUS_LicenseManager=notfound"
)
echo   "LicenseManager": "!STATUS_LicenseManager!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_LicenseManager="

REM Проверка службы LxpSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\LxpSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_LxpSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_LxpSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_LxpSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_LxpSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_LxpSvc=disabled"
    if not defined STATUS_LxpSvc set "STATUS_LxpSvc=unknown"
) else (
    set "STATUS_LxpSvc=notfound"
)
echo   "LxpSvc": "!STATUS_LxpSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_LxpSvc="

REM Проверка службы McpManagementService
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\McpManagementService" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_McpManagementService=boot"
    if "!START_VAL!"=="0x1" set "STATUS_McpManagementService=system"
    if "!START_VAL!"=="0x2" set "STATUS_McpManagementService=auto"
    if "!START_VAL!"=="0x3" set "STATUS_McpManagementService=manual"
    if "!START_VAL!"=="0x4" set "STATUS_McpManagementService=disabled"
    if not defined STATUS_McpManagementService set "STATUS_McpManagementService=unknown"
) else (
    set "STATUS_McpManagementService=notfound"
)
echo   "McpManagementService": "!STATUS_McpManagementService!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_McpManagementService="

REM Проверка службы PerfHost
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\PerfHost" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_PerfHost=boot"
    if "!START_VAL!"=="0x1" set "STATUS_PerfHost=system"
    if "!START_VAL!"=="0x2" set "STATUS_PerfHost=auto"
    if "!START_VAL!"=="0x3" set "STATUS_PerfHost=manual"
    if "!START_VAL!"=="0x4" set "STATUS_PerfHost=disabled"
    if not defined STATUS_PerfHost set "STATUS_PerfHost=unknown"
) else (
    set "STATUS_PerfHost=notfound"
)
echo   "PerfHost": "!STATUS_PerfHost!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_PerfHost="

REM Проверка службы PimIndexMaintenanceSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_PimIndexMaintenanceSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_PimIndexMaintenanceSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_PimIndexMaintenanceSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_PimIndexMaintenanceSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_PimIndexMaintenanceSvc=disabled"
    if not defined STATUS_PimIndexMaintenanceSvc set "STATUS_PimIndexMaintenanceSvc=unknown"
) else (
    set "STATUS_PimIndexMaintenanceSvc=notfound"
)
echo   "PimIndexMaintenanceSvc": "!STATUS_PimIndexMaintenanceSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_PimIndexMaintenanceSvc="

REM Проверка службы ssh-agent
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\ssh-agent" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_ssh-agent=boot"
    if "!START_VAL!"=="0x1" set "STATUS_ssh-agent=system"
    if "!START_VAL!"=="0x2" set "STATUS_ssh-agent=auto"
    if "!START_VAL!"=="0x3" set "STATUS_ssh-agent=manual"
    if "!START_VAL!"=="0x4" set "STATUS_ssh-agent=disabled"
    if not defined STATUS_ssh-agent set "STATUS_ssh-agent=unknown"
) else (
    set "STATUS_ssh-agent=notfound"
)
echo   "ssh-agent": "!STATUS_ssh-agent!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_ssh-agent="

REM Проверка службы UdkUserSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\UdkUserSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_UdkUserSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_UdkUserSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_UdkUserSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_UdkUserSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_UdkUserSvc=disabled"
    if not defined STATUS_UdkUserSvc set "STATUS_UdkUserSvc=unknown"
) else (
    set "STATUS_UdkUserSvc=notfound"
)
echo   "UdkUserSvc": "!STATUS_UdkUserSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_UdkUserSvc="

REM Проверка службы uhssvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\uhssvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_uhssvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_uhssvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_uhssvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_uhssvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_uhssvc=disabled"
    if not defined STATUS_uhssvc set "STATUS_uhssvc=unknown"
) else (
    set "STATUS_uhssvc=notfound"
)
echo   "uhssvc": "!STATUS_uhssvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_uhssvc="

REM Проверка службы VerifierExt
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\VerifierExt" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_VerifierExt=boot"
    if "!START_VAL!"=="0x1" set "STATUS_VerifierExt=system"
    if "!START_VAL!"=="0x2" set "STATUS_VerifierExt=auto"
    if "!START_VAL!"=="0x3" set "STATUS_VerifierExt=manual"
    if "!START_VAL!"=="0x4" set "STATUS_VerifierExt=disabled"
    if not defined STATUS_VerifierExt set "STATUS_VerifierExt=unknown"
) else (
    set "STATUS_VerifierExt=notfound"
)
echo   "VerifierExt": "!STATUS_VerifierExt!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_VerifierExt="

REM Проверка службы WManSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WManSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WManSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WManSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_WManSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WManSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WManSvc=disabled"
    if not defined STATUS_WManSvc set "STATUS_WManSvc=unknown"
) else (
    set "STATUS_WManSvc=notfound"
)
echo   "WManSvc": "!STATUS_WManSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WManSvc="

REM Проверка службы wmiApSrv
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\wmiApSrv" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_wmiApSrv=boot"
    if "!START_VAL!"=="0x1" set "STATUS_wmiApSrv=system"
    if "!START_VAL!"=="0x2" set "STATUS_wmiApSrv=auto"
    if "!START_VAL!"=="0x3" set "STATUS_wmiApSrv=manual"
    if "!START_VAL!"=="0x4" set "STATUS_wmiApSrv=disabled"
    if not defined STATUS_wmiApSrv set "STATUS_wmiApSrv=unknown"
) else (
    set "STATUS_wmiApSrv=notfound"
)
echo   "wmiApSrv": "!STATUS_wmiApSrv!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_wmiApSrv="

REM Проверка службы wlpasvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\wlpasvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_wlpasvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_wlpasvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_wlpasvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_wlpasvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_wlpasvc=disabled"
    if not defined STATUS_wlpasvc set "STATUS_wlpasvc=unknown"
) else (
    set "STATUS_wlpasvc=notfound"
)
echo   "wlpasvc": "!STATUS_wlpasvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_wlpasvc="

REM Проверка службы AppVClient
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\AppVClient" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_AppVClient=boot"
    if "!START_VAL!"=="0x1" set "STATUS_AppVClient=system"
    if "!START_VAL!"=="0x2" set "STATUS_AppVClient=auto"
    if "!START_VAL!"=="0x3" set "STATUS_AppVClient=manual"
    if "!START_VAL!"=="0x4" set "STATUS_AppVClient=disabled"
    if not defined STATUS_AppVClient set "STATUS_AppVClient=unknown"
) else (
    set "STATUS_AppVClient=notfound"
)
echo   "AppVClient": "!STATUS_AppVClient!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_AppVClient="

REM Проверка службы AppIDSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\AppIDSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_AppIDSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_AppIDSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_AppIDSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_AppIDSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_AppIDSvc=disabled"
    if not defined STATUS_AppIDSvc set "STATUS_AppIDSvc=unknown"
) else (
    set "STATUS_AppIDSvc=notfound"
)
echo   "AppIDSvc": "!STATUS_AppIDSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_AppIDSvc="

REM Проверка службы ClipSVC
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\ClipSVC" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_ClipSVC=boot"
    if "!START_VAL!"=="0x1" set "STATUS_ClipSVC=system"
    if "!START_VAL!"=="0x2" set "STATUS_ClipSVC=auto"
    if "!START_VAL!"=="0x3" set "STATUS_ClipSVC=manual"
    if "!START_VAL!"=="0x4" set "STATUS_ClipSVC=disabled"
    if not defined STATUS_ClipSVC set "STATUS_ClipSVC=unknown"
) else (
    set "STATUS_ClipSVC=notfound"
)
echo   "ClipSVC": "!STATUS_ClipSVC!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_ClipSVC="

REM Проверка службы CloudBackupRestoreSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\CloudBackupRestoreSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_CloudBackupRestoreSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_CloudBackupRestoreSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_CloudBackupRestoreSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_CloudBackupRestoreSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_CloudBackupRestoreSvc=disabled"
    if not defined STATUS_CloudBackupRestoreSvc set "STATUS_CloudBackupRestoreSvc=unknown"
) else (
    set "STATUS_CloudBackupRestoreSvc=notfound"
)
echo   "CloudBackupRestoreSvc": "!STATUS_CloudBackupRestoreSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_CloudBackupRestoreSvc="

REM Проверка службы cloudidsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\cloudidsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_cloudidsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_cloudidsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_cloudidsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_cloudidsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_cloudidsvc=disabled"
    if not defined STATUS_cloudidsvc set "STATUS_cloudidsvc=unknown"
) else (
    set "STATUS_cloudidsvc=notfound"
)
echo   "cloudidsvc": "!STATUS_cloudidsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_cloudidsvc="

REM Проверка службы cnghwassist
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\cnghwassist" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_cnghwassist=boot"
    if "!START_VAL!"=="0x1" set "STATUS_cnghwassist=system"
    if "!START_VAL!"=="0x2" set "STATUS_cnghwassist=auto"
    if "!START_VAL!"=="0x3" set "STATUS_cnghwassist=manual"
    if "!START_VAL!"=="0x4" set "STATUS_cnghwassist=disabled"
    if not defined STATUS_cnghwassist set "STATUS_cnghwassist=unknown"
) else (
    set "STATUS_cnghwassist=notfound"
)
echo   "cnghwassist": "!STATUS_cnghwassist!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_cnghwassist="

REM Проверка службы dcpsvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\dcpsvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_dcpsvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_dcpsvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_dcpsvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_dcpsvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_dcpsvc=disabled"
    if not defined STATUS_dcpsvc set "STATUS_dcpsvc=unknown"
) else (
    set "STATUS_dcpsvc=notfound"
)
echo   "dcpsvc": "!STATUS_dcpsvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_dcpsvc="

REM Проверка службы EFS
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\EFS" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_EFS=boot"
    if "!START_VAL!"=="0x1" set "STATUS_EFS=system"
    if "!START_VAL!"=="0x2" set "STATUS_EFS=auto"
    if "!START_VAL!"=="0x3" set "STATUS_EFS=manual"
    if "!START_VAL!"=="0x4" set "STATUS_EFS=disabled"
    if not defined STATUS_EFS set "STATUS_EFS=unknown"
) else (
    set "STATUS_EFS=notfound"
)
echo   "EFS": "!STATUS_EFS!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_EFS="

REM Проверка службы KeyIso
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\KeyIso" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_KeyIso=boot"
    if "!START_VAL!"=="0x1" set "STATUS_KeyIso=system"
    if "!START_VAL!"=="0x2" set "STATUS_KeyIso=auto"
    if "!START_VAL!"=="0x3" set "STATUS_KeyIso=manual"
    if "!START_VAL!"=="0x4" set "STATUS_KeyIso=disabled"
    if not defined STATUS_KeyIso set "STATUS_KeyIso=unknown"
) else (
    set "STATUS_KeyIso=notfound"
)
echo   "KeyIso": "!STATUS_KeyIso!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_KeyIso="

REM Проверка службы KtmRm
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\KtmRm" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_KtmRm=boot"
    if "!START_VAL!"=="0x1" set "STATUS_KtmRm=system"
    if "!START_VAL!"=="0x2" set "STATUS_KtmRm=auto"
    if "!START_VAL!"=="0x3" set "STATUS_KtmRm=manual"
    if "!START_VAL!"=="0x4" set "STATUS_KtmRm=disabled"
    if not defined STATUS_KtmRm set "STATUS_KtmRm=unknown"
) else (
    set "STATUS_KtmRm=notfound"
)
echo   "KtmRm": "!STATUS_KtmRm!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_KtmRm="

REM Проверка службы MSDTC
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\MSDTC" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_MSDTC=boot"
    if "!START_VAL!"=="0x1" set "STATUS_MSDTC=system"
    if "!START_VAL!"=="0x2" set "STATUS_MSDTC=auto"
    if "!START_VAL!"=="0x3" set "STATUS_MSDTC=manual"
    if "!START_VAL!"=="0x4" set "STATUS_MSDTC=disabled"
    if not defined STATUS_MSDTC set "STATUS_MSDTC=unknown"
) else (
    set "STATUS_MSDTC=notfound"
)
echo   "MSDTC": "!STATUS_MSDTC!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_MSDTC="

REM Проверка службы NgcCtnrSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NgcCtnrSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_NgcCtnrSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_NgcCtnrSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_NgcCtnrSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_NgcCtnrSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_NgcCtnrSvc=disabled"
    if not defined STATUS_NgcCtnrSvc set "STATUS_NgcCtnrSvc=unknown"
) else (
    set "STATUS_NgcCtnrSvc=notfound"
)
echo   "NgcCtnrSvc": "!STATUS_NgcCtnrSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_NgcCtnrSvc="

REM Проверка службы NgcSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NgcSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_NgcSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_NgcSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_NgcSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_NgcSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_NgcSvc=disabled"
    if not defined STATUS_NgcSvc set "STATUS_NgcSvc=unknown"
) else (
    set "STATUS_NgcSvc=notfound"
)
echo   "NgcSvc": "!STATUS_NgcSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_NgcSvc="

REM Проверка службы PeerDistSvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\PeerDistSvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_PeerDistSvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_PeerDistSvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_PeerDistSvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_PeerDistSvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_PeerDistSvc=disabled"
    if not defined STATUS_PeerDistSvc set "STATUS_PeerDistSvc=unknown"
) else (
    set "STATUS_PeerDistSvc=notfound"
)
echo   "PeerDistSvc": "!STATUS_PeerDistSvc!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_PeerDistSvc="

REM Проверка службы UCPD
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\UCPD" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_UCPD=boot"
    if "!START_VAL!"=="0x1" set "STATUS_UCPD=system"
    if "!START_VAL!"=="0x2" set "STATUS_UCPD=auto"
    if "!START_VAL!"=="0x3" set "STATUS_UCPD=manual"
    if "!START_VAL!"=="0x4" set "STATUS_UCPD=disabled"
    if not defined STATUS_UCPD set "STATUS_UCPD=unknown"
) else (
    set "STATUS_UCPD=notfound"
)
echo   "UCPD": "!STATUS_UCPD!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_UCPD="

REM Проверка службы SharedAccess
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_SharedAccess=boot"
    if "!START_VAL!"=="0x1" set "STATUS_SharedAccess=system"
    if "!START_VAL!"=="0x2" set "STATUS_SharedAccess=auto"
    if "!START_VAL!"=="0x3" set "STATUS_SharedAccess=manual"
    if "!START_VAL!"=="0x4" set "STATUS_SharedAccess=disabled"
    if not defined STATUS_SharedAccess set "STATUS_SharedAccess=unknown"
) else (
    set "STATUS_SharedAccess=notfound"
)
echo   "SharedAccess": "!STATUS_SharedAccess!", >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_SharedAccess="

REM Проверка службы WinHttpAutoProxySvc
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" /v Start 2^>nul ^| findstr /i "Start"') do (
    set "START_VAL=%%a"
)
if defined START_VAL (
    if "!START_VAL!"=="0x0" set "STATUS_WinHttpAutoProxySvc=boot"
    if "!START_VAL!"=="0x1" set "STATUS_WinHttpAutoProxySvc=system"
    if "!START_VAL!"=="0x2" set "STATUS_WinHttpAutoProxySvc=auto"
    if "!START_VAL!"=="0x3" set "STATUS_WinHttpAutoProxySvc=manual"
    if "!START_VAL!"=="0x4" set "STATUS_WinHttpAutoProxySvc=disabled"
    if not defined STATUS_WinHttpAutoProxySvc set "STATUS_WinHttpAutoProxySvc=unknown"
) else (
    set "STATUS_WinHttpAutoProxySvc=notfound"
)
echo   "WinHttpAutoProxySvc": "!STATUS_WinHttpAutoProxySvc!" >> "%~dp0services_status.json"
set "START_VAL="
set "STATUS_WinHttpAutoProxySvc="

echo } >> "%~dp0services_status.json"
echo [OK] Статусы записаны в services_status.json
