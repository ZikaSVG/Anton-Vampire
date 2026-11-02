@echo off
title   
color 0A
echo ========================================
echo   
echo ========================================
echo.
echo  : ProtectionControl
echo : REG_BINARY
echo : 0100000001000000
echo : HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\DAL2_DATA__2_0\DisplayPath_4\EDID_D109_78E9\Option
echo.
echo  ...
echo.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\DAL2_DATA__2_0\DisplayPath_4\EDID_D109_78E9\Option" /v "ProtectionControl" /t REG_BINARY /d "0100000001000000" /f
if %errorlevel% equ 0 (
    echo [+]   
) else (
    echo [-]    
    echo   
)
echo.