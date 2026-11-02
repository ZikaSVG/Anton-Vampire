@echo off
chcp 866 >nul

:: Отключить задачу анализа энергоэффективности
for %%T in (
    "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul