@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить FeatureManagement Override 1387020943

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить FeatureManagement Override 1387020943
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 1387020943 /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\8\1387020943" /v EnabledState /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\8\1387020943" /v EnabledStateOptions /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\8\1387020943" /v Variant /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\8\1387020943" /v VariantPayload /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\8\1387020943" /v VariantPayloadKind /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить FeatureManagement Override 1387020943
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
