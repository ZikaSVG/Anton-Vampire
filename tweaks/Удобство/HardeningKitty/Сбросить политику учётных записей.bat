@echo off
title Сброс политики учётных записей
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
net accounts /minpwlen:0
net accounts /maxpwage:unlimited
net accounts /minpwage:0
net accounts /uniquepw:0
net accounts /lockoutthreshold:0
echo [+] Политика учётных записей сброшена.
