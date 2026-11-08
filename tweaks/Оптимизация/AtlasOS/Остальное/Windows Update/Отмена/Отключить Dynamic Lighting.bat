@echo off
reg delete "HKCU\Software\Microsoft\Lighting" /v "AmbientLightingEnabled" /f >nul 2>&1
