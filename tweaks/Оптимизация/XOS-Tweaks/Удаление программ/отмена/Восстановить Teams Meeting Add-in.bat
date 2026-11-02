@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить Teams Meeting Add-in

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить Teams Meeting Add-in
echo.

echo Teams Meeting Add-in вернётся при переустановке Office/Teams.

echo.
echo [OK] Отменено: Восстановить Teams Meeting Add-in
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
