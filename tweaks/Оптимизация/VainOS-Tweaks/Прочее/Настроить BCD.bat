@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить BCD

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить BCD
echo.

bcdedit /set {current} description "vain" >nul 2>&1
bcdedit /set bootmenupolicy Legacy >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue useplatformtick >nul 2>&1
bcdedit /set {current} nx optin >nul 2>&1
bcdedit /set {current} recoveryenabled no >nul 2>&1
bcdedit /set {current} disableelamdrivers yes >nul 2>&1
bcdedit /set {current} integrityservices disable >nul 2>&1
label %systemdrive% vain >nul 2>&1

echo.
echo [OK] Готово: Настроить BCD
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
