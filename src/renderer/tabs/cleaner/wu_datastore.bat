@echo off
chcp 65001 >nul
echo Сброс DataStore Windows Update...
net stop wuauserv >nul 2>&1
del /f /s /q "%windir%\SoftwareDistribution\DataStore\*.*" >nul 2>&1
net start wuauserv >nul 2>&1
echo Готово.
