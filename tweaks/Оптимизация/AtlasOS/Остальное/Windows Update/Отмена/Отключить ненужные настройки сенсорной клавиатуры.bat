@echo off
reg delete "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableAutoShiftEngage" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableKeyAudioFeedback" /f >nul 2>&1
