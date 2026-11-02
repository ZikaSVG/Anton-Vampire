@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ManagePreviewBuilds" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ManagePreviewBuildsPolicyValue" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "EnableConfigFlighting" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "EnableExperimentation" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v "HideInsiderPage" /f >nul 2>&1
