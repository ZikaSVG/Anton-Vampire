@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Hyper-V и виртуализацию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Hyper-V и виртуализацию
echo.

powershell -NoProfile -Command "Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart -All -EA 0"

echo.
echo [OK] Отменено: Включить Hyper-V
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
