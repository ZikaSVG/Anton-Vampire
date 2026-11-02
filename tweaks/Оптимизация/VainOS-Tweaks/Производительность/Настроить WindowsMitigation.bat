@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить WindowsMitigation

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить WindowsMitigation
echo.

reg add "HKLM\SOFTWARE\Microsoft\WindowsMitigation" /v "UserPreference" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить WindowsMitigation
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
