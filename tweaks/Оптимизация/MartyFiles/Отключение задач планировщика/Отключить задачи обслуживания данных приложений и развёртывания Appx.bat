@echo off
chcp 866 >nul

:: Отключить задачи обслуживания данных приложений и развёртывания Appx
for %%T in (
    "\Microsoft\Windows\ApplicationData\appuriverifierdaily"
    "\Microsoft\Windows\ApplicationData\appuriverifierinstall"
    "\Microsoft\Windows\ApplicationData\DsSvcCleanup"
    "\Microsoft\Windows\AppxDeploymentClient\Pre-staged app cleanup"
    "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul