@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Разрешить удаление Edge через Dev Policy

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Разрешить удаление Edge через Dev Policy
echo.

reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdateDev" /v AllowUninstall /f >nul 2>&1

echo.
echo [OK] Отменено: Откатить Edge Dev Policy
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
