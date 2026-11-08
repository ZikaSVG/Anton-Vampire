@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить WinHTTP WPAD

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить WinHTTP WPAD
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" /v DisableWpad /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить WinHTTP WPAD
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
