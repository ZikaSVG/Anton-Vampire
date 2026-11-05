@echo off
setlocal EnableExtensions
chcp 65001 >nul
title Восстановление служб из бэкапа
net session >nul 2>&1 || (
    echo [!] Запустите от имени администратора.
    pause
    exit /b 1
)

set "BACKUP_FILE=%~dp0Services_Backup.reg"

if not exist "%BACKUP_FILE%" (
    echo [ERROR] Файл бэкапа не найден: %BACKUP_FILE%
    echo [!] Сначала создайте бэкап через "Создать бэкап служб".
    pause
    exit /b 1
)

echo [!] Восстановление служб из бэкапа...
reg import "%BACKUP_FILE%" >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Службы успешно восстановлены из бэкапа.
    echo [!] Рекомендуется перезагрузка ПК.
) else (
    echo [ERROR] Ошибка импорта бэкапа.
)
pause