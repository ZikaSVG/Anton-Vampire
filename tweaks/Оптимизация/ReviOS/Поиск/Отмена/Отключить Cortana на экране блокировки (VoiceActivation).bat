@echo off
reg delete "HKLM\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /v "VoiceActivationEnableAboveLockscreen" /f >nul 2>&1
