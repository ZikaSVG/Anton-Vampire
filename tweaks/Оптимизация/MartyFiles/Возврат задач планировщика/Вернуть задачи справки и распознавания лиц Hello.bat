@echo off
chcp 866 >nul

:: Вернуть задачи: справки и распознавания лиц Hello
for %%T in (
    "\Microsoft\Windows\Help\OEMSupport"
    "\Microsoft\Windows\Help\WindowsHelpUpdateTask"
    "\Microsoft\Windows\HelloFace\FODCleanupTask"
    "\Microsoft\Windows\HelloFace\FeatureCleanup"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul
