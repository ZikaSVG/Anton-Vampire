@echo off
title SMBv1
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
powershell -NoProfile -Command "Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force"
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart -ErrorAction SilentlyContinue"
echo [+] SMBv1 отключён.
