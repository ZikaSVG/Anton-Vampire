@echo off
dism /Online /Add-Capability /CapabilityName:Media.WindowsMediaPlayer~~~~0.0.1.0 /NoRestart >nul 2>&1
