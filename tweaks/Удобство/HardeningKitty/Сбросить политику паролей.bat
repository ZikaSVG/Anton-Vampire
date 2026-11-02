@echo off
title Сброс политики паролей
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
net accounts /minpwlen:0
net accounts /maxpwage:unlimited
net accounts /minpwage:0
net accounts /uniquepw:0
echo [+] Политика паролей сброшена.
