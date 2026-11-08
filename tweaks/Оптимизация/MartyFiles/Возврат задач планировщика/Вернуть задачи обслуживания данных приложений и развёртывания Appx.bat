@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\ApplicationData\appuriverifierdaily"
    "\Microsoft\Windows\ApplicationData\appuriverifierinstall"
    "\Microsoft\Windows\ApplicationData\DsSvcCleanup"
    "\Microsoft\Windows\AppxDeploymentClient\Pre-staged app cleanup"
    "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul