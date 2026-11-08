@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить WinHTTP WPAD

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить WinHTTP WPAD
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" /v DisableWpad /f >nul 2>&1

echo.
echo [OK] Отменено: Включить WinHTTP WPAD
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
