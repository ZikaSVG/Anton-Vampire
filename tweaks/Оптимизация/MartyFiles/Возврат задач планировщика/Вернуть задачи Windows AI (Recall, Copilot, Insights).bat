@echo off
chcp 866 >nul

:: Вернуть задачи: Windows AI (Recall, Copilot, Insights)
for %%T in (
    "\Microsoft\Windows\WindowsAI\Recall\InitialConfiguration"
    "\Microsoft\Windows\WindowsAI\Recall\PolicyConfiguration"
    "\Microsoft\Windows\WindowsAI\Settings\InitialConfiguration"
    "\Microsoft\Windows\WindowsAI\Copilot\CopilotDataCollectionTask"
    "\Microsoft\Windows\WindowsAI\Insights\InsightsDataCollectionTask"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul
