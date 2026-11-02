@echo off
reg delete "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /f >nul 2>&1
