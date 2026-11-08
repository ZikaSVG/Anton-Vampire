@echo off
chcp 65001 >nul
echo Сброс catroot2 (база подписей обновлений)...
net stop cryptsvc >nul 2>&1
net stop wuauserv >nul 2>&1
rd /s /q "%windir%\System32\catroot2" >nul 2>&1
md "%windir%\System32\catroot2"        >nul 2>&1
net start cryptsvc >nul 2>&1
net start wuauserv >nul 2>&1
echo Готово.
