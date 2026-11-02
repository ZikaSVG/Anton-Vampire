@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить AppX остаток

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить AppX остаток
echo.

powershell -NoProfile -Command ^
  "$s='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore';" ^
  "$a=Get-AppxPackage -AllUsers|Select-Object PackageFullName,PackageFamilyName,PackageUserInformation,NonRemovable;" ^
  "foreach($n in @('microsoft.applicationcompatibilityenhancements','microsoft.av1videoextension','microsoft.avcencodervideoextension','microsoft.bingfinance','microsoft.bingsports','microsoft.heifimageextension','microsoft.hevcvideoextension','microsoft.mpeg2videoextension','microsoft.rawimageextension','microsoft.vp9videoextensions','microsoft.webmediaextensions','microsoft.webpimageextension','microsoft.startexperiencesapp','microsoft.wallet','microsoft.windows.parentalcontrols','microsoft.windowsterminal','microsoft.widgetsplatformruntime','microsoft.yourphone','microsoft.6365217CE6EB4','microsoftwindows.crossdevice','outlookpwa','pluton','retaildemo','settingsync','skypeortc','webthreatdefense','whesvc','widgetsplatformruntimeapp','windowstogo','wuqisvc','microsoft.oneconnect','microsoft.print3d','microsoft.messaging','crossdeviceresume')){" ^
  "  foreach($p in ($a|Where-Object{$_.PackageFullName -like ('*'+$n+'*')})){" ^
  "    $f=$p.PackageFullName;$m=$p.PackageFamilyName;$d=$s+'\Deprovisioned\'+$m; if(-not(Test-Path $d)){New-Item $d -Force|Out-Null};" ^
  "    $ib=$s+'\InboxApplications\'+$f;if(Test-Path $ib){Remove-Item $ib -Force};" ^
  "    if($p.NonRemovable -eq 1){Set-NonRemovableAppsPolicy -Online -PackageFamilyName $m -NonRemovable 0};" ^
  "    foreach($u in $p.PackageUserInformation){$i=$u.UserSecurityID.SID;New-Item($s+'\EndOfLife\'+$i+'\'+$f)-Force|Out-Null;Remove-AppxPackage -Package $f -User $i -EA 0};" ^
  "    Remove-AppxPackage -Package $f -AllUsers -EA 0" ^
  "  }" ^
  "}"

echo.
echo [OK] Готово: Удалить AppX остаток
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
