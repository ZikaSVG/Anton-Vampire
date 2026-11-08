@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить биометрию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить биометрию
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить биометрию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
