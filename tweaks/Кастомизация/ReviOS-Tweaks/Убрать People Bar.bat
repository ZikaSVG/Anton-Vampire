@echo off
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "HidePeopleBar" /t REG_DWORD /d "1" /f
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\Explorer" /v "HidePeopleBar" /t REG_DWORD /d "1" /f
