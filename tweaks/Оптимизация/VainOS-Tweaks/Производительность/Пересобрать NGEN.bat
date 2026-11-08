@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Пересобрать NGEN

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Пересобрать NGEN
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$env:PATH = \"$([Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory());$env:PATH\";" ^
  "[AppDomain]::CurrentDomain.GetAssemblies() | ForEach-Object { if ($_.Location) { ngen install $_.Location | Out-Null } }" >nul 2>&1

echo.
echo [OK] Готово: Пересобрать NGEN
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
