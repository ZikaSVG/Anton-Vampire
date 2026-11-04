@echo off
dism /Online /Remove-Capability /CapabilityName:Microsoft.Windows.Notepad.System~~~~0.0.1.0 /NoRestart >nul 2>&1
