@echo off
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "1" /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "6" /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "10" /f
reg add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "1" /f
reg add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "6" /f
reg add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "10" /f
