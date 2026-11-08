@echo off
title VainOS Tweak
:: ---
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue useplatformtick >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
bcdedit /set bootmenupolicy Standard >nul 2>&1
bcdedit /set "{current}" nx optin >nul 2>&1
bcdedit /set "{current}" recoveryenabled yes >nul 2>&1
bcdedit /deletevalue "{current}" disableelamdrivers >nul 2>&1
bcdedit /set "{current}" integrityservices enable >nul 2>&1
:: ---
echo Done.
pause
exit /b
