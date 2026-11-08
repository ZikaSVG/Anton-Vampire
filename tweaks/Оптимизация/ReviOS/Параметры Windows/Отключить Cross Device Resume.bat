@echo off
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration" /v "IsResumeAllowed" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Connectivity\DisableCrossDeviceResume" /v "value" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\8\1387020943" /v "EnabledState" /t REG_DWORD /d "1" /f
