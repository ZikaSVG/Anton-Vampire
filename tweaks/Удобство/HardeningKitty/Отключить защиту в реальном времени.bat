@echo off
title Отключение RTP Defender
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
powershell -NoProfile -Command "Set-MpPreference -DisableRealtimeMonitoring $true"
echo [+] RTP отключён.
