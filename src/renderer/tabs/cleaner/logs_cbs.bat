@echo off
chcp 65001 >nul
echo Очистка логов CBS...
del /f /s /q "%windir%\Logs\CBS\*.*"              >nul 2>&1
del /f /s /q "%windir%\Logs\CBS\CbsPersist_*.log" >nul 2>&1
del /f /s /q "%windir%\Logs\DISM\*.*"             >nul 2>&1
del /f /s /q "%windir%\Logs\MoSetup\*.*"          >nul 2>&1
echo Готово.
