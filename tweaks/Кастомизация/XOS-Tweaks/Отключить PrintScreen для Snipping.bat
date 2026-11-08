@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить PrintScreen для Snipping

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить PrintScreen для Snipping
echo.

reg add "HKCU\Control Panel\Keyboard" /v PrintScreenKeyForSnippingEnabled /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить PrintScreen для Snipping
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
