@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner"
    "\Microsoft\Windows\Diagnosis\Scheduled"
    "\Microsoft\Windows\Diagnosis\UnexpectedCodepath"
    "\Microsoft\Windows\DiskCleanup\SilentCleanup"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

for %%T in (
    "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
    "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver"
    "\Microsoft\Windows\DiskDiagnostic\DiagnosticResolver"
    "\Microsoft\Windows\DiskDiagnostic\DiskDiagnostic"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul