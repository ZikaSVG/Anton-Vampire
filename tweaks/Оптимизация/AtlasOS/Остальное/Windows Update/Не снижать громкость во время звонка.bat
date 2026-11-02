@echo off
reg add "HKCU\SOFTWARE\Microsoft\Multimedia\Audio" /v "UserDuckingPreference" /t REG_DWORD /d 3 /f >nul 2>&1
