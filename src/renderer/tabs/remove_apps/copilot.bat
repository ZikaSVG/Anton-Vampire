@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Microsoft Copilot

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить Microsoft Copilot
echo.

powershell -NoProfile -Command "Get-AppxPackage -Name '*Copilot*' -AllUsers -EA 0 | Remove-AppxPackage -AllUsers -EA 0"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Удалить Microsoft Copilot
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
