@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Добавить Take Ownership

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Добавить Take Ownership
echo.

reg delete "HKCR\*\shell\TakeOwnership" /f >nul 2>&1
reg delete "HKCR\Directory\shell\TakeOwnership" /f >nul 2>&1

echo.
echo [OK] Отменено: Убрать Take Ownership
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
