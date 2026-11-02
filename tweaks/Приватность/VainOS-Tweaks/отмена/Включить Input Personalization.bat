@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Input Personalization

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Input Personalization
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\InkingAndTypingPersonalization" /v "Value" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v "DisablePrediction" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v "AllowSuggestedAppsInWindowsInkWorkspace" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Input Personalization
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
