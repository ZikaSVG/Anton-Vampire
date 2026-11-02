@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить гибернацию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить гибернацию
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabledDefault" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HiberbootEnabled" /t REG_DWORD /d "1" /f >nul 2>&1
powercfg -h on >nul 2>&1

echo.
echo [OK] Отменено: Включить гибернацию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
