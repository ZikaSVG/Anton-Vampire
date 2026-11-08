@echo off
title RapidOS Tweak
:: ---
for %%c in ("RC2 40/128" "RC2 56/128" "RC2 128/128" "RC4 40/128" "RC4 56/128" "RC4 64/128" "RC4 128/128" "DES 56/56" "Triple DES 168" "Triple DES 168/168" "NULL") do reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\%%~c" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
