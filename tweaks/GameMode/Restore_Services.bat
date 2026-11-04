@echo off
chcp 65001 >nul
echo [!] Восстановление служб из бэкапа...
if exist "%~dp0Services_Backup.reg" (
    reg import "%~dp0Services_Backup.reg" >nul 2>&1
    echo [OK] Службы восстановлены из бэкапа.
) else (
    echo [ERROR] Файл бэкапа Services_Backup.reg не найден!
)
pause
