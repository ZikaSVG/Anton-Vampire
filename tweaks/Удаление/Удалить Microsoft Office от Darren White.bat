@echo off
chcp 65001 > nul
echo 🔧 Запуск PowerShell скрипта: Удалить Microsoft Office от Darren White.ps1
echo.
:: Проверка наличия PowerShell
where powershell.exe > nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] PowerShell не найден!
 /b 1
)
:: Запуск PowerShell скрипта
powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%~dp0Darren White.ps1" %*
if %errorlevel% equ 0 (
    echo ✅ Скрипт Удалить Microsoft Office от Darren White.ps1 выполнен успешно
) else (
    echo [ERROR] Ошибка при выполнении Удалить Microsoft Office от Darren White.ps1
    echo Код ошибки: %errorlevel%
)
echo.