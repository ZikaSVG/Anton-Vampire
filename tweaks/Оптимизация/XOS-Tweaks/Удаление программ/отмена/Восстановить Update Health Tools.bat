@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить Update Health Tools

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить Update Health Tools
echo.

echo Update Health Tools переустанавливается через Windows Update.

echo.
echo [OK] Отменено: Восстановить Update Health Tools
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
