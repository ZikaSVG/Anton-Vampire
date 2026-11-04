@echo off
dism /Online /Remove-Capability /CapabilityName:OpenSSH.Client~~~~0.0.1.0 /NoRestart >nul 2>&1
