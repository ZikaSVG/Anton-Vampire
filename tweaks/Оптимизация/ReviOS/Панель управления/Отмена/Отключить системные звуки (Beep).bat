@echo off
reg add "HKCU\Control Panel\Sound" /v "Beep" /t REG_SZ /d "yes" /f
reg add "HKU\.DEFAULT\Control Panel\Sound" /v "Beep" /t REG_SZ /d "yes" /f
