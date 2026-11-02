@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: SwapEffectUpgradeEnable Win11

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] SwapEffectUpgradeEnable Win11
echo.

reg delete "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v DirectXUserGlobalSettings /f >nul 2>&1

echo.
echo [OK] Отменено: SwapEffectUpgradeEnable вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
