@echo off
title  GPU  IoMmu
color 0A
echo ========================================
echo  GPU  IoMmu
echo ========================================
echo.
echo : ; related to vm
echo  : KMD_IoMmuGpuIsolation
echo : REG_DWORD
echo : 0
echo : HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000
echo.
echo  ...
echo.
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_IoMmuGpuIsolation" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (
    echo [+]   
) else (
    echo [-]    
    echo   
)
echo.