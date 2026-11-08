@echo off
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration" /v "IsResumeAllowed" /t REG_DWORD /d "1" /f
reg delete "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Connectivity\DisableCrossDeviceResume" /v "value" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\8\1387020943" /f >nul 2>&1
