@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить PolicyManager AllowCortana

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить PolicyManager AllowCortana
echo.

reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" /v value /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaInAmbientMode /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить PolicyManager AllowCortana
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
