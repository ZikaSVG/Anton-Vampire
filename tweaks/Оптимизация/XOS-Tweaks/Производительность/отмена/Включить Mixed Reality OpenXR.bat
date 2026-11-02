@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Mixed Reality OpenXR

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Mixed Reality OpenXR
echo.

sc config MixedRealityOpenXRSvc start= demand >nul 2>&1

echo.
echo [OK] Отменено: Включить Mixed Reality OpenXR
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
