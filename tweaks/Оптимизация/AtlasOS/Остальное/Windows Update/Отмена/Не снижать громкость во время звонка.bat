@echo off
reg delete "HKCU\SOFTWARE\Microsoft\Multimedia\Audio" /v "UserDuckingPreference" /f >nul 2>&1
