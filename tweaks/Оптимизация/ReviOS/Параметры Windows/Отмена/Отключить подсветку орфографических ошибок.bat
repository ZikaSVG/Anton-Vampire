@echo off
reg delete "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableSpellchecking" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableSpellchecking" /f >nul 2>&1
