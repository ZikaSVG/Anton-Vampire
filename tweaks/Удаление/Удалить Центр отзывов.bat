@echo off
chcp 65001 > nul
set "PS=powershell.exe -ExecutionPolicy Bypass -NoProfile -Command"
%PS% "get-appxpackage *feedback* | remove-appxpackage"
if %errorlevel% neq 0 (
    echo [ERROR] Команда не выполнена: get-appxpackage *feedback* | remove-appxpackage...
 /b %errorlevel%
)
echo.
echo ✅ Все команды выполнены