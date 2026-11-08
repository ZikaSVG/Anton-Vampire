@echo off
reg delete "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableAutocorrection" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableAutocorrection" /f >nul 2>&1
