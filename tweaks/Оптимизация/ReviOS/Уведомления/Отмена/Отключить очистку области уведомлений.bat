@echo off
reg delete "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "NoAutoTrayNotify" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\Explorer" /v "NoAutoTrayNotify" /f >nul 2>&1
