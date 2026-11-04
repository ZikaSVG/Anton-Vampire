@echo off
chcp 65001 >nul
echo [!] Создание бэкапа реестра служб...
reg export "HKLM\SYSTEM\CurrentControlSet\Services" "%~dp0Services_Backup.reg" /y >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Бэкап успешно создан: Services_Backup.reg
) else (
    echo [ERROR] Ошибка создания бэкапа. Запустите от имени администратора.
)
pause
