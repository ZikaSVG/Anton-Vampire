@echo off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d "0" /f
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Context\CloudExperienceHostIntent\Wireless" /v "ScoobeCheckCompleted" /t REG_DWORD /d "1" /f
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Context\CloudExperienceHostIntent\Wireless" /v "ScoobeCheckCompleted" /t REG_DWORD /d "1" /f
