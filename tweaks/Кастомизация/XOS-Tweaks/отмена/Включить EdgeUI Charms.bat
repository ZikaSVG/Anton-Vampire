@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить EdgeUI Charms

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить EdgeUI Charms
echo.

reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" /v DisableCharms /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" /v DisableRecentApps /f >nul 2>&1

echo.
echo [OK] Отменено: Включить EdgeUI Charms
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
