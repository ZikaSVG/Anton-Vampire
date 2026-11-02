@echo off
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f
