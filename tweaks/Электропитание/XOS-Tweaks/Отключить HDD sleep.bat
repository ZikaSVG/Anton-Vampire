@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить HDD sleep

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить HDD sleep
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\0012ee47-9041-4b5d-9b77-535fba8b1442\0b2d69d7-a2a1-449c-9680-f91c70521c60" /v Attributes /t REG_DWORD /d 2 /f
powercfg -SETACVALUEINDEX SCHEME_CURRENT 0012ee47-9041-4b5d-9b77-535fba8b1442 0b2d69d7-a2a1-449c-9680-f91c70521c60 0
powercfg -setactive SCHEME_CURRENT

echo.
echo [OK] Готово: Отключить HDD sleep
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
