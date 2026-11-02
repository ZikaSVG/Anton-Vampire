@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Тёмная тема приложений

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Тёмная тема приложений
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Светлая тема приложений
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
