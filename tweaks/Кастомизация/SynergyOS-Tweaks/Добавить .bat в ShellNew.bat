@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Добавить .bat в ShellNew

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Добавить .bat в ShellNew
echo.

reg add "HKLM\Software\Classes\.bat\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@C:\Windows\System32\acppage.dll,-6002" /f >nul 2>&1
reg add "HKLM\Software\Classes\.bat\ShellNew" /v "NullFile" /t REG_SZ /d "" /f >nul 2>&1

echo.
echo [OK] Готово: Добавить .bat в ShellNew
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
