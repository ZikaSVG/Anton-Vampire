@echo off
chcp 866 >nul

:: Отключить задачи оболочки (семейная безопасность, темы, обслуживание индекса)
for %%T in (
    "\Microsoft\Windows\Shell\FamilySafetyMonitor"
    "\Microsoft\Windows\Shell\FamilySafetyRefreshTask"
    "\Microsoft\Windows\Shell\IndexerAutomaticMaintenance"
    "\Microsoft\Windows\Shell\ThemeAssetTask_SyncFODState"
    "\Microsoft\Windows\Shell\ThemesSyncedImageDownload"
    "\Microsoft\Windows\Shell\UndockedFlightingUpdate"
    "\Microsoft\Windows\Shell\UpdateUserPictureTask"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul