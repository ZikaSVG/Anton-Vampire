@echo off
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "PenWorkspaceAppSuggestionsEnabled" /f >nul 2>&1
