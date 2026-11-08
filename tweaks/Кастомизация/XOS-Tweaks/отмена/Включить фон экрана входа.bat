@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить фон экрана входа

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить фон экрана входа
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v DisableLogonBackgroundImage /f >nul 2>&1

echo.
echo [OK] Отменено: Включить фон экрана входа
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
