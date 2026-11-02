@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "PreventIndexOnBattery" /f >nul 2>&1
