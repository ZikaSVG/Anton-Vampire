@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включить классическое меню Win11

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Включить классическое меню Win11
echo.

reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f >nul 2>&1

echo.
echo [OK] Готово: Включить классическое меню Win11
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
