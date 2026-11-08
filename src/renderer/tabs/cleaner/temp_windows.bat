@echo off
chcp 65001 >nul
echo Очистка C:\Windows\Temp...
takeown /f "%windir%\Temp" /r /d y  >nul 2>&1
del /f /s /q "%windir%\Temp\*.*"    >nul 2>&1
echo Готово.
