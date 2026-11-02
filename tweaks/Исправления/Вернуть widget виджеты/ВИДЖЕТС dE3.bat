@echo off
:: https://privacy.sexy — v0.13.7 — Wed, 23 Apr 2025 12:58:32 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
    )
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: ----------------------------------------------------------
:: ----------Remove "Widgets" from taskbar (revert)----------
:: ----------------------------------------------------------
echo --- Remove "Widgets" from taskbar (revert)
:: Delete the registry value "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced!TaskbarDa"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' /v 'TaskbarDa' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: Remove "Windows Web Experience Pack" (breaks Widgets) (revert)
echo --- Remove "Windows Web Experience Pack" (breaks Widgets) (revert)
:: Reinstall 'MicrosoftWindows.Client.WebExperience' if it was previously uninstalled
:: Remove 'MicrosoftWindows.Client.WebExperience' from deprovisioned list to allow reinstall during updates.
:: Restore "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy" registry key by deleting it
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully