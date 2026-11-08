@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить DWM тени и анимации

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить DWM тени и анимации
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v DisableProjectedShadows /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v MousewheelAnimationDurationMs /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\XAML" /v DisableGlobalAnimations /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить DWM тени и анимации
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
