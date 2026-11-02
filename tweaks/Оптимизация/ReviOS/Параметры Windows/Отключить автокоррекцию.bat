@echo off
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableAutocorrection" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableAutocorrection" /t REG_DWORD /d "0" /f
