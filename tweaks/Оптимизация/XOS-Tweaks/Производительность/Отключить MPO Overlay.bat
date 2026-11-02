@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить MPO Overlay

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить MPO Overlay
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode /t REG_DWORD /d 5 /f

echo.
echo [OK] Готово: Отключить MPO Overlay
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
