@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Оптимизация ядра и планировщика

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Оптимизация ядра и планировщика
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v DesktopHeapLogging /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NoLazyMode /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v TimerResolution /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePageCombining /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v BackgroundLoadKnownDlls /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v BootExecuteNoPnpSync /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v TaskhostTimeout /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v DefaultTriggerCoalescingTime /f >nul 2>&1

echo.
echo [OK] Отменено: Откат оптимизации ядра
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
