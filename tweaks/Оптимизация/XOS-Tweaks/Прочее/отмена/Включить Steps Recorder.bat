@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Steps Recorder

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Steps Recorder
echo.

powershell -NoProfile -Command "Add-WindowsCapability -Online -Name 'App.StepsRecorder~~~~0.0.1.0'"

echo.
echo [OK] Отменено: Включить Steps Recorder
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
