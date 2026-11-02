@echo off
chcp 65001 >nul
echo Удаление папки inetpub...
takeown /f "%SystemDrive%\inetpub" /r /d y >nul 2>&1
icacls "%SystemDrive%\inetpub" /grant "%UserName%":F /t /c >nul 2>&1
rd /q /s "%SystemDrive%\inetpub" >nul 2>&1
echo Готово.