@echo off
reg delete "HKCU\Software\Microsoft\Input\Settings" /v "EnableHwkbTextPrediction" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Input\Settings" /v "EnableHwkbTextPrediction" /f >nul 2>&1
