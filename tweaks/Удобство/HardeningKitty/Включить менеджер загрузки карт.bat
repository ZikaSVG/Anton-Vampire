@echo off
title Менеджер загрузки карт
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config MapsBroker start= auto >nul 2>&1
sc start MapsBroker >nul 2>&1
echo [+] Менеджер загрузки карт включён.
