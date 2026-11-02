@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить полный список задач планировщика

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить полный список задач планировщика
echo.

for %%T in (
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task"
  "\Microsoft\Windows\WaaSMedic\PerformRemediation"
  "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
  "\Microsoft\Windows\WindowsUpdate\sih"
  "\Microsoft\Windows\WindowsUpdate\sihboot"
  "\Microsoft\Windows\WindowsUpdate\sihpostreboot"
) do schtasks /Change /TN "%%~T" /Enable >nul 2>&1

echo.
echo [OK] Отменено: Включить полный список задач планировщика
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
