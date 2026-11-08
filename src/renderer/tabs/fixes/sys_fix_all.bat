@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

cd /d "%~dp0"

call "sys_services.bat"
call "sys_update_cache.bat"
call "sys_store_reset.bat"
call "sys_dism.bat"
call "sys_sfc.bat"

exit /b 0