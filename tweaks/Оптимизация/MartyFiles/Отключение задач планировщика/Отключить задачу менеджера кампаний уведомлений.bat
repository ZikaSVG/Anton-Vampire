@echo off
chcp 866 >nul

:: Отключить задачу: менеджера кампаний уведомлений
for %%T in (
    "\Microsoft\Windows\UNP\RunCampaignManager"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul
