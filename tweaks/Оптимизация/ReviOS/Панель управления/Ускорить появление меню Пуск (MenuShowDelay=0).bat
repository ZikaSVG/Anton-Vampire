@echo off
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f
