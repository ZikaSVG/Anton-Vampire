@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Включить классическое меню Win11

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Включить классическое меню Win11
echo.

reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть новое меню Win11
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
