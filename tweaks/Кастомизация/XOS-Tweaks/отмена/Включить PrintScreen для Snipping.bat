@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить PrintScreen для Snipping

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить PrintScreen для Snipping
echo.

reg add "HKCU\Control Panel\Keyboard" /v PrintScreenKeyForSnippingEnabled /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить PrintScreen для Snipping
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
