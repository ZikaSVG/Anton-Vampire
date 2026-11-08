@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\PCRPF\PCR Prediction Framework Firmware Update Task"
    "\Microsoft\Windows\PerformanceTrace\WhesvcToast"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul