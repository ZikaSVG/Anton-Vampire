@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить Microsoft Photos с заменой на Photo Viewer

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить Microsoft Photos с заменой на Photo Viewer
echo.

echo Установите Microsoft Photos из Microsoft Store.

echo.
echo [OK] Отменено: Восстановить Microsoft Photos
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
