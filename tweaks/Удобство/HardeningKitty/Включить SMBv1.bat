@echo off
title Включение SMBv1
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
powershell -NoProfile -Command "Set-SmbServerConfiguration -EnableSMB1Protocol $true -Force"
powershell -NoProfile -Command "Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart -ErrorAction SilentlyContinue"
echo [+] SMBv1 включён. Требуется перезагрузка.
