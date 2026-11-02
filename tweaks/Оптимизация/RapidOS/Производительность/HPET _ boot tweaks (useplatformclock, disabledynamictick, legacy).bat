@echo off
title VainOS Tweak
:: ---
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue useplatformtick >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /set bootmenupolicy Legacy >nul 2>&1
bcdedit /set "{current}" nx optin >nul 2>&1
bcdedit /set "{current}" recoveryenabled no >nul 2>&1
bcdedit /set "{current}" disableelamdrivers yes >nul 2>&1
bcdedit /set "{current}" integrityservices disable >nul 2>&1
:: ---
echo Done.
pause
exit /b
