@echo off
chcp 65001 >nul
title DISM /RestoreHealth
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
echo Восстановление образа Windows (может занять 10-30 минут)...
DISM /Online /Cleanup-Image /RestoreHealth
echo Готово.