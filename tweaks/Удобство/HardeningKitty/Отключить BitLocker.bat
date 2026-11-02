@echo off
title Отключение BitLocker
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
echo manage-bde -off %SystemDrive%
echo [+] BitLocker отключён.
