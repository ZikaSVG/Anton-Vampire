@echo off
reg add "HKCU\Control Panel\Desktop" /v "ActiveWndTrkTimeout" /t REG_DWORD /d "10" /f
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "ActiveWndTrkTimeout" /t REG_DWORD /d "10" /f
