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
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation" /t REG_BINARY /d "3100" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation_OPTION" /t REG_BINARY /d "3200" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ShaderCache" /t REG_BINARY /d "3200" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo   
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TFQ" /t REG_BINARY /d "3200" /f
if %errorlevel% equ 0 (echo   [+] OK) else (echo   [-] )
echo.
echo ----------------------------------------
echo.
echo [+]    