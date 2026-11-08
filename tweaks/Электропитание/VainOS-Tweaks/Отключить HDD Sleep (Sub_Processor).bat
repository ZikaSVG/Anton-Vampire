@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить HDD Sleep (Sub_Processor)

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить HDD Sleep (Sub_Processor)
echo.

for %%a in (
  Sub_Processor
) do (
  for /f "delims=" %%b in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Power" /s /f "%%a" 2^>nul ^| findstr "HKEY"') do (
    reg add "%%b" /v "HDDSleepDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
  )
)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\0012ee47-9041-4b5d-9b77-535fba8b1442\dab60367-53fe-4fbc-825e-521d069d2456" /v "Attributes" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить HDD Sleep (Sub_Processor)
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
