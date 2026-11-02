@echo off
title Полный аудит
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
auditpol /set /category:* /success:enable /failure:enable
echo [+] Полный аудит включён.
