@echo off
chcp 65001 > nul
set "PS=powershell.exe -ExecutionPolicy Bypass -NoProfile -Command"
%PS% "Get-Package -Name \"*Office*\" | Uninstall-Package"
if %errorlevel% neq 0 (
    echo [ERROR] Команда не выполнена: Get-Package -Name "*Office*" | Uninstall-Package...
 /b %errorlevel%
)
echo.
echo ✅ Все команды выполнены