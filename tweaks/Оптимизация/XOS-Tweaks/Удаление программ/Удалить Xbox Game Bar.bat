@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Xbox Game Bar

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить Xbox Game Bar
echo.

powershell -NoProfile -Command "Get-AppxPackage -Name '*XboxGamingOverlay*' -AllUsers -EA 0 | Remove-AppxPackage -AllUsers -EA 0"
powershell -NoProfile -Command "Get-AppxPackage -Name '*XboxGameOverlay*' -AllUsers -EA 0 | Remove-AppxPackage -AllUsers -EA 0"
powershell -NoProfile -Command "Get-AppxPackage -Name '*XboxIdentityProvider*' -AllUsers -EA 0 | Remove-AppxPackage -AllUsers -EA 0"

echo.
echo [OK] Готово: Удалить Xbox Game Bar
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
