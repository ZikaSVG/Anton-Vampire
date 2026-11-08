@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title WER Disabled_Old rename

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] WER Disabled_Old rename
echo.

for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled 2^>nul ^| findstr /i "Disabled"') do (
  reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled_Old /t REG_DWORD /d %%b /f >nul 2>&1
)
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: WER Disabled_Old rename
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
