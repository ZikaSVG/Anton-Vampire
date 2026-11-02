@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить StepsRecorder

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить StepsRecorder
echo.

DISM.exe /Online /Remove-Capability /CapabilityName:"App.StepsRecorder~~~~0.0.1.0" /NoRestart >nul 2>&1

echo.
echo [OK] Готово: Удалить StepsRecorder
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
