@echo off
title Разрешить входящие
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
netsh advfirewall set allprofiles firewallpolicy allowinbound,allowoutbound
echo [+] Входящие разрешены.
