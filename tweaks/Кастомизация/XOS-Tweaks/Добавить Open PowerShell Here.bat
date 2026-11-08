@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Добавить Open PowerShell Here

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Добавить Open PowerShell Here
echo.

reg add "HKCR\Directory\Background\shell\OpenPwshHere" /v MUIVerb /t REG_SZ /d "Open PowerShell Here" /f
reg add "HKCR\Directory\Background\shell\OpenPwshHere" /v Icon /t REG_SZ /d "powershell.exe" /f
reg add "HKCR\Directory\Background\shell\OpenPwshHere\command" /ve /t REG_SZ /d "powershell.exe -NoExit -Command Set-Location -LiteralPath '%%V'" /f
reg add "HKCR\Directory\shell\OpenPwshHere" /v MUIVerb /t REG_SZ /d "Open PowerShell Here" /f
reg add "HKCR\Directory\shell\OpenPwshHere" /v Icon /t REG_SZ /d "powershell.exe" /f
reg add "HKCR\Directory\shell\OpenPwshHere\command" /ve /t REG_SZ /d "powershell.exe -NoExit -Command Set-Location -LiteralPath '%%V'" /f

echo.
echo [OK] Готово: Добавить Open PowerShell Here
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
