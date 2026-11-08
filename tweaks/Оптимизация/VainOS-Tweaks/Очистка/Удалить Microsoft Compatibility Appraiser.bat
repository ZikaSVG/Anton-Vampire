@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Microsoft Compatibility Appraiser

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить Microsoft Compatibility Appraiser
echo.

schtasks /Delete /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /F >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser Exp" /F >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /F >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /F >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\Application Experience\MareBackup" /F >nul 2>&1
:: --- Убить процесс и удалить файл
taskkill /f /im CompatTelRunner.exe >nul 2>&1
del /f /q "%windir%\system32\CompatTelRunner.exe" >nul 2>&1
:: --- Также удалить AggregatorHost
taskkill /f /im AggregatorHost.exe >nul 2>&1
del /f /q "%windir%\system32\AggregatorHost.exe" >nul 2>&1
:: --- CEIP
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\AppV\CEIP" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableEngine" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1

echo.
echo [OK] Готово: Удалить Microsoft Compatibility Appraiser
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
