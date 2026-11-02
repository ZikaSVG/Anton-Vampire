@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить I-O System

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить I-O System
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "DisableDiskCounters" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "IoAllowLoadCrashDumpDriver" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть I-O System
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
