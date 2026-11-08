@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Добавить Open CMD Here

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Добавить Open CMD Here
echo.

reg add "HKCR\Directory\Background\shell\OpenCmdHere" /v MUIVerb /t REG_SZ /d "Open Command Prompt Here" /f
reg add "HKCR\Directory\Background\shell\OpenCmdHere" /v Icon /t REG_SZ /d "cmd.exe" /f
reg add "HKCR\Directory\Background\shell\OpenCmdHere\command" /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f
reg add "HKCR\Directory\shell\OpenCmdHere" /v MUIVerb /t REG_SZ /d "Open Command Prompt Here" /f
reg add "HKCR\Directory\shell\OpenCmdHere" /v Icon /t REG_SZ /d "cmd.exe" /f
reg add "HKCR\Directory\shell\OpenCmdHere\command" /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f

echo.
echo [OK] Готово: Добавить Open CMD Here
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
