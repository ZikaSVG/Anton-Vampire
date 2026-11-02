@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить энергосбережение устройств

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить энергосбережение устройств
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MSDisabled" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "IdleProcessorsRequireQosManagement" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableInboxPepGeneratedConstraints" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить энергосбережение устройств
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
