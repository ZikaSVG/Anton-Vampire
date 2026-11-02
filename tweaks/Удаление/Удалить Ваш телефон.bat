@echo off
chcp 65001 > nul
set "PS=powershell.exe -ExecutionPolicy Bypass -NoProfile -Command"
%PS% "Get-AppxPackage *windowsphone* | Remove-AppxPackage"
if %errorlevel% neq 0 (
    echo [ERROR] Команда не выполнена: Get-AppxPackage *windowsphone* | Remove-AppxPackag...
 /b %errorlevel%
)
%PS% "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"
if %errorlevel% neq 0 (
    echo [ERROR] Команда не выполнена: Get-AppxPackage *Microsoft.YourPhone* | Remove-App...
 /b %errorlevel%
)
echo.
echo ✅ Все команды выполнены