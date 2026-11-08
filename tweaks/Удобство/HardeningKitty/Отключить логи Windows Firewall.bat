@echo off
title Логи брандмауэра
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
netsh advfirewall set allprofiles logging droppedconnections disable
netsh advfirewall set allprofiles logging allowedconnections disable
echo [+] Логи отключены.
