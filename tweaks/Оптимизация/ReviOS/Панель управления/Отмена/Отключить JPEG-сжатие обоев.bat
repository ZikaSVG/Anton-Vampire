@echo off
reg delete "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Control Panel\Desktop" /v "JPEGImportQuality" /f >nul 2>&1
