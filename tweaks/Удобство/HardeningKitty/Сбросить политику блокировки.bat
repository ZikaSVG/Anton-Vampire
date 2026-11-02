@echo off
title Сброс блокировки
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
net accounts /lockoutthreshold:0
net accounts /lockoutduration:0
net accounts /lockoutwindow:0
echo [+] Блокировка сброшена.
