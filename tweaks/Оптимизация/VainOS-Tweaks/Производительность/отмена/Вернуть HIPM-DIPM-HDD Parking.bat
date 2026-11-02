@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить HIPM-DIPM-HDD Parking

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить HIPM-DIPM-HDD Parking
echo.

:: --- Значения вернутся сами при перезагрузке драйвера.
echo [!] Значения HIPM-DIPM-HDDParking сбросятся при следующей перезагрузке.

echo.
echo [OK] Отменено: Вернуть HIPM-DIPM-HDD Parking
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
