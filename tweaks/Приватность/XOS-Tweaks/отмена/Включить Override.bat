@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить FeatureManagement Override 1387020943

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить FeatureManagement Override 1387020943
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 1387020943 /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\8\1387020943" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Override
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
