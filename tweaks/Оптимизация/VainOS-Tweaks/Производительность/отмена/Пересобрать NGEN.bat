@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Пересобрать NGEN

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Пересобрать NGEN
echo.

echo [!] NGEN-кэш не откатывается. При следующей установке .NET-приложения он обновится сам.

echo.
echo [OK] Отменено: Пересобрать NGEN
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
