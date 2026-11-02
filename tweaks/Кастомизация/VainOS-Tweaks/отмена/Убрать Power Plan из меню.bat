@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Добавить Power Plan в меню

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Добавить Power Plan в меню
echo.

reg delete "HKCR\DesktopBackground\Shell\Idle" /f >nul 2>&1

echo.
echo [OK] Отменено: Убрать Power Plan из меню
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
