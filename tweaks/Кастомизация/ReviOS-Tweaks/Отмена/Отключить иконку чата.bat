@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" /v "ChatIcon" /f >nul 2>&1
