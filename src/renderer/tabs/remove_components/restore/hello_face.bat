@echo off
dism /Online /Add-Capability /CapabilityName:Hello.Face~~~~0.0.1.0 /NoRestart >nul 2>&1
