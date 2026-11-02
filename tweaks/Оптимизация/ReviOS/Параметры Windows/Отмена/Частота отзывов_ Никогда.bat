@echo off
reg delete "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /f >nul 2>&1
