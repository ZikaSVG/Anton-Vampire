@echo off
chcp 866 >nul

:: Отключить задачи синхронизации языка и установки языковых компонентов
for %%T in (
    "\Microsoft\Windows\International\Synchronize Language Settings"
    "\Microsoft\Windows\LanguageComponentsInstaller\Installation"
    "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources"
    "\Microsoft\Windows\LanguageComponentsInstaller\Uninstallation"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul