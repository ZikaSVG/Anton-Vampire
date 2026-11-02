@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить историю поиска

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить историю поиска
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v HistoryViewEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v DeviceHistoryEnabled /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить историю поиска
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
