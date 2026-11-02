@echo off
title RapidOS Tweak
:: ---
reg add "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "VRROptimizeEnable=0;SwapEffectUpgradeEnable=0;" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
