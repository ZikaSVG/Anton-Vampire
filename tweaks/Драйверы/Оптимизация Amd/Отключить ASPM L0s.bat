@echo off
title  ASPM L0s
color 0A
echo ========================================
echo  ASPM L0s
echo ========================================
echo.
echo  : DisableAspmL0s
echo : REG_DWORD
echo : 1
echo : HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000
echo.
echo  ...
echo.
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableAspmL0s" /t REG_DWORD /d "1" /f
if %errorlevel% equ 0 (
    echo [+]   
) else (
    echo [-]    
    echo   
)
echo.