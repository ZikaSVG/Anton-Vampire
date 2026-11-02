@echo off
chcp 65001 >nul
echo Полный сброс кэша Windows Update...
net stop wuauserv >nul 2>&1
net stop UsoSvc   >nul 2>&1
net stop bits     >nul 2>&1
rd /s /q "%windir%\SoftwareDistribution" >nul 2>&1
md "%windir%\SoftwareDistribution"        >nul 2>&1
net start wuauserv >nul 2>&1
net start UsoSvc   >nul 2>&1
net start bits     >nul 2>&1
echo Готово.
