@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
    "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
    "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
    "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM"
    "\Microsoft\Windows\Customer Experience Improvement Program\Uploader"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul