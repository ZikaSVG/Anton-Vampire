@echo off
setlocal EnableExtensions
chcp 65001 >nul
title Бэкап реестра служб
net session >nul 2>&1 || (
    echo [!] Запустите от имени администратора.
    pause
    exit /b 1
)

set "BACKUP_FILE=%~dp0Services_Backup.reg"

echo [!] Создание бэкапа реестра служб...
if exist "%BACKUP_FILE%" (
    del /f /q "%BACKUP_FILE%" >nul 2>&1
)

reg export "HKLM\SYSTEM\CurrentControlSet\Services" "%BACKUP_FILE%" /y >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Бэкап успешно создан: %BACKUP_FILE%
) else (
    echo [ERROR] Ошибка создания бэкапа.
    pause
    exit /b 1
)