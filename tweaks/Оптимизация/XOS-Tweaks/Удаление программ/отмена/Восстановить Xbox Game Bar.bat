@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить Xbox Game Bar

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить Xbox Game Bar
echo.

echo Установите Xbox Game Bar из Microsoft Store.

echo.
echo [OK] Отменено: Восстановить Xbox Game Bar
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
