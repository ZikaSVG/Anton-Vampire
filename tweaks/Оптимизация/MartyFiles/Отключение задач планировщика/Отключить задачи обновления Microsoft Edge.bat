@echo off
chcp 866 >nul

:: Отключить задачи: обновления Microsoft Edge
for %%T in (
    "\MicrosoftEdgeUpdateTaskMachineCore"
    "\MicrosoftEdgeUpdateTaskMachineUA"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul
