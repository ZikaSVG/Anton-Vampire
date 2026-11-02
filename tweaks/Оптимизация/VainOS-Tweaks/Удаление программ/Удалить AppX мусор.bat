@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить AppX мусор

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить AppX мусор
echo.

:: --- Удалить AppX-пакеты из списка
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$names=@('NcsiUwpApp','Microsoft.AVCEncoderVideoExtension','Microsoft.AV1VideoExtension','MicrosoftWindows.UndockedDevKit','Microsoft.MPEG2VideoExtension','Microsoft.ApplicationCompatibilityEnhancements','Microsoft.Windows.StartMenuExperienceHost','Microsoft.HEIFImageExtension','Microsoft.HEVCVideoExtension','Microsoft.VP9VideoExtensions','MicrosoftTeams','MSTeams','Clipchamp.Clipchamp','Microsoft.WindowsTerminal','MicrosoftWindows.LKG.AccountsService','MicrosoftWindows.LKG.RulesEngine','MicrosoftWindows.LKG.TwinSxS','MicrosoftWindows.LKG.Search','Microsoft.WebpImageExtension','Microsoft.WebMediaExtensions','Microsoft.RawImageExtension','WidgetsPlatformRuntime','MicrosoftWindows.LKG.DesktopSpotlight','Microsoft.Windows.AugLoop.CBS','MicrosoftWindows.LKG.IrisService','MicrosoftWindows.LKG.SpeechRuntime','ContentDeliveryManager','Microsoft.ECApp','Windows.CBSPreview','Microsoft.Lockapp','Microsoft.BioEnrollment','c5e2524a-ea46-4f67-841f-6a9465d9d515','F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE','Microsoft.Windows.SecureAssessmentBrowser','Microsoft.Windows.AssignedAccessLockApp','NarratorQuickStart','Microsoft.AsyncTextService','XGpuEjectDialog','PeopleExperienceHost','MicrosoftWindows.Client.AIX','ParentalControls','Microsoft.Windows.CallingShellApp','MicrosoftWindows.CrossDevice','OutlookForWindows','MicrosoftCorporationII.QuickAssist','Microsoft.ScreenSketch','Disney.37853FC22B2CE','SpotifyAB.SpotifyMusic','Microsoft.549981C3F5F10','microsoft.windowscommunicationsapps','Microsoft.MSPaint','Microsoft.Getstarted','Microsoft.ZuneVideo','MicrosoftCorporationII.MicrosoftFamily','Microsoft.MixedReality.Portal','Microsoft.Windows.DevHome','Microsoft.BingWeather','Microsoft.BingSearch','Microsoft.Windows.Photos','Microsoft.BingNews','Microsoft.OutlookForWindows','Microsoft.GetHelp','Microsoft.Microsoft3DViewer','Microsoft.MicrosoftOfficeHub','Microsoft.MicrosoftSolitaireCollection','Microsoft.MicrosoftStickyNotes','Microsoft.Office.OneNote','Microsoft.People','Microsoft.PowerAutomateDesktop','Microsoft.SkypeApp','Microsoft.Todos','Microsoft.WindowsAlarms','Microsoft.WindowsCamera','Microsoft.WindowsFeedbackHub','Microsoft.WindowsMaps','Microsoft.WindowsSoundRecorder','MicrosoftWindows.Client.CoreAI','Livtop','InpApp','Speion','Voiess','Filons','Edge.GameAssist','MicrosoftWindows.Client.WebExperience');" ^
  "foreach($n in $names){" ^
  "  Get-AppxPackage -AllUsers -Name (\"*\"+$n+\"*\") -EA 0 | ForEach-Object {" ^
  "    try { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -EA 0 } catch {}" ^
  "  };" ^
  "  Get-AppxProvisionedPackage -Online -EA 0 | Where-Object { $_.DisplayName -like (\"*\"+$n+\"*\") } | ForEach-Object {" ^
  "    try { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -EA 0 } catch {}" ^
  "  }" ^
  "}" > nul 2>&1

echo.
echo [OK] Готово: Удалить AppX мусор
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
