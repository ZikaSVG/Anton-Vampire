@echo off
reg delete "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /f >nul 2>&1
