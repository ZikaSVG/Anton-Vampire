@echo off
reg delete "HKLM\Software\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /f >nul 2>&1
