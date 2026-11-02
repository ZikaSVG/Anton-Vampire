@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Lock Screen Camera

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Lock Screen Camera
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenCamera" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Lock Screen Camera
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
