@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить VRR

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить VRR
echo.

reg delete "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v DirectXUserGlobalSettings /f >nul 2>&1

echo.
echo [OK] Отменено: Включить VRR
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
