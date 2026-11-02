@echo off
chcp 65001 >nul
echo Очистка Temp пользователя...
del /f /s /q "%TEMP%\*.*"              >nul 2>&1
del /f /s /q "%LocalAppData%\Temp\*.*" >nul 2>&1
echo Готово.
