@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить StorPort Idle Power Management

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить StorPort Idle Power Management
echo.

:: --- Сбрасывается при следующей загрузке драйвера.
echo [!] StorPort значения сбросятся при следующей перезагрузке.

echo.
echo [OK] Отменено: Вернуть StorPort Idle Power Management
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
