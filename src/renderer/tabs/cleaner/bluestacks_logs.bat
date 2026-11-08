@echo off
chcp 65001 >nul
echo Очистка логов BlueStacks...
del /f /s /q "C:\ProgramData\BlueStacks\Logs\*.*"                >nul 2>&1
del /f /s /q "C:\ProgramData\BlueStacks\Engine\Android\Logs\*.*" >nul 2>&1
echo Готово.
