@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Defender Real-Time Protection

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Defender Real-Time Protection
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware\Real-Time Protection" /v "DisableOnAccessProtection" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScriptScanning" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Defender Real-Time Protection
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
