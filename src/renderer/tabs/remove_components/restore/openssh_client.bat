@echo off
dism /Online /Add-Capability /CapabilityName:OpenSSH.Client~~~~0.0.1.0 /NoRestart >nul 2>&1
