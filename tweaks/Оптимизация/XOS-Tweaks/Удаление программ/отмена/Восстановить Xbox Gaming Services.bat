@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить Xbox Gaming Services

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить Xbox Gaming Services
echo.

echo Установите Gaming Services из Microsoft Store.

echo.
echo [OK] Отменено: Восстановить Xbox Gaming Services
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
