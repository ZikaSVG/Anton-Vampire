@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\Feedback\Siuf\DmClient"
    "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
    "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioUpload"
    "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioRun"
    "\Microsoft\Windows\Feedback\Siuf\DmClientOnUserSignIn"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul