@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить BCD

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Настроить BCD
echo.

bcdedit /set bootmenupolicy Standard >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1

echo.
echo [OK] Отменено: Вернуть BCD
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
