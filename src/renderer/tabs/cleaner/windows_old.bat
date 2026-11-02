@echo off
chcp 65001 >nul
echo Удаление папки Windows.old...
takeown /f "%SystemDrive%\Windows.old" /r /d y >nul 2>&1
icacls "%SystemDrive%\Windows.old" /grant "%UserName%":F /t /c >nul 2>&1
rd /q /s "%SystemDrive%\Windows.old" >nul 2>&1
echo Готово.