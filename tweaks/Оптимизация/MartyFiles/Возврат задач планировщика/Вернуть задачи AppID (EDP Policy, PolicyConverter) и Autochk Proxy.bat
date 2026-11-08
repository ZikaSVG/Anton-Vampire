@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\AppID\EDP Policy Manager"
    "\Microsoft\Windows\AppID\PolicyConverter"
    "\Microsoft\Windows\Autochk\Proxy"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul