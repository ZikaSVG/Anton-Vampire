@echo off
title   AMD
color 0B
echo ========================================
echo   AMD
echo ========================================
echo  : 7
echo.
echo  ...
echo.
echo ----------------------------------------
echo   
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableUlps" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo   (Stutter Mode)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "StutterMode" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo    (PowerPlay)
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_DisableLightSleep" /t REG_DWORD /d "1" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo    Sclk
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_SclkDeepSleepDisable" /t REG_DWORD /d "1" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo    
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo    
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableLBPWSupport" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo  PPSM (SpeedStep)
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnablePPSMSupport" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo ----------------------------------------
echo.
echo [+]    