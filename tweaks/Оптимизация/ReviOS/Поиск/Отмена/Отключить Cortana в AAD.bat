@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaInAAD" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaInAADPathOOBE" /f >nul 2>&1
