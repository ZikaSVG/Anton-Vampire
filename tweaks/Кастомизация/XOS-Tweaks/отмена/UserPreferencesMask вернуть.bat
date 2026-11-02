@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: UserPreferencesMask Binary

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] UserPreferencesMask Binary
echo.

reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9E3E078012000000 /f

echo.
echo [OK] Отменено: UserPreferencesMask вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
