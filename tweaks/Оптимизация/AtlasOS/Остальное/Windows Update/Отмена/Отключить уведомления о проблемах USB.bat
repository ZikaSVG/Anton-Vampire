@echo off
reg delete "HKCU\SOFTWARE\Microsoft\Shell\USB" /v "NotifyOnUsbErrors" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Shell\USB" /v "NotifyOnWeakCharger" /f >nul 2>&1
