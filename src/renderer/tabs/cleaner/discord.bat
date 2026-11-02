@echo off
chcp 65001 >nul
echo Очистка кэша Discord...
taskkill /f /im discord.exe /t >nul 2>&1
del /f /s /q "%AppData%\discord\Cache\*.*"      >nul 2>&1
del /f /s /q "%AppData%\discord\Code Cache\*.*" >nul 2>&1
del /f /s /q "%AppData%\discord\GPUCache\*.*"   >nul 2>&1
echo Готово.
