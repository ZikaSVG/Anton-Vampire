@echo off
chcp 65001 >nul
echo Удаление системных логов...
del /f /s /q "%windir%\*.log"          >nul 2>&1
del /f /s /q "%windir%\*.old"          >nul 2>&1
del /f /s /q "%windir%\*.bak"          >nul 2>&1
del /f /s /q "%windir%\Panther\*.log"  >nul 2>&1
echo Готово.
