@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Добавить .reg в ShellNew

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Добавить .reg в ShellNew
echo.

reg delete "HKLM\Software\Classes\.reg\ShellNew" /v "ItemName" /f >nul 2>&1
reg delete "HKLM\Software\Classes\.reg\ShellNew" /v "NullFile" /f >nul 2>&1

echo.
echo [OK] Отменено: Убрать .reg из ShellNew
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
