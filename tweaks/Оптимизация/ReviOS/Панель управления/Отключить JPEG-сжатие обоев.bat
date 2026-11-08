@echo off
reg add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d "100" /f
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d "100" /f
