@echo off
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "SignInMode" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "TabletMode" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "ConvertibleSlateModePromptPreference" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "SignInMode" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "TabletMode" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "ConvertibleSlateModePromptPreference" /f >nul 2>&1
