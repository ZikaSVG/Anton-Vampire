@echo off
title Отключение UAC
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
echo [+] UAC отключён. Требуется перезагрузка.
