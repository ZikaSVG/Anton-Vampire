@echo off
chcp 65001 >nul
echo Удаление папки PerfLogs...
takeown /f "%SystemDrive%\PerfLogs" /r /d y >nul 2>&1
icacls "%SystemDrive%\PerfLogs" /grant "%UserName%":F /t /c >nul 2>&1
rd /q /s "%SystemDrive%\PerfLogs" >nul 2>&1
echo Готово.