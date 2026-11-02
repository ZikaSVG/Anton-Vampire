@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить энергосбережение устройств

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить энергосбережение устройств
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MSDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "IdleProcessorsRequireQosManagement" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableInboxPepGeneratedConstraints" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить энергосбережение устройств
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
