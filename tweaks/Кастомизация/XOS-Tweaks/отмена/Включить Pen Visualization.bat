@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Pen Visualization

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Pen Visualization
echo.

reg add "HKCU\Control Panel\Cursors" /v PenVisualization /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить Pen Visualization
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
