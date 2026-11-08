@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Copilot и AI

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Copilot и AI
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsCopilot" /v DisableAIDataAnalysis /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить Copilot
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
