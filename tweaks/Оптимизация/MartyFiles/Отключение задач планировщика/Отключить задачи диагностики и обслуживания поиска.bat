@echo off
chcp 866 >nul

:: Отключить задачи диагностики и обслуживания поиска
for %%T in (
    "\Microsoft\Windows\Search\IndexerDiagnosticsTask"
    "\Microsoft\Windows\Search\SearchIndexerMaintenance"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul