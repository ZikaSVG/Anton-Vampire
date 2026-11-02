@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableGraphRecentItems" /f >nul 2>&1
