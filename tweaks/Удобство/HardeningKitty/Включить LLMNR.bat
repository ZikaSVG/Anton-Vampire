@echo off
title Включение LLMNR
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v EnableMulticast /t REG_DWORD /d 1 /f
echo [+] LLMNR включён.
