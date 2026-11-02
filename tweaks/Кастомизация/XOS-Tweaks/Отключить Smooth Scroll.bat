@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Smooth Scroll

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Smooth Scroll
echo.

reg add "HKCU\Control Panel\Desktop" /v SmoothScroll /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v AutoColorization /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d "0" /f

echo.
echo [OK] Готово: Отключить Smooth Scroll
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
