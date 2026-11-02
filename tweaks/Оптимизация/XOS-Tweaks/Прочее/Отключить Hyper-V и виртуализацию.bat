@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Hyper-V и виртуализацию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Hyper-V и виртуализацию
echo.

for %%F in (Microsoft-Hyper-V-All Microsoft-Hyper-V Microsoft-Hyper-V-Tools-All Microsoft-Hyper-V-Management-PowerShell Microsoft-Hyper-V-Hypervisor Microsoft-Hyper-V-Services Microsoft-Hyper-V-Management-Clients) do (
  powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName %%F -NoRestart -EA 0" >nul 2>&1
)

echo.
echo [OK] Готово: Отключить Hyper-V и виртуализацию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
