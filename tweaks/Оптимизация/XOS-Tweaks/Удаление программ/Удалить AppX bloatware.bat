@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить AppX bloatware

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить AppX bloatware
echo.

powershell -NoProfile -Command ^
  "$s='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore';" ^
  "$a=Get-AppxPackage -AllUsers|Select-Object PackageFullName,PackageFamilyName,PackageUserInformation,NonRemovable;" ^
  "foreach($n in @(" ^
  "  'microsoft.bingnews','microsoft.bingweather','microsoft.windowscommunicationsapps','microsoft.gethelp','microsoft.getstarted','microsoft.microsoftsolitairecollection','microsoft.microsoftstickynotes','microsoft.people','microsoft.powerautomatedesktop','microsoft.todos','microsoft.windowsalarms','microsoft.windowscamera','microsoft.windowsfeedbackhub','microsoft.windowsmaps','microsoft.windowssoundrecorder','microsoft.zunevideo','microsoft.zunemusic','microsoft.microsoftofficehub','microsoft.office.onenote','microsoft.outlookforwindows','clipchamp','microsoft.mspaint','microsoft.windows.contentdeliverymanager','microsoft.windows.devhome','microsoft.mixedreality.portal','microsoft.microsoft3dviewer','microsoft.549981c3f5f10','Microsoft.SkypeApp','Microsoft.MicrosoftEdge','Microsoft.Windows.Photos','Microsoft.WindowsCalculator','Microsoft.Copilot','microsoftcorporationii.quickassist','microsoftcorporationii.microsoftfamily','Microsoft.WindowsAlarms','Microsoft.WindowsSoundRecorder','Microsoft.Whiteboard','MicrosoftWindows.Client.WebExperience','microsoft.yourphone','Microsoft.OneConnect','Microsoft.Print3D','Microsoft.Messaging'" ^
  ")){" ^
  "  foreach($p in ($a|Where-Object{$_.PackageFullName -like ('*'+$n+'*')})){" ^
  "    $f=$p.PackageFullName;$m=$p.PackageFamilyName;$d=$s+'\Deprovisioned\'+$m; if(-not(Test-Path $d)){New-Item $d -Force|Out-Null};" ^
  "    $ib=$s+'\InboxApplications\'+$f;if(Test-Path $ib){Remove-Item $ib -Force};" ^
  "    if($p.NonRemovable -eq 1){Set-NonRemovableAppsPolicy -Online -PackageFamilyName $m -NonRemovable 0};" ^
  "    foreach($u in $p.PackageUserInformation){$i=$u.UserSecurityID.SID;New-Item($s+'\EndOfLife\'+$i+'\'+$f)-Force|Out-Null;Remove-AppxPackage -Package $f -User $i -EA 0};" ^
  "    Remove-AppxPackage -Package $f -AllUsers -EA 0" ^
  "  }" ^
  "}"

echo.
echo [OK] Готово: Удалить AppX bloatware
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
