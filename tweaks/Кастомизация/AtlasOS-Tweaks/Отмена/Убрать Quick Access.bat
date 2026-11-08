@echo off
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v HubMode /f >nul 2>&1
