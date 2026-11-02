@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить GPU задержки

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Отключить GPU задержки
echo.

reg add "HKLM\SYSTEM\ControlSet002\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "DelayedDetectionForDP" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet002\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "DelayedDetectionForHDMI" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet002\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "WideGamutFeatureEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet002\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "XVYCCFeatureEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet002\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "DeepColorHDMIDisable" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet002\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "Disable_OverlayDSQualityEnhancement" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet002\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "AllowDeepCStates" /t REG_DWORD /d "0" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить GPU задержки
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
