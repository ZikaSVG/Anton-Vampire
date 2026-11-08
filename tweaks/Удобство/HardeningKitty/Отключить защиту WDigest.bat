@echo off
title Включение хранения WDigest
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /v UseLogonCredential /t REG_DWORD /d 1 /f
echo [+] WDigest снова хранит пароли. Требуется перезагрузка.
