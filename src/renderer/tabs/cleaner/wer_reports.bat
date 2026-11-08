@echo off
chcp 65001 >nul
echo Удаление отчётов Windows Error Reporting...
del /f /s /q "%ProgramData%\Microsoft\Windows\WER\*.*"  >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\Windows\WER\*.*" >nul 2>&1
echo Готово.
