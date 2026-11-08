@echo off
chcp 65001 >nul
title Сброс Windows Update
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
net stop wuauserv /y >nul 2>&1
net stop bits     /y >nul 2>&1
net stop cryptSvc /y >nul 2>&1

del /s /q /f "%systemroot%\SoftwareDistribution\*" >nul 2>&1
rmdir /s /q  "%systemroot%\system32\catroot2"      >nul 2>&1

net start cryptSvc >nul 2>&1
net start bits     >nul 2>&1
net start wuauserv >nul 2>&1

echo Готово. Windows Update сброшен.