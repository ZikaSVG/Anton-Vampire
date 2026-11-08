@echo off
title RapidOS Tweak
:: ---
reg delete "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
