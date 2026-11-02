@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить DWM тени и анимации

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить DWM тени и анимации
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v DisableProjectedShadows /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v MousewheelAnimationDurationMs /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\XAML" /v DisableGlobalAnimations /f >nul 2>&1

echo.
echo [OK] Отменено: Включить DWM тени
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
