@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Добавить Run as TrustedInstaller

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Добавить Run as TrustedInstaller
echo.

for %%E in (batfile cmdfile exefile mscfile "Microsoft.PowerShellScript.1" Folder) do (
  reg add "HKCR\%%~E\shell\setdesktopwallpaper" /v MUIVerb /t REG_SZ /d "Run as TrustedInstaller" /f >nul 2>&1
  reg add "HKCR\%%~E\shell\setdesktopwallpaper" /v HasLUAShield /t REG_SZ /d "" /f >nul 2>&1
  reg add "HKCR\%%~E\shell\setdesktopwallpaper" /v Icon /t REG_SZ /d "powershell.exe,0" /f >nul 2>&1
)
reg add "HKCR\regfile\shell\setdesktopwallpaper" /v MUIVerb /t REG_SZ /d "Import as TrustedInstaller" /f >nul 2>&1
reg add "HKCR\regfile\shell\setdesktopwallpaper" /v HasLUAShield /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\Folder\shell\setdesktopwallpaper" /v "AppliesTo" /t REG_SZ /d "NOT System.ParsingName:=\"::{645FF040-5081-101B-9F08-00AA002F954E}\"" /f >nul 2>&1

echo.
echo [OK] Готово: Добавить Run as TrustedInstaller
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
