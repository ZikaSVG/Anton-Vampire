@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Добавить Run as TrustedInstaller

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Добавить Run as TrustedInstaller
echo.

for %%E in (batfile cmdfile exefile mscfile "Microsoft.PowerShellScript.1" Folder regfile) do (
  reg delete "HKCR\%%~E\shell\setdesktopwallpaper" /f >nul 2>&1
)

echo.
echo [OK] Отменено: Убрать Run as TrustedInstaller
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
