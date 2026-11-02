@echo off
chcp 65001 >nul
echo Удаление скачанных обновлений...
net stop wuauserv >nul 2>&1
del /f /s /q "%windir%\SoftwareDistribution\Download\*.*" >nul 2>&1
net start wuauserv >nul 2>&1
echo Готово.
