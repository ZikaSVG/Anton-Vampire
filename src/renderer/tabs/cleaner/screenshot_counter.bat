@echo off
chcp 65001 >nul
echo Сброс счётчика скриншотов...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ScreenshotIndex" /t REG_DWORD /d 1 /f >nul
echo Готово.
