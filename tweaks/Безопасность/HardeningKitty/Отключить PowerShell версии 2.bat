@echo off
title PowerShell v2
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root -NoRestart -ErrorAction SilentlyContinue"
echo [+] PowerShell v2 отключён.
