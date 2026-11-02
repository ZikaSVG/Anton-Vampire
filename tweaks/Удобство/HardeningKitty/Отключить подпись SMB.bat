@echo off
title Отключение SMB-подписи
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
powershell -NoProfile -Command "Set-SmbServerConfiguration -RequireSecuritySignature $false -Force"
powershell -NoProfile -Command "Set-SmbClientConfiguration -RequireSecuritySignature $false -Force"
echo [+] SMB-подпись отключена.
