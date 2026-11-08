@echo off
reg delete "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Control Panel\Desktop" /v "LowLevelHooksTimeout" /f >nul 2>&1
