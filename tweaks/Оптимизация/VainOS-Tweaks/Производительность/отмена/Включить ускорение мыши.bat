@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить ускорение мыши

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить ускорение мыши
echo.

reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "6" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "10" /f >nul 2>&1
reg delete "HKCU\Control Panel\Mouse" /v "RawMouseThrottleEnabled" /f >nul 2>&1
reg delete "HKCU\Control Panel\Mouse" /v "RawMouseThrottleForced" /f >nul 2>&1
reg delete "HKCU\Control Panel\Mouse" /v "RawMouseThrottleDuration" /f >nul 2>&1
reg delete "HKCU\Control Panel\Mouse" /v "RawMouseThrottleLeeway" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить ускорение мыши
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
