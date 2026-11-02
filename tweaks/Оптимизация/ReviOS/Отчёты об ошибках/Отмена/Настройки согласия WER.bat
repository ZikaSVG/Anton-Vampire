@echo off
reg delete "HKLM\Software\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultConsent" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultOverrideBehavior" /f >nul 2>&1
