@echo off
reg delete "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableTextPrediction" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableTextPrediction" /f >nul 2>&1
