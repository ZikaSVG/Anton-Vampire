@echo off
title Отключение LSA Protection
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RunAsPPL /t REG_DWORD /d 0 /f
echo [+] LSA Protection отключён. Требуется перезагрузка.
