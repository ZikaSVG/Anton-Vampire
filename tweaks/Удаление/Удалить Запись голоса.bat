@echo off
chcp 65001 > nul
set "PS=powershell.exe -ExecutionPolicy Bypass -NoProfile -Command"
%PS% "Get-AppxPackage *soundrecorder* | Remove-AppxPackage"
if %errorlevel% neq 0 (
    echo [ERROR] Команда не выполнена: Get-AppxPackage *soundrecorder* | Remove-AppxPacka...
 /b %errorlevel%
)
echo.
echo ✅ Все команды выполнены