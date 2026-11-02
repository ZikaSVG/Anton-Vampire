@echo off
title  VSync
color 0A
echo ========================================
echo  VSync
echo ========================================
echo.
echo  : VSyncControl
echo : REG_BINARY
echo : 3000
echo : HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD
echo.
echo  ...
echo.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "VSyncControl" /t REG_BINARY /d "3000" /f
if %errorlevel% equ 0 (
    echo [+]   
) else (
    echo [-]    
    echo   
)
echo.