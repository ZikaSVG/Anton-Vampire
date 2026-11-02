@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Tablet Tip Band

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Tablet Tip Band
echo.

reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v TipbandDesiredVisibility /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Tablet Tip Band
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
