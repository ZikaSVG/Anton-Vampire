@echo off
title Гостевая SMB
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v AllowInsecureGuestAuth /t REG_DWORD /d 1 /f
echo [+] Гостевая SMB разрешена.
