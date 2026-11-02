@echo off
title RapidOS Tweak
:: ---
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman" /v "ServerMinKeyBitLength" /t REG_DWORD /d 2048 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman" /v "ClientMinKeyBitLength" /t REG_DWORD /d 2048 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
