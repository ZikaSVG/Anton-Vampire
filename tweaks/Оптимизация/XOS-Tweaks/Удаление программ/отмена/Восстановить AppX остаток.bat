@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить AppX остаток

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить AppX остаток
echo.

echo Установите нужные приложения из Microsoft Store.

echo.
echo [OK] Отменено: Восстановить AppX остаток
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
