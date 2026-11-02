@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить службы Defender

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить службы Defender
echo.

:: --- Удалить службы Defender
sc delete Sense >nul 2>&1
sc delete WinDefend >nul 2>&1
sc delete MsSecCore >nul 2>&1
sc delete wscsvc >nul 2>&1
sc delete WdFilter >nul 2>&1
sc delete WdBoot >nul 2>&1
sc delete WdNisDrv >nul 2>&1
sc delete WdNisSvc >nul 2>&1
sc delete MsSecWfp >nul 2>&1
sc delete MsSecFlt >nul 2>&1
sc delete wtd >nul 2>&1
sc delete webthreatdefusersvc >nul 2>&1
sc delete webthreatdefsvc >nul 2>&1
sc delete SecurityHealthService >nul 2>&1
:: --- Отключить WTDS
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components" /v "ServiceEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
:: --- Удалить Run-ключи
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDefender" /f >nul 2>&1

echo.
echo [OK] Готово: Удалить службы Defender
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
