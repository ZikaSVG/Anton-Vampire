@echo off
chcp 65001 >nul
title Пароль и PowerShell
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
net accounts /maxpwage:unlimited >nul 2>&1
powershell -NoProfile -Command "Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force" >nul 2>&1
echo Готово. Смена пароля отключена, скрипты разрешены.