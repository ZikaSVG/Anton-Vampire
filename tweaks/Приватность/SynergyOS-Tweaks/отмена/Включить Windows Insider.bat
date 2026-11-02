@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Windows Insider

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить Windows Insider
echo.

reg delete "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v "DiagnosticErrorText" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Strings" /v "DiagnosticErrorText" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Strings" /v "DiagnosticLinkText" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Windows Insider
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
