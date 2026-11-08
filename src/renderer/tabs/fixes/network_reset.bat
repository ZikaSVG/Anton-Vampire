@echo off
chcp 65001 >nul
title Сброс TCP/IP
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
echo [!] ВНИМАНИЕ: соединение будет разорвано на 5-15 секунд.

ipconfig /flushdns >nul
netsh winsock reset >nul
netsh int ip reset   >nul
ipconfig /release    >nul
ipconfig /renew      >nul

echo Готово. Сеть полностью сброшена.
echo Если интернет не вернулся — перезагрузите ПК.