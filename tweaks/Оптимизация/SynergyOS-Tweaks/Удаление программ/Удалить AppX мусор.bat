@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить AppX мусор

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Удалить AppX мусор
echo.

:: --- Удалить AppX-пакеты из списка
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$names=@('3DViewer','Apprep.Chx','AssignedAccessLockApp','Bing','CamoStudio','Clipchamp','CloudExperienceHost','CommsPhone','ConnectivityStore','ContentDeliveryManager','Disney','FeedbackHub','Getstarted','Microsoft.549981C3F5F10','Microsoft.Calculator','Microsoft.GetHelp','Microsoft.Messaging','Microsoft.OneConnect','Microsoft.People','Microsoft.Todos','Microsoft.WindowsAlarms','MicrosoftOfficeHub','MicrosoftTeams','MSTeams','MixedReality','OneDrive','OneNote','OOBENetwork','OutlookForWindows','Parental','PeopleExperienceHost','Photos','PinningConfirmationDialog','PowerAutomate','QuickAssist','SecHealthUI','SecureAssessmentBrowser','SkypeApp','Solit','Spotify','Sticky','StorePurchaseApp','Sway','Wallet','Windows.DevHome','WindowsCamera','windowscommunicationsapps','WindowsMaps','WindowsPhone','WindowsSoundRecorder','YourPhone','Zune','MicrosoftFamily','Microsoft.Copilot','CopilotNudges');" ^
  "foreach($n in $names){" ^
  "  Get-AppxPackage -AllUsers -Name (\"*\"+$n+\"*\") -EA 0 | ForEach-Object {" ^
  "    try { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -EA 0 } catch {}" ^
  "  };" ^
  "  Get-AppxProvisionedPackage -Online -EA 0 | Where-Object { $_.DisplayName -like (\"*\"+$n+\"*\") } | ForEach-Object {" ^
  "    try { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -EA 0 } catch {}" ^
  "  }" ^
  "}" >nul 2>&1

echo.
echo [OK] Готово: Удалить AppX мусор
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
