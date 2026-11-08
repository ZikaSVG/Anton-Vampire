@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Ускорить выключение приложений

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Ускорить выключение приложений
echo.

reg add "HKU\.DEFAULT\Control Panel\Desktop" /v CriticalAppShutdownCleanupTimeout /t REG_DWORD /d 30000 /f
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v CriticalAppShutdownTimeout /t REG_DWORD /d 30000 /f

echo.
echo [OK] Отменено: Вернуть таймаут выключения
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
