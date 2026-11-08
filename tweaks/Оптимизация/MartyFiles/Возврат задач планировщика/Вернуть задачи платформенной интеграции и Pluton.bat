@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\PI\Secure-Boot-Update"
    "\Microsoft\Windows\PI\Sqm-Tasks"
    "\Microsoft\Windows\Pluton\Pluton-Ksp-Provisioning"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul