@echo off
title    HDMI
color 0B
echo ========================================
echo    HDMI
echo ========================================
echo  : 9
echo.
echo  ...
echo.
echo ----------------------------------------
echo  HDCP
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DalDisableHDCP" /t REG_DWORD /d "1" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo  HDMI 2.0
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DalEnableHDMI20" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo   ABM
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DalForceAbmEnable" /t REG_DWORD /d "1" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo   
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DalForceMaxDisplayClock" /t REG_DWORD /d "1" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo  eDP 
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DalOptimizeEdpLinkRate" /t REG_DWORD /d "1" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo  PSR (Panel Self Refresh)
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DalPSRFeatureEnable" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo  EDID
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_EnableEDIDManagementSupport" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo  10 
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_10BitMode" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo   
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\DAL2_DATA__2_0\DisplayPath_4\EDID_D109_78E9\Option" /v "ProtectionControl" /t REG_BINARY /d "0100000001000000" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo ----------------------------------------
echo.
echo [+]    