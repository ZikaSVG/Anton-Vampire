@echo off
title Включение NetBIOS
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
powershell -NoProfile -Command "Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled -eq $true} | ForEach-Object {$_.SetTcpipNetbios(0)}"
echo [+] NetBIOS включён.
