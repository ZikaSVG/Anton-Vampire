@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: RunLogonScriptSync 0

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] RunLogonScriptSync 0
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v RunLogonScriptSync /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v RunStartupScriptSync /f >nul 2>&1

echo.
echo [OK] Отменено: RunLogonScriptSync вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
