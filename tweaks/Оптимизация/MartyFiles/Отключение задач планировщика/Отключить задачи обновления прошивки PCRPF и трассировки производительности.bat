@echo off
chcp 866 >nul

:: Отключить задачи обновления прошивки PCRPF и трассировки производительности
for %%T in (
    "\Microsoft\Windows\PCRPF\PCR Prediction Framework Firmware Update Task"
    "\Microsoft\Windows\PerformanceTrace\WhesvcToast"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul