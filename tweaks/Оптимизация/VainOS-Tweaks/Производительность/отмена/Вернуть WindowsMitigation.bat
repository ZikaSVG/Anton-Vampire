@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить WindowsMitigation

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить WindowsMitigation
echo.

reg delete "HKLM\SOFTWARE\Microsoft\WindowsMitigation" /v "UserPreference" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть WindowsMitigation
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
