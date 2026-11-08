@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить OptimalLayout и BootOptimize

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить OptimalLayout и BootOptimize
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OptimalLayout" /v "EnableAutoLayout" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "Enable" /t REG_SZ /d "Y" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть OptimalLayout и BootOptimize
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
