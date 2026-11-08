@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить системные звуки

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить системные звуки
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$Path='HKCU:\AppEvents\Schemes';" ^
  "New-ItemProperty -Path $Path -Name '(Default)' -Value '.None' -Force | Out-Null;" ^
  "Get-ChildItem -Path 'HKCU:\AppEvents\Schemes\Apps' | Get-ChildItem | Get-ChildItem | Where-Object { $_.PSChildName -eq '.Current' } | Set-ItemProperty -Name '(Default)' -Value ''" >nul 2>&1

echo.
echo [OK] Готово: Отключить системные звуки
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
