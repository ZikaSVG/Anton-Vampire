@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Dsh News and Interests

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Dsh News and Interests
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Dsh News and Interests
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
