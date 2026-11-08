@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\International\Synchronize Language Settings"
    "\Microsoft\Windows\LanguageComponentsInstaller\Installation"
    "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources"
    "\Microsoft\Windows\LanguageComponentsInstaller\Uninstallation"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul