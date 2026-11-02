@echo off
:: https://privacy.sexy — v0.13.7 — Sun, 16 Feb 2025 22:38:06 GMT
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
:: ---------Disable app access to location (revert)----------
:: ----------------------------------------------------------
echo --- Disable app access to location (revert)
:: Restore app access (LetAppsAccessLocation) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessLocation"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessLocation' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessLocation_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessLocation_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessLocation_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessLocation_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessLocation_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessLocation_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (location) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Set the registry value "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration!Status"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = '1'; reg add 'HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration' /v 'Status' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: Restore app access ({BFA794E4-F964-4FDB-90F6-51056BFE4B44}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}' /v 'Value' /f 2>$null"
:: Restore app access ({E6AD100E-5F4E-44CD-BE0F-2265D88D14F5}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E6AD100E-5F4E-44CD-BE0F-2265D88D14F5}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E6AD100E-5F4E-44CD-BE0F-2265D88D14F5}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: Disable app access to account information, name, and picture (revert)
echo --- Disable app access to account information, name, and picture (revert)
:: Restore app access (LetAppsAccessAccountInfo) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessAccountInfo"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessAccountInfo' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessAccountInfo_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessAccountInfo_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessAccountInfo_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessAccountInfo_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessAccountInfo_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessAccountInfo_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (userAccountInformation) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access ({C1D23ACC-752B-43E5-8448-8D0E519CD6D6}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable app access to motion activity (revert)------
:: ----------------------------------------------------------
echo --- Disable app access to motion activity (revert)
:: Restore app access (LetAppsAccessMotion) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessMotion"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMotion' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessMotion_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMotion_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessMotion_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMotion_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessMotion_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMotion_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (activity) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable app access to trusted devices (revert)------
:: ----------------------------------------------------------
echo --- Disable app access to trusted devices (revert)
:: Restore app access (LetAppsAccessTrustedDevices) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessTrustedDevices"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTrustedDevices' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessTrustedDevices_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTrustedDevices_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessTrustedDevices_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTrustedDevices_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessTrustedDevices_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTrustedDevices_ForceDenyTheseApps' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable app access to unpaired wireless devices (revert)-
:: ----------------------------------------------------------
echo --- Disable app access to unpaired wireless devices (revert)
:: Restore app access (LetAppsSyncWithDevices) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsSyncWithDevices"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsSyncWithDevices' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsSyncWithDevices_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsSyncWithDevices_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsSyncWithDevices_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsSyncWithDevices_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsSyncWithDevices_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsSyncWithDevices_ForceDenyTheseApps' /f 2>$null"
:: Restore app access (LooselyCoupled) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----------Disable app access to camera (revert)-----------
:: ----------------------------------------------------------
echo --- Disable app access to camera (revert)
:: Restore app access (LetAppsAccessCamera) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessCamera"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCamera' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessCamera_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCamera_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessCamera_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCamera_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessCamera_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCamera_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (webcam) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access ({E5323777-F976-4f5b-9B55-B94699C46E44}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: Disable app access to microphone (breaks Sound Recorder) (revert)
echo --- Disable app access to microphone (breaks Sound Recorder) (revert)
:: Restore app access (LetAppsAccessMicrophone) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessMicrophone"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMicrophone' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessMicrophone_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMicrophone_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessMicrophone_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMicrophone_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessMicrophone_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMicrophone_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (microphone) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access ({2EEF81BE-33FA-4800-9670-1CD474972C3F}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: Disable app access to information about other apps (revert)
echo --- Disable app access to information about other apps (revert)
:: Restore app access (LetAppsGetDiagnosticInfo) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsGetDiagnosticInfo"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsGetDiagnosticInfo' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsGetDiagnosticInfo_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsGetDiagnosticInfo_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsGetDiagnosticInfo_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsGetDiagnosticInfo_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsGetDiagnosticInfo_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsGetDiagnosticInfo_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (appDiagnostics) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access ({2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable app access to your contacts (revert)-------
:: ----------------------------------------------------------
echo --- Disable app access to your contacts (revert)
:: Restore app access (LetAppsAccessContacts) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessContacts"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessContacts' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessContacts_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessContacts_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessContacts_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessContacts_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessContacts_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessContacts_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (contacts) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access ({7D7E8402-7C54-4821-A34E-AEEFD62DED93}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable app access to notifications (revert)-------
:: ----------------------------------------------------------
echo --- Disable app access to notifications (revert)
:: Restore app access (LetAppsAccessNotifications) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessNotifications"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessNotifications' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessNotifications_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessNotifications_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessNotifications_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessNotifications_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessNotifications_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessNotifications_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (userNotificationListener) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access ({52079E78-A92B-413F-B213-E8FE35712E72}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable app access to calendar (revert)----------
:: ----------------------------------------------------------
echo --- Disable app access to calendar (revert)
:: Restore app access (LetAppsAccessCalendar) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessCalendar"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCalendar' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessCalendar_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCalendar_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessCalendar_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCalendar_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessCalendar_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCalendar_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (appointments) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access ({D89823BA-7180-4B81-B50C-7E471E6121A3}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----------Disable app access to email (revert)-----------
:: ----------------------------------------------------------
echo --- Disable app access to email (revert)
:: Restore app access (LetAppsAccessEmail) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessEmail"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessEmail' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessEmail_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessEmail_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessEmail_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessEmail_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessEmail_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessEmail_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (email) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access ({9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----------Disable app access to tasks (revert)-----------
:: ----------------------------------------------------------
echo --- Disable app access to tasks (revert)
:: Restore app access (LetAppsAccessTasks) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessTasks"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTasks' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessTasks_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTasks_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessTasks_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTasks_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessTasks_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTasks_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (userDataTasks) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access ({E390DF20-07DF-446D-B962-F5C953062741}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E390DF20-07DF-446D-B962-F5C953062741}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E390DF20-07DF-446D-B962-F5C953062741}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----------Disable app access to radios (revert)-----------
:: ----------------------------------------------------------
echo --- Disable app access to radios (revert)
:: Restore app access (LetAppsAccessRadios) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessRadios"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessRadios' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessRadios_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessRadios_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessRadios_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessRadios_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessRadios_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessRadios_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (radios) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access ({A8804298-2D5F-42E3-9531-9C8C39EB29CE}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable app access to physical movement (revert)-----
:: ----------------------------------------------------------
echo --- Disable app access to physical movement (revert)
:: Restore app access (LetAppsAccessBackgroundSpatialPerception) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessBackgroundSpatialPerception"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessBackgroundSpatialPerception' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessBackgroundSpatialPerception_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessBackgroundSpatialPerception_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessBackgroundSpatialPerception_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessBackgroundSpatialPerception_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessBackgroundSpatialPerception_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessBackgroundSpatialPerception_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (spatialPerception) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\spatialPerception!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\spatialPerception' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app capability (backgroundSpatialPerception) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\backgroundSpatialPerception!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\backgroundSpatialPerception' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable app access to eye tracking (revert)--------
:: ----------------------------------------------------------
echo --- Disable app access to eye tracking (revert)
:: Restore app access (LetAppsAccessGazeInput) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessGazeInput"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGazeInput' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessGazeInput_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGazeInput_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessGazeInput_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGazeInput_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessGazeInput_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGazeInput_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (gazeInput) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\gazeInput!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\gazeInput' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable app access to human presence (revert)-------
:: ----------------------------------------------------------
echo --- Disable app access to human presence (revert)
:: Restore app access (LetAppsAccessHumanPresence) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessHumanPresence"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessHumanPresence' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessHumanPresence_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessHumanPresence_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessHumanPresence_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessHumanPresence_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessHumanPresence_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessHumanPresence_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (humanPresence) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\humanPresence!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\humanPresence' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable app access to screen capture (revert)-------
:: ----------------------------------------------------------
echo --- Disable app access to screen capture (revert)
:: Restore app access (LetAppsAccessGraphicsCaptureProgrammatic) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessGraphicsCaptureProgrammatic"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureProgrammatic' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessGraphicsCaptureProgrammatic_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureProgrammatic_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessGraphicsCaptureProgrammatic_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureProgrammatic_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessGraphicsCaptureProgrammatic_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureProgrammatic_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (graphicsCaptureProgrammatic) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureProgrammatic!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureProgrammatic' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access (LetAppsAccessGraphicsCaptureWithoutBorder) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessGraphicsCaptureWithoutBorder"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureWithoutBorder' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessGraphicsCaptureWithoutBorder_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureWithoutBorder_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessGraphicsCaptureWithoutBorder_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureWithoutBorder_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessGraphicsCaptureWithoutBorder_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureWithoutBorder_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (graphicsCaptureWithoutBorder) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureWithoutBorder!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureWithoutBorder' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: Disable app access to background activity (breaks Cortana, Search, live tiles, notifications) (revert)
echo --- Disable app access to background activity (breaks Cortana, Search, live tiles, notifications) (revert)
:: Restore app access (LetAppsRunInBackground) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsRunInBackground"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsRunInBackground' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsRunInBackground_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsRunInBackground_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsRunInBackground_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsRunInBackground_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsRunInBackground_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsRunInBackground_ForceDenyTheseApps' /f 2>$null"
:: Delete the registry value "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications!GlobalUserDisabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications' /v 'GlobalUserDisabled' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable app access to input devices (revert)-------
:: ----------------------------------------------------------
echo --- Disable app access to input devices (revert)
:: Restore app capability (humanInterfaceDevice) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\humanInterfaceDevice!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\humanInterfaceDevice' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Disable app access to "Documents" folder (revert)-----
:: ----------------------------------------------------------
echo --- Disable app access to "Documents" folder (revert)
:: Restore app capability (documentsLibrary) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable app access to "Pictures" folder (revert)-----
:: ----------------------------------------------------------
echo --- Disable app access to "Pictures" folder (revert)
:: Restore app capability (picturesLibrary) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable app access to "Videos" folder (revert)------
:: ----------------------------------------------------------
echo --- Disable app access to "Videos" folder (revert)
:: Restore app capability (videosLibrary) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable app access to "Music" folder (revert)-------
:: ----------------------------------------------------------
echo --- Disable app access to "Music" folder (revert)
:: Restore app capability (musicLibrary) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\musicLibrary!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\musicLibrary' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable app access to personal files (revert)-------
:: ----------------------------------------------------------
echo --- Disable app access to personal files (revert)
:: Restore app capability (broadFileSystemAccess) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable app access to call history (revert)--------
:: ----------------------------------------------------------
echo --- Disable app access to call history (revert)
:: Restore app access (LetAppsAccessCallHistory) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessCallHistory"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCallHistory' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessCallHistory_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCallHistory_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessCallHistory_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCallHistory_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessCallHistory_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCallHistory_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (phoneCallHistory) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access ({8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: Disable app access to phone calls (breaks phone calls through Phone Link) (revert)
echo --- Disable app access to phone calls (breaks phone calls through Phone Link) (revert)
:: Restore app access (LetAppsAccessPhone) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessPhone"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessPhone' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessPhone_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessPhone_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessPhone_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessPhone_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessPhone_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessPhone_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (phoneCall) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---Disable app access to messaging (SMS / MMS) (revert)---
:: ----------------------------------------------------------
echo --- Disable app access to messaging (SMS / MMS) (revert)
:: Restore app access (LetAppsAccessMessaging) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessMessaging"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMessaging' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessMessaging_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMessaging_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessMessaging_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMessaging_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsAccessMessaging_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMessaging_ForceDenyTheseApps' /f 2>$null"
:: Restore app capability (chat) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: Restore app access ({992AFA70-6F47-4148-B3E9-3003349C1548}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}' /v 'Value' /f 2>$null"
:: Restore app access ({21157C1F-2651-4CC1-90CA-1F28B02263F6}) in older Windows versions (before 1903)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{21157C1F-2651-4CC1-90CA-1F28B02263F6}!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{21157C1F-2651-4CC1-90CA-1F28B02263F6}' /v 'Value' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable app access to paired Bluetooth devices (revert)--
:: ----------------------------------------------------------
echo --- Disable app access to paired Bluetooth devices (revert)
:: Restore app capability (bluetooth) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetooth!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetooth' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: Disable app access to unpaired Bluetooth devices (revert)-
:: ----------------------------------------------------------
echo --- Disable app access to unpaired Bluetooth devices (revert)
:: Restore app capability (bluetoothSync) using user privacy settings
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync!Value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = 'Allow'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync' /v 'Value' /t 'REG_SZ' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable app access to voice activation (revert)------
:: ----------------------------------------------------------
echo --- Disable app access to voice activation (revert)
:: Restore app access (LetAppsActivateWithVoice) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsActivateWithVoice"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoice' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsActivateWithVoice_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoice_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsActivateWithVoice_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoice_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsActivateWithVoice_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoice_ForceDenyTheseApps' /f 2>$null"
:: Delete the registry value "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps!AgentActivationEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps' /v 'AgentActivationEnabled' /f 2>$null"
:: ----------------------------------------------------------
:: Disable app access to voice activation on locked system (revert)
echo --- Disable app access to voice activation on locked system (revert)
:: Restore app access (LetAppsActivateWithVoiceAboveLock) using GPO
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsActivateWithVoiceAboveLock"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoiceAboveLock' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsActivateWithVoiceAboveLock_UserInControlOfTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoiceAboveLock_UserInControlOfTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsActivateWithVoiceAboveLock_ForceAllowTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoiceAboveLock_ForceAllowTheseApps' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy!LetAppsActivateWithVoiceAboveLock_ForceDenyTheseApps"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoiceAboveLock_ForceDenyTheseApps' /f 2>$null"
:: Delete the registry value "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps!AgentActivationOnLockScreenEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps' /v 'AgentActivationOnLockScreenEnabled' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Customer Experience Improvement Program data collection (revert)
echo --- Disable Customer Experience Improvement Program data collection (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\SQMClient\Windows!CEIPEnable"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\SQMClient\Windows' /v 'CEIPEnable' /f 2>$null"
:: Set the registry value "HKLM\Software\Microsoft\SQMClient\Windows!CEIPEnable"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = '0'; reg add 'HKLM\Software\Microsoft\SQMClient\Windows' /v 'CEIPEnable' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: Disable Customer Experience Improvement Program data uploads (revert)
echo --- Disable Customer Experience Improvement Program data uploads (revert)
:: Delete the registry value "HKLM\Software\Microsoft\SQMClient!UploadDisableFlag"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Microsoft\SQMClient' /v 'UploadDisableFlag' /f 2>$null"
:: ----------------------------------------------------------
:: Disable automatic Software Quality Metrics (SQM) data transmission (revert)
echo --- Disable automatic Software Quality Metrics (SQM) data transmission (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Autochk\Proxy`
:: ----------------------------------------------------------
:: Disable kernel-level customer experience data collection (revert)
echo --- Disable kernel-level customer experience data collection (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable Bluetooth usage data collection (revert)-----
:: ----------------------------------------------------------
echo --- Disable Bluetooth usage data collection (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Customer Experience Improvement Program\BthSQM`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable disk diagnostic data collection (revert)-----
:: ----------------------------------------------------------
echo --- Disable disk diagnostic data collection (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---Disable disk diagnostic user notifications (revert)----
:: ----------------------------------------------------------
echo --- Disable disk diagnostic user notifications (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----------Disable USB data collection (revert)-----------
:: ----------------------------------------------------------
echo --- Disable USB data collection (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable customer experience data consolidation (revert)--
:: ----------------------------------------------------------
echo --- Disable customer experience data consolidation (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Customer Experience Improvement Program\Consolidator`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Disable customer experience data uploads (revert)-----
:: ----------------------------------------------------------
echo --- Disable customer experience data uploads (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Customer Experience Improvement Program\Uploader`
:: ----------------------------------------------------------
:: Disable server customer experience data assistant (revert)
echo --- Disable server customer experience data assistant (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerCeipAssistant`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Disable server role telemetry collection (revert)-----
:: ----------------------------------------------------------
echo --- Disable server role telemetry collection (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerRoleCollector`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Disable server role usage data collection (revert)----
:: ----------------------------------------------------------
echo --- Disable server role usage data collection (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerRoleUsageCollector`
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully