@echo off
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoStartMenuMFUprogramsList" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "ShowOrHideMostUsedApps" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HideRecentlyAddedApps" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HideRecommendedPersonalizedSites" /f >nul 2>&1
