@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Search box только иконка

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Search box только иконка
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Search box только иконка
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
