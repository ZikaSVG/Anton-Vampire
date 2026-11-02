@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /v "SchUseStrongCrypto" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v2.0.50727" /v "SchUseStrongCrypto" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /v "SchUseStrongCrypto" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319" /v "SchUseStrongCrypto" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
