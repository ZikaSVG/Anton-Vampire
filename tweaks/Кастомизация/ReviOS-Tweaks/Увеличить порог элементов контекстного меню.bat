@echo off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "MultipleInvokePromptMinimum" /t REG_DWORD /d "100" /f
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "MultipleInvokePromptMinimum" /t REG_DWORD /d "100" /f
