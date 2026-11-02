@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Классическое контекстное меню Win11

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Классическое контекстное меню Win11
echo.

reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo [OK] Готово: Классическое контекстное меню Win11
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
