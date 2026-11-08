@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить печать

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить печать
echo.

echo  [1] Enable Printing
echo  [2] Disable Printing (default)
set /p "CH=Выбор [1/2]: "
if "%CH%"=="2" goto :disable
if "%CH%"=="1" goto :enable
echo [!] Неверный выбор.
pause & exit /b 1

:disable
for %%z in (Spooler PrintWorkFlowUserSvc StiSvc PrintNotify usbprint McpManagementService PrintScanBrokerService PrintDeviceConfigurationService) do (
  reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%z" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
)
for %%K in ("SystemFileAssociations\image\shell\print" "batfile\shell\print" "fonfile\shell\print" "cmdfile\shell\print" "htmlfile\shell\print" "JSEFile\Shell\Print" "otffile\shell\print" "pfmfile\shell\print" "regfile\shell\print" "ttcfile\shell\print" "ttffile\shell\print" "VBEFile\Shell\Print" "VBSFile\Shell\Print" "WSFFile\Shell\Print") do reg delete "HKCR\%%~K" /f >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"Printing-PrintToPDFServices-Features" /NoRestart >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"Printing-Foundation-Features" /NoRestart >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"Printing-Foundation-InternetPrinting-Client" /NoRestart >nul 2>&1
echo Printing disabled, reboot.
pause & exit /b 0

:enable
for %%z in (PrintWorkFlowUserSvc StiSvc PrintNotify usbprint McpManagementService PrintScanBrokerService PrintDeviceConfigurationService) do (
  reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%z" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
DISM.exe /Online /Enable-Feature /FeatureName:"Printing-PrintToPDFServices-Features" /NoRestart >nul 2>&1
DISM.exe /Online /Enable-Feature /FeatureName:"Printing-Foundation-Features" /NoRestart >nul 2>&1
DISM.exe /Online /Enable-Feature /FeatureName:"Printing-Foundation-InternetPrinting-Client" /NoRestart >nul 2>&1
echo Printing enabled, reboot.
pause & exit /b 0

echo.
echo [OK] Готово: Настроить печать
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
