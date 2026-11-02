@echo off
title Удаление BitLocker
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
echo ВНИМАНИЕ: расшифровка диска. Данные могут быть потеряны!
echo manage-bde -off %SystemDrive%
echo [+] Расшифровка запущена.
