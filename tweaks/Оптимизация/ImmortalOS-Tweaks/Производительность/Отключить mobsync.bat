@echo off
chcp 65001 >nul 2>&1

net session >nul 2>&1
if %errorLevel% neq 0 exit /b 1

taskkill /f /im mobsync.exe >nul 2>&1
ren "%WinDir%\System32\mobsync.exe" "mobsync.old" >nul 2>&1

exit /b 0
