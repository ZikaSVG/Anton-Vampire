@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Скрыть страницы в Параметрах

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Скрыть страницы в Параметрах
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "SettingsPageVisibility" /f >nul 2>&1

echo.
echo [OK] Отменено: Показать страницы в Параметрах
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
