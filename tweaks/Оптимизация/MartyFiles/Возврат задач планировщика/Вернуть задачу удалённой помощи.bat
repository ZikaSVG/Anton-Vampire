@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul