@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Сбросить скорость мыши на 0

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Сбросить скорость мыши на 0
echo.

reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "1" /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "6" /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "10" /f

echo.
echo [OK] Отменено: Вернуть скорость мыши
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
