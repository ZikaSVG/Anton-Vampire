@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить EdgeAutoLaunch

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить EdgeAutoLaunch
echo.

:: --- EdgeAutoLaunch не имеет фиксированного значения (генерируется при установке Edge).
echo [!] EdgeAutoLaunch не восстанавливается автоматически.

echo.
echo [OK] Отменено: Вернуть EdgeAutoLaunch
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
