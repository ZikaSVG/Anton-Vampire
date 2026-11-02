@echo off
reg add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f
