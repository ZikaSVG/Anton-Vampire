@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить CBS Background App

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить CBS Background App
echo.

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\MicrosoftWindows.Client.CBS_cw5n1h2txyewy" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить CBS Background App
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
