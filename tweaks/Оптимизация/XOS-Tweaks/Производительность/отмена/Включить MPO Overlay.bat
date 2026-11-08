@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить MPO Overlay

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить MPO Overlay
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode /f >nul 2>&1

echo.
echo [OK] Отменено: Включить MPO Overlay
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
