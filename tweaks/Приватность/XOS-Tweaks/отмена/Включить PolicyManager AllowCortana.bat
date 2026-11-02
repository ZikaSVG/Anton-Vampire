@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить PolicyManager AllowCortana

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить PolicyManager AllowCortana
echo.

reg delete "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" /v value /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaEnabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaInAmbientMode /f >nul 2>&1

echo.
echo [OK] Отменено: Включить PolicyManager AllowCortana
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
