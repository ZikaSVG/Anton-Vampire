@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "SkipMachineOOBE" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "SkipMachineOOBE" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "SkipUserOOBE" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "SkipUserOOBE" /t REG_DWORD /d "0" /f
