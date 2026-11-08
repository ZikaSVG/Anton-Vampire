@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить EdgeUI Charms

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить EdgeUI Charms
echo.

reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" /v DisableCharms /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" /v DisableRecentApps /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить EdgeUI Charms
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
