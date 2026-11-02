@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Скрыть Widgets

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Скрыть Widgets
echo.

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Показать Widgets
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
