@echo off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CPSS\DevicePolicy\TailoredExperiencesWithDiagnosticDataEnabled" /v "DefaultValue" /t REG_DWORD /d "0" /f
