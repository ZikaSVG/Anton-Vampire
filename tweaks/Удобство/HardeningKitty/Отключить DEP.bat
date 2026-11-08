@echo off
title Отключение DEP
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
bcdedit /set nx AlwaysOff
echo [+] DEP отключён. Требуется перезагрузка.
