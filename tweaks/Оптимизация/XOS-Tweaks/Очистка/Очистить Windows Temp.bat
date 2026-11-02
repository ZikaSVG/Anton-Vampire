@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить Windows Temp

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить Windows Temp
echo.

powershell -NoProfile -Command "Remove-Item -Path ([Environment]::GetFolderPath('Windows') + '\Temp\*') -Force -Recurse -EA 0"

echo.
echo [OK] Готово: Очистить Windows Temp
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
