@echo off
chcp 65001 >nul
echo Очистка кэша иконок и эскизов...
taskkill /f /im explorer.exe >nul 2>&1
del /f /s /q /a "%LocalAppData%\IconCache.db" >nul 2>&1
del /f /s /q /a "%LocalAppData%\Microsoft\Windows\Explorer\iconcache_*.db" >nul 2>&1
del /f /s /q /a "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
timeout /t 1 /nobreak >nul
start "" explorer.exe
echo Готово.
