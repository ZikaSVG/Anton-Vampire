@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Windows Insider

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Отключить Windows Insider
echo.

reg add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v "DiagnosticErrorText" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Strings" /v "DiagnosticErrorText" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Strings" /v "DiagnosticLinkText" /t REG_SZ /d "" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить Windows Insider
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
