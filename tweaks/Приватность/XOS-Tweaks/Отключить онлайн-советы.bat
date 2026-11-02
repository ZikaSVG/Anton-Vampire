@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить онлайн-советы

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить онлайн-советы
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v AllowOnlineTips /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить онлайн-советы
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
