@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить сетевой throttle

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить сетевой throttle
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "DisableBandwidthThrottling" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /v "RestrictNullSessAccess" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "RestrictAnonymous" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "RestrictAnonymousSAM" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть сетевой throttle
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
