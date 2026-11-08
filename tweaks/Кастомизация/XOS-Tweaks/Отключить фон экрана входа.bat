@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить фон экрана входа

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить фон экрана входа
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v DisableLogonBackgroundImage /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить фон экрана входа
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
