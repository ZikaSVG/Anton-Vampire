@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /v "AllowInsecureRenegoClients" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /v "AllowInsecureRenegoServers" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /v "DisableRenegoOnServer" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /v "DisableRenegoOnClient" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /v "UseScsvForTls" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
