@echo off
title Отключение аудита
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
auditpol /clear /y
echo [+] Аудит отключён.
