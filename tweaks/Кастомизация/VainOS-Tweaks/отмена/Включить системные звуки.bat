@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить системные звуки

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить системные звуки
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Set-ItemProperty -Path 'HKCU:\AppEvents\Schemes' -Name '(Default)' -Value '.Default' -Force;" ^
  "Get-ChildItem -Path 'HKCU:\AppEvents\Schemes\Apps' | Get-ChildItem | Get-ChildItem | Where-Object { $_.PSChildName -eq '.Current' } | Set-ItemProperty -Name '(Default)' -Value '.Default'" >nul 2>&1

echo.
echo [OK] Отменено: Включить системные звуки
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
