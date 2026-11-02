@echo off
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Context\CloudExperienceHostIntent\Wireless" /v "ScoobeCheckCompleted" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Context\CloudExperienceHostIntent\Wireless" /v "ScoobeCheckCompleted" /f >nul 2>&1
