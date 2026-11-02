@echo off
chcp 65001 >nul
echo Очистка всех Temp-папок...
del /f /s /q "%TEMP%\*.*"              >nul 2>&1
del /f /s /q "%LocalAppData%\Temp\*.*" >nul 2>&1
takeown /f "%windir%\Temp" /r /d y     >nul 2>&1
del /f /s /q "%windir%\Temp\*.*"       >nul 2>&1
echo Готово.
