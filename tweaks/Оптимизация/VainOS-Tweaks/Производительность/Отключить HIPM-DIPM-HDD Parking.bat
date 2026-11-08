@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить HIPM-DIPM-HDD Parking

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить HIPM-DIPM-HDD Parking
echo.

for %%a in (EnableHIPM EnableDIPM EnableHDDParking) do (
  for /f "delims=" %%b in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "%%a" 2^>nul ^| findstr "HKEY"') do (
    reg add "%%b" /v "%%a" /t REG_DWORD /d 0 /f >nul 2>&1
  )
)

echo.
echo [OK] Готово: Отключить HIPM-DIPM-HDD Parking
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
