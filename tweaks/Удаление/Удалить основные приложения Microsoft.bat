@echo off
chcp 65001 > nul
echo 🔧 Запуск PowerShell скрипта: Microsoft Base UWP.ps1
echo.
:: Проверка наличия PowerShell
where powershell.exe > nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] PowerShell не найден!
 /b 1
)
:: Запуск PowerShell скрипта
powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%~dp0Microsoft Base UWP.ps1" %*
if %errorlevel% equ 0 (
    echo ✅ Скрипт Microsoft Base UWP.ps1 выполнен успешно
) else (
    echo [ERROR] Ошибка при выполнении Microsoft Base UWP.ps1
    echo Код ошибки: %errorlevel%
)
echo.