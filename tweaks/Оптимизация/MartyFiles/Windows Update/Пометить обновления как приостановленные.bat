@echo off
reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\Settings" /v "PausedFeatureStatus" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\Settings" /v "PausedQualityStatus" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\Settings" /v "PausedQualityDate" /t REG_SZ /d "2077-07-07 13:00:00" /f >nul
reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\Settings" /v "PausedFeatureDate" /t REG_SZ /d "2077-07-07 13:00:00" /f >nul
