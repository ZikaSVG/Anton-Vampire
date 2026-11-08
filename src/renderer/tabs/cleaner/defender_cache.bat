@echo off
chcp 65001 >nul
echo Очистка кэша Защитника Windows...
del /f /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\History\Results\Quick\*.*"    >nul 2>&1
del /f /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\History\Results\Resource\*.*" >nul 2>&1
del /f /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\History\CacheManager\*.*"     >nul 2>&1
echo Готово.
