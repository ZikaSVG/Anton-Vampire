@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Добавить .bat в ShellNew

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Добавить .bat в ShellNew
echo.

reg delete "HKLM\Software\Classes\.bat\ShellNew" /v "ItemName" /f >nul 2>&1
reg delete "HKLM\Software\Classes\.bat\ShellNew" /v "NullFile" /f >nul 2>&1

echo.
echo [OK] Отменено: Убрать .bat из ShellNew
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
