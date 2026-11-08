@echo off
reg delete "HKCU\Control Panel\UnsupportedHardwareNotificationCache" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /f >nul 2>&1
