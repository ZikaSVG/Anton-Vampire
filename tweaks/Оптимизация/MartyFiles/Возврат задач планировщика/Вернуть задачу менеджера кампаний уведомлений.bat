@echo off
chcp 866 >nul

:: Вернуть задачу: менеджера кампаний уведомлений
for %%T in (
    "\Microsoft\Windows\UNP\RunCampaignManager"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul
