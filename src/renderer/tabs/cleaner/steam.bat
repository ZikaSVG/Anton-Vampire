@echo off
chcp 65001 >nul
echo Очистка кэша Steam...
taskkill /f /im steam.exe /t           >nul 2>&1
taskkill /f /im steamwebhelper.exe /t  >nul 2>&1
del /f /s /q "%LocalAppData%\Steam\htmlcache\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Steam\appcache\*.*"  >nul 2>&1
del /f /s /q "%LocalAppData%\Steam\logs\*.*"      >nul 2>&1
echo Готово.
