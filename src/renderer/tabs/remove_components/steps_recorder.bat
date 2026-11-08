@echo off
dism /Online /Remove-Capability /CapabilityName:StepsRecorder~~~~0.0.1.0 /NoRestart >nul 2>&1
