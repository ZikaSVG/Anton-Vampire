@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Steps Recorder

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Steps Recorder
echo.

powershell -NoProfile -Command "$sr = Get-WindowsCapability -Online -Name 'App.StepsRecorder~~~~0.0.1.0'; if ($sr.State -ne 'NotPresent') { Remove-WindowsCapability -Online -Name 'App.StepsRecorder~~~~0.0.1.0' }"

echo.
echo [OK] Готово: Отключить Steps Recorder
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
