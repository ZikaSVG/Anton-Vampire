@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить VRR

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить VRR
echo.

reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v DirectXUserGlobalSettings /t REG_SZ /d "VRROptimizeEnable=0;" /f

echo.
echo [OK] Готово: Отключить VRR
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
