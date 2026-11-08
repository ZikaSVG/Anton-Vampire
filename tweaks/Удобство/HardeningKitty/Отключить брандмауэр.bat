@echo off
title Отключение брандмауэра
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
netsh advfirewall set allprofiles state off
echo [+] Брандмауэр отключён.
