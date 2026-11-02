@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Pen Visualization

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Pen Visualization
echo.

reg add "HKCU\Control Panel\Cursors" /v PenVisualization /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Pen Visualization
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
