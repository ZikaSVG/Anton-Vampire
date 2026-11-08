@echo off
chcp 866 >nul

:: Вернуть задачу: оптимизации уровней хранения
for %%T in (
    "\Microsoft\Windows\Storage Tiers Management\Storage Tiers Optimization"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul
