@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить I-O System

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить I-O System
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "DisableDiskCounters" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "IoAllowLoadCrashDumpDriver" /t REG_DWORD /d "0" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить I-O System
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
