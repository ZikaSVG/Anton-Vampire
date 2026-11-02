@echo off
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f
reg delete "HKCU\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f 2>nul
reg add "HKU\.DEFAULT\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f
reg delete "HKU\.DEFAULT\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f 2>nul
