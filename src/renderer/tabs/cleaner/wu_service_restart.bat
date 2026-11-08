@echo off
chcp 65001 >nul
echo Перезапуск служб обновлений...
net stop wuauserv >nul 2>&1
net stop UsoSvc   >nul 2>&1
net stop bits     >nul 2>&1
net start bits     >nul 2>&1
net start UsoSvc   >nul 2>&1
net start wuauserv >nul 2>&1
echo Готово.
