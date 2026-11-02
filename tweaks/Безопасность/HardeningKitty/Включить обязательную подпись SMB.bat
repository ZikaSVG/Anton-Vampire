@echo off
title SMB-подпись
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
powershell -NoProfile -Command "Set-SmbServerConfiguration -RequireSecuritySignature $true -Force"
powershell -NoProfile -Command "Set-SmbClientConfiguration -RequireSecuritySignature $true -Force"
echo [+] Подпись SMB включена.
