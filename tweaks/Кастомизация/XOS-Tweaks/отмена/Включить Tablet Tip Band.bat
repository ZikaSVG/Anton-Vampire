@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Tablet Tip Band

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Tablet Tip Band
echo.

reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v TipbandDesiredVisibility /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить Tablet Tip Band
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
