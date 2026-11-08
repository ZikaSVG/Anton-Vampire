@echo off
chcp 65001 >nul
title CHKDSK C:
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
echo [!] ВНИМАНИЕ: проверка может занять 10-60 минут.
echo     Если диск занят — CHKDSK предложит выполнить проверку после перезагрузки.
echo.
echo y | chkdsk C: /f /x
echo Готово. Если была запланирована проверка при загрузке — перезагрузите ПК.