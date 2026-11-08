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
:: -------------Disable Copilot feature (revert)-------------
:: ----------------------------------------------------------
echo --- Disable Copilot feature (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot!TurnOffWindowsCopilot"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot' /v 'TurnOffWindowsCopilot' /f 2>$null"
:: Delete the registry value "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot!TurnOffWindowsCopilot"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot' /v 'TurnOffWindowsCopilot' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable Copilot access (revert)--------------
:: ----------------------------------------------------------
echo --- Disable Copilot access (revert)
:: Delete the registry value "HKCU\Software\Microsoft\Windows\Shell\Copilot\BingChat!IsUserEligible"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Windows\Shell\Copilot\BingChat' /v 'IsUserEligible' /f 2>$null"
:: Suggest restarting computer for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'For the changes to fully take effect, please restart your computer.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable Copilot auto-launch on start (revert)-------
:: ----------------------------------------------------------
echo --- Disable Copilot auto-launch on start (revert)
:: Delete the registry value "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings!AutoOpenCopilotLargeScreens"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings' /v 'AutoOpenCopilotLargeScreens' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Remove "Copilot" icon from taskbar (revert)--------
:: ----------------------------------------------------------
echo --- Remove "Copilot" icon from taskbar (revert)
:: Delete the registry value "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced!ShowCopilotButton"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' /v 'ShowCopilotButton' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully