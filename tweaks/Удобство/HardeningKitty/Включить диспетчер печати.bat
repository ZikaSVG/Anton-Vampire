@echo off
title Диспетчер печати
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config Spooler start= auto
sc start Spooler >nul 2>&1
echo [+] Диспетчер печати включён.
