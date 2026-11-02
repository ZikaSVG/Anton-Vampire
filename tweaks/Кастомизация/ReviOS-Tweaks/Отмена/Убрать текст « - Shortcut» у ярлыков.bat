@echo off
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /f >nul 2>&1
reg delete "HKU\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /f >nul 2>&1
