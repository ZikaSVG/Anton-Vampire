@echo off
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /f >nul 2>&1
reg delete "HKU\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /f >nul 2>&1
