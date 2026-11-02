@echo off
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowCloudFilesInQuickAccess" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecommendations" /f >nul 2>&1
