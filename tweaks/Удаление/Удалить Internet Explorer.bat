@echo off
chcp 65001 > nul
set "PS=powershell.exe -ExecutionPolicy Bypass -NoProfile -Command"
%PS% "Disable-WindowsOptionalFeature -Online -NoRestart -FeatureName \"Internet-Explorer-Optional-amd64\""
if %errorlevel% neq 0 (
    echo [ERROR] Команда не выполнена: Disable-WindowsOptionalFeature -Online -NoRestart ...
 /b %errorlevel%
)
%PS% "get-appxpackage *Internet-Explorer* | remove-appxpackage"
if %errorlevel% neq 0 (
    echo [ERROR] Команда не выполнена: get-appxpackage *Internet-Explorer* | remove-appxp...
 /b %errorlevel%
)
echo.
echo ✅ Все команды выполнены