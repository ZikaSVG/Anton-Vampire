@echo off
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /f >nul 2>&1
