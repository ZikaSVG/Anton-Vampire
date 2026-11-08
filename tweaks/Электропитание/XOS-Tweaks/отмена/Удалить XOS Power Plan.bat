@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Импортировать XOS Power Plan

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Импортировать XOS Power Plan
echo.

powercfg -delete 31693169-3169-3169-3169-316931693169 >nul 2>&1

echo.
echo [OK] Отменено: Удалить XOS Power Plan
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
