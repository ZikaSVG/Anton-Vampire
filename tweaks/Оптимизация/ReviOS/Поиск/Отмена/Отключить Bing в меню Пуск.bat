@echo off
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f >nul 2>&1
