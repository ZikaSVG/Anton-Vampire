@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить CPU Quota

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить CPU Quota
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Quota System" /v EnableCpuQuota /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить CPU Quota
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
