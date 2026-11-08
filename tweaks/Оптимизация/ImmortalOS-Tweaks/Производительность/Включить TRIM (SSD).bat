@echo off
chcp 65001 >nul 2>&1

net session >nul 2>&1
if %errorLevel% neq 0 exit /b 1

fsutil behavior set disabledeletenotify 0 >nul 2>&1

exit /b 0
