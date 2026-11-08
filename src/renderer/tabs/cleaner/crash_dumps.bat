@echo off
chcp 65001 >nul
echo Удаление CrashDumps приложений...
del /f /s /q "%LocalAppData%\CrashDumps\*.*" >nul 2>&1
rd /s /q "%LocalAppData%\CrashDumps"         >nul 2>&1
echo Готово.
