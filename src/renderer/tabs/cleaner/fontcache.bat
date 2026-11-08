@echo off
chcp 65001 >nul
echo Очистка кэша шрифтов...
net stop FontCache >nul 2>&1
del /f /s /q "%LocalAppData%\FontCache\*.*" >nul 2>&1
del /f /s /q "%windir%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.*" >nul 2>&1
net start FontCache >nul 2>&1
echo Готово.
