@echo off
chcp 65001 >nul
title Очистка логов и Temp
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
echo Очистка журналов событий Windows...
for /F "tokens=*" %%L in ('wevtutil.exe el') DO wevtutil.exe cl "%%L" >nul 2>&1

echo Очистка Temp...
del /s /f /q "%temp%\*" >nul 2>&1
del /s /f /q "%systemroot%\temp\*" >nul 2>&1

echo Готово. Логи и Temp очищены.