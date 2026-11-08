@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить доступ к Windows Update

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить доступ к Windows Update
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "SetDisableUXWUAccess" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить доступ к Windows Update
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
