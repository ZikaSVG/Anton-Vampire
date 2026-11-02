@echo off
:: https://privacy.sexy — v0.13.7 — Fri, 31 Jan 2025 14:23:08 GMT
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
:: -------Disable search's access to location (revert)-------
:: ----------------------------------------------------------
echo --- Disable search's access to location (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!AllowSearchToUseLocation"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'AllowSearchToUseLocation' /f 2>$null"
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search!AllowSearchToUseLocation"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'AllowSearchToUseLocation' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: Disable local search history (breaks recent suggestions) (revert)
echo --- Disable local search history (breaks recent suggestions) (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows\Explorer!DisableSearchHistory"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows\Explorer' /v 'DisableSearchHistory' /f 2>$null"
:: Delete the registry value "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings!IsDeviceSearchHistoryEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings' /v 'IsDeviceSearchHistoryEnabled' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: Disable sharing personal search data with Microsoft (revert)
echo --- Disable sharing personal search data with Microsoft (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!ConnectedSearchPrivacy"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'ConnectedSearchPrivacy' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: Disable personal cloud content search in taskbar (revert)-
:: ----------------------------------------------------------
echo --- Disable personal cloud content search in taskbar (revert)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings!IsMSACloudSearchEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings' /v 'IsMSACloudSearchEnabled' /f 2>$null"
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings!IsAADCloudSearchEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings' /v 'IsAADCloudSearchEnabled' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----------Disable Cortana during search (revert)----------
:: ----------------------------------------------------------
echo --- Disable Cortana during search (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!AllowCortana"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'AllowCortana' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----------Disable Cortana experience (revert)------------
:: ----------------------------------------------------------
echo --- Disable Cortana experience (revert)
:: Set the registry value "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana!value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = '1'; reg add 'HKLM\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana' /v 'value' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: Disable Cortana's access to cloud services such as OneDrive and SharePoint (revert)
echo --- Disable Cortana's access to cloud services such as OneDrive and SharePoint (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!AllowCloudSearch"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'AllowCloudSearch' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: Disable Cortana speech interaction while the system is locked (revert)
echo --- Disable Cortana speech interaction while the system is locked (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!AllowCortanaAboveLock"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'AllowCortanaAboveLock' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: Disable participation in Cortana data collection (revert)-
:: ----------------------------------------------------------
echo --- Disable participation in Cortana data collection (revert)
:: Delete the registry value "HKCU\Software\Microsoft\Windows\CurrentVersion\Search!CortanaConsent"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Search' /v 'CortanaConsent' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----------Disable enabling of Cortana (revert)-----------
:: ----------------------------------------------------------
echo --- Disable enabling of Cortana (revert)
:: Delete the registry value "HKCU\Software\Microsoft\Windows\CurrentVersion\Search!CanCortanaBeEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Search' /v 'CanCortanaBeEnabled' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----------Disable Cortana in start menu (revert)----------
:: ----------------------------------------------------------
echo --- Disable Cortana in start menu (revert)
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search!CortanaEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'CortanaEnabled' /f 2>$null"
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search!CortanaEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'CortanaEnabled' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Remove "Cortana" icon from taskbar (revert)--------
:: ----------------------------------------------------------
echo --- Remove "Cortana" icon from taskbar (revert)
:: Delete the registry value "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced!ShowCortanaButton"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' /v 'ShowCortanaButton' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable Cortana in ambient mode (revert)---------
:: ----------------------------------------------------------
echo --- Disable Cortana in ambient mode (revert)
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search!CortanaInAmbientMode"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'CortanaInAmbientMode' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable Cortana's history display (revert)--------
:: ----------------------------------------------------------
echo --- Disable Cortana's history display (revert)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search!HistoryViewEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'HistoryViewEnabled' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable Cortana's device history usage (revert)------
:: ----------------------------------------------------------
echo --- Disable Cortana's device history usage (revert)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search!DeviceHistoryEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'DeviceHistoryEnabled' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable "Hey Cortana" voice activation (revert)------
:: ----------------------------------------------------------
echo --- Disable "Hey Cortana" voice activation (revert)
:: Delete the registry value "HKCU\Software\Microsoft\Speech_OneCore\Preferences!VoiceActivationOn"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Speech_OneCore\Preferences' /v 'VoiceActivationOn' /f 2>$null"
:: Delete the registry value "HKLM\Software\Microsoft\Speech_OneCore\Preferences!VoiceActivationDefaultOn"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Microsoft\Speech_OneCore\Preferences' /v 'VoiceActivationDefaultOn' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Cortana keyboard shortcut (**Windows logo key** + **C**) (revert)
echo --- Disable Cortana keyboard shortcut (**Windows logo key** + **C**) (revert)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search!VoiceShortcut"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'VoiceShortcut' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable Cortana on locked device (revert)---------
:: ----------------------------------------------------------
echo --- Disable Cortana on locked device (revert)
:: Delete the registry value "HKCU\Software\Microsoft\Speech_OneCore\Preferences!VoiceActivationEnableAboveLockscreen"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Speech_OneCore\Preferences' /v 'VoiceActivationEnableAboveLockscreen' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable automatic update of speech data (revert)-----
:: ----------------------------------------------------------
echo --- Disable automatic update of speech data (revert)
:: Delete the registry value "HKCU\Software\Microsoft\Speech_OneCore\Preferences!ModelDownloadAllowed"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Speech_OneCore\Preferences' /v 'ModelDownloadAllowed' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Cortana voice support during Windows setup (revert)
echo --- Disable Cortana voice support during Windows setup (revert)
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE!DisableVoice"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE' /v 'DisableVoice' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable indexing of encrypted items (revert)-------
:: ----------------------------------------------------------
echo --- Disable indexing of encrypted items (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!AllowIndexingEncryptedStoresOrItems"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'AllowIndexingEncryptedStoresOrItems' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: Disable automatic language detection when indexing (revert)
echo --- Disable automatic language detection when indexing (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!AlwaysUseAutoLangDetection"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'AlwaysUseAutoLangDetection' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable remote access to search index (revert)------
:: ----------------------------------------------------------
echo --- Disable remote access to search index (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!PreventRemoteQueries"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'PreventRemoteQueries' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable iFilters and protocol handlers (revert)------
:: ----------------------------------------------------------
echo --- Disable iFilters and protocol handlers (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!PreventUnwantedAddIns"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'PreventUnwantedAddIns' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: Disable Bing search and recent search suggestions (breaks search history) (revert)
echo --- Disable Bing search and recent search suggestions (breaks search history) (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer!DisableSearchBoxSuggestions"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer' /v 'DisableSearchBoxSuggestions' /f 2>$null"
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search!DisableSearchBoxSuggestions"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'DisableSearchBoxSuggestions' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable Bing search in start menu (revert)--------
:: ----------------------------------------------------------
echo --- Disable Bing search in start menu (revert)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search!BingSearchEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'BingSearchEnabled' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable web search in search bar (revert)---------
:: ----------------------------------------------------------
echo --- Disable web search in search bar (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!DisableWebSearch"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'DisableWebSearch' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable web results in Windows Search (revert)------
:: ----------------------------------------------------------
echo --- Disable web results in Windows Search (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!ConnectedSearchUseWeb"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'ConnectedSearchUseWeb' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!ConnectedSearchUseWebOverMeteredConnections"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'ConnectedSearchUseWebOverMeteredConnections' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable Windows search highlights (revert)--------
:: ----------------------------------------------------------
echo --- Disable Windows search highlights (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search!EnableDynamicContentInWSB"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'EnableDynamicContentInWSB' /f 2>$null"
:: Delete the registry value "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings!IsDynamicSearchBoxEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings' /v 'IsDynamicSearchBoxEnabled' /f 2>$null"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully