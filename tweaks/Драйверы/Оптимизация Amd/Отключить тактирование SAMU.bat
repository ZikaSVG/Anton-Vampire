@echo off
title   SAMU
color 0A
echo ========================================
echo   SAMU
echo ========================================
echo.
echo  : DisableSamuClockGating
echo : REG_DWORD
echo : 1
echo : HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000
echo.
echo  ...
echo.
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableSamuClockGating" /t REG_DWORD /d "1" /f
if %errorlevel% equ 0 (
    echo [+]   
) else (
    echo [-]    
    echo   
)
echo.