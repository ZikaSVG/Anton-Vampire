@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title SwapEffectUpgradeEnable Win11

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] SwapEffectUpgradeEnable Win11
echo.

reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v DirectXUserGlobalSettings /t REG_SZ /d "SwapEffectUpgradeEnable=1;VRROptimizeEnable=0;" /f

echo.
echo [OK] Готово: SwapEffectUpgradeEnable Win11
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
