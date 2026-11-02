@echo off
chcp 65001 >nul
title SFC /scannow
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора. Запустите от имени администратора.
    exit /b 1
)
echo Проверка целостности системных файлов (10-30 минут)...
sfc /scannow
echo Готово.