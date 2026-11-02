@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить PenWorkspace Button

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить PenWorkspace Button
echo.

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v PenWorkspaceButtonDesiredVisibility /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить PenWorkspace Button
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
