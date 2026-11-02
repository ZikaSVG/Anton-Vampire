@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Copilot и AI

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Copilot и AI
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsCopilot" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\Shell\Copilot\BingChat" /v IsUserEligible /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v AutoOpenCopilotLargeScreens /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\ShowJumpView" /v "Microsoft.Copilot_8wekyb3d8bbwe!App" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v AllowRecallEnablement /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Copilot и AI
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
