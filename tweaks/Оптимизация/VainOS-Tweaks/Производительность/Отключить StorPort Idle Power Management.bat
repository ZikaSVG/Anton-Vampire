@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить StorPort Idle Power Management

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить StorPort Idle Power Management
echo.

for /f "tokens=*" %%s in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "StorPort" 2^>nul ^| findstr /e "StorPort"') do (
  reg add "%%s" /v EnableIdlePowerManagement /t REG_DWORD /d 0 /f >nul 2>&1
)

echo.
echo [OK] Готово: Отключить StorPort Idle Power Management
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
