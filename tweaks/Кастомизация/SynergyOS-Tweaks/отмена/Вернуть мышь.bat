@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить мышь

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Настроить мышь
echo.

reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "400" /f >nul 2>&1
reg delete "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "1" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть мышь
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
