@echo off
title   (Stutter Mode)
color 0A
echo ========================================
echo   (Stutter Mode)
echo ========================================
echo.
echo  : StutterMode
echo : REG_DWORD
echo : 0
echo : HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000
echo.
echo  ...
echo.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "StutterMode" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (
    echo [+]   
) else (
    echo [-]    
    echo   
)
echo.