@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить задачи планировщика

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить задачи планировщика
echo.

for %%T in (
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Work"
  "\Microsoft\Windows\UpdateOrchestrator\UIEOrchestrator"
  "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask"
  "\Microsoft\Windows\UpdateOrchestrator\USO_Broker_Display"
  "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_Display"
  "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_ReadyToReboot"
  "\Microsoft\Windows\UpdateOrchestrator\Universal Orchestrator Start"
  "\Microsoft\Windows\UpdateOrchestrator\Universal Orchestrator Idle Start"
  "\Microsoft\Windows\WaaSMedic\PerformRemediation"
  "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
  "\Microsoft\Windows\WindowsError Reporting\QueueReporting"
) do schtasks /Change /TN "%%~T" /Enable >nul 2>&1

echo.
echo [OK] Отменено: Включить задачи планировщика
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
