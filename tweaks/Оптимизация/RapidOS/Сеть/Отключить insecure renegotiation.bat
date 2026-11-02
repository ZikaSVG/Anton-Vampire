@echo off
title RapidOS Tweak
:: ---
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /v "AllowInsecureRenegoClients" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /v "AllowInsecureRenegoServers" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /v "DisableRenegoOnServer" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /v "DisableRenegoOnClient" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /v "UseScsvForTls" /t REG_DWORD /d 1 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
