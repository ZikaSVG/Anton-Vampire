@echo off
title   
color 0B
echo ========================================
echo   
echo ========================================
echo  : 4
echo.
echo  ...
echo.
echo ----------------------------------------
echo   
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_IsGamingDriver" /t REG_DWORD /d "1" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo   
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_FramePacingSupport" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo    
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_DeLagEnabled" /t REG_DWORD /d "0" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo  Radeon Boost
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_RadeonBoostEnabled" /t REG_DWORD /d "1" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo ----------------------------------------
echo.
echo [+]    