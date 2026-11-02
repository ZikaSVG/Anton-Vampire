@echo off
title   
color 0A
echo ========================================
echo   
echo ========================================
echo.
echo  : KMD_EnableSeamlessBoot
echo : REG_DWORD
echo : 0
echo : HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000
echo.
echo  ...
echo.
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_EnableSeamlessBoot" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (
    echo [+]   
) else (
    echo [-]    
    echo   
)
echo.