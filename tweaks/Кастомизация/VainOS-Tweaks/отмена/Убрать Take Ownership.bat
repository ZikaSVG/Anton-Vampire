@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Добавить Take Ownership

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Добавить Take Ownership
echo.

reg delete "HKCR\Directory\shell\runas" /f >nul 2>&1

echo.
echo [OK] Отменено: Убрать Take Ownership
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
