@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Тёмная тема приложений

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Тёмная тема приложений
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Тёмная тема приложений
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
