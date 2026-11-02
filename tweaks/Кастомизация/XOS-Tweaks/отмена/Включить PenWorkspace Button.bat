@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить PenWorkspace Button

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить PenWorkspace Button
echo.

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v PenWorkspaceButtonDesiredVisibility /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить PenWorkspace Button
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
