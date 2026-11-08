@echo off
chcp 866 >nul

:: Вернуть задачи: обновления Microsoft Edge
for %%T in (
    "\MicrosoftEdgeUpdateTaskMachineCore"
    "\MicrosoftEdgeUpdateTaskMachineUA"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul
