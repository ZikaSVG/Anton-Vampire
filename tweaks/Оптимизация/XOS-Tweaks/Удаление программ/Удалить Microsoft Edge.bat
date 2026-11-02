@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Microsoft Edge

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить Microsoft Edge
echo.

taskkill /f /im msedge > nul 2>&1
taskkill /f /im msedgewebview2 > nul 2>&1
taskkill /f /im MicrosoftEdgeUpdate > nul 2>&1
taskkill /f /im setup.exe > nul 2>&1

:: --- SpoofRegion ---
for /f "tokens=2,*" %%a in ('reg query "HKEY_USERS\.DEFAULT\Control Panel\International\Geo" /v Nation 2^>nul ^| findstr /i "Nation"') do set "SAVED_NATION=%%b"
if defined SAVED_NATION reg add "HKEY_USERS\.DEFAULT\Control Panel\International\Geo" /v XOS_SavedNation /t REG_SZ /d "!SAVED_NATION!" /f > nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\DeviceRegion" /v DeviceRegion /t REG_DWORD /d 244 /f > nul 2>&1
reg add "HKEY_USERS\.DEFAULT\Control Panel\International\Geo" /v Nation /t REG_SZ /d "244" /f > nul 2>&1

:: --- Stub alternative browser ---
if not exist "%SystemRoot%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" mkdir "%SystemRoot%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" > nul 2>&1
type nul > "%SystemRoot%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe" 2>nul

:: --- NoRemove cleanup ---
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v NoRemove /f > nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update" /v NoRemove /f > nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView" /v NoRemove /f > nul 2>&1

:: --- experiment_control_labels cleanup ---
for /f "tokens=*" %%K in ('reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\ClientState" /s 2^>nul ^| findstr "ClientState"') do (
  reg delete "%%K" /v experiment_control_labels /f > nul 2>&1
)

:: --- EdgeUpdateDev AllowUninstall ---
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdateDev" /v AllowUninstall /t REG_DWORD /d 1 /f > nul 2>&1

:: --- Browser uninstall ---
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v UninstallString 2^>nul ^| findstr /i "UninstallString"') do set "EDGE_UNINST=%%b"
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v UninstallArguments 2^>nul ^| findstr /i "UninstallArguments"') do set "EDGE_ARGS=%%b"
if defined EDGE_UNINST (
  set "windir="
  start /wait "" "!EDGE_UNINST!" !EDGE_ARGS! --force-uninstall --delete-profile
)

:: --- Runtime (WebView) uninstall ---
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView" /v UninstallString 2^>nul ^| findstr /i "UninstallString"') do set "WV_UNINST=%%b"
if defined WV_UNINST (
  set "windir="
  start /wait "" "!WV_UNINST!" --force-uninstall --delete-profile
)

:: --- Updater uninstall ---
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate" /v UninstallCmdLine 2^>nul ^| findstr /i "UninstallCmdLine"') do (
  cmd /c %%b > nul 2>&1
)

:: --- RestoreRegion ---
if defined SAVED_NATION (
  reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\DeviceRegion" /v DeviceRegion /t REG_DWORD /d !SAVED_NATION! /f > nul 2>&1
  reg add "HKEY_USERS\.DEFAULT\Control Panel\International\Geo" /v Nation /t REG_SZ /d "!SAVED_NATION!" /f > nul 2>&1
)

:: --- Службы ---
sc delete edgeupdate > nul 2>&1
sc delete edgeupdatem > nul 2>&1
sc delete MicrosoftEdgeElevationService > nul 2>&1

:: --- Задачи ---
schtasks /Delete /TN "\MicrosoftEdgeUpdateTaskMachineCore" /f > nul 2>&1
schtasks /Delete /TN "\MicrosoftEdgeUpdateTaskMachineUA" /f > nul 2>&1
powershell -NoProfile -Command "Get-ScheduledTask -EA 0 | Where-Object { $_.TaskName -like '*MicrosoftEdgeUpdate*' } | ForEach-Object { Unregister-ScheduledTask -TaskName $_.TaskName -Confirm:$false }" > nul 2>&1

:: --- Политики Edge Update ---
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v InstallDefault /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v UpdateDefault /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v CreateDesktopShortcutDefault /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v DoNotUpdateToEdgeWithChromium /t REG_DWORD /d 1 /f > nul 2>&1
for %%G in (56EB18F8-B008-4CBD-B6D2-8C97FE7E9062 2CD8A007-E189-409D-A2C8-9AF4EF3C72AA 0D50BFEC-CD6A-4F9A-964C-C7416E3ACB10 65C35B14-6C1D-4122-AC46-7148CC9D6497) do (
  reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "Install{%%G}" /t REG_DWORD /d 0 /f > nul 2>&1
  reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "Update{%%G}" /t REG_DWORD /d 0 /f > nul 2>&1
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "Install{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" /t REG_DWORD /d 1 /f > nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "Update{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" /t REG_DWORD /d 1 /f > nul 2>&1

:: --- Файлы ---
rd /s /q "%ProgramFiles(x86)%\Microsoft\Edge" > nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Microsoft\EdgeUpdate" > nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Microsoft\EdgeCore" > nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Internet Explorer" > nul 2>&1
del /f /q "%PUBLIC%\Desktop\Microsoft Edge.lnk" > nul 2>&1
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" > nul 2>&1

:: --- Ярлыки пользователей ---
powershell -NoProfile -Command ^
  "Get-ChildItem 'C:\Users\*\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar' -Filter '*Edge*' -EA 0 | Where-Object { $_.Extension -eq '.lnk' } | Remove-Item -Force -EA 0;" ^
  "Get-ChildItem 'C:\Users\*\Desktop' -Filter '*Edge*' -EA 0 | Where-Object { $_.Extension -eq '.lnk' } | Remove-Item -Force -EA 0;" ^
  "Get-ChildItem 'C:\Users\Default\Desktop' -Filter '*Edge*' -EA 0 | Where-Object { $_.Extension -eq '.lnk' } | Remove-Item -Force -EA 0"

:: --- Реестр Edge ---
for %%K in (
  "HKCR\CLSID\{1FCBE96C-1697-43AF-9140-2897C7C69767}"
  "HKCR\AppID\{1FCBE96C-1697-43AF-9140-2897C7C69767}"
  "HKCR\Interface\{C9C2B807-7731-4F34-81B7-44FF7779522B}"
  "HKCR\TypeLib\{C9C2B807-7731-4F34-81B7-44FF7779522B}"
  "HKCR\MSEdgeHTM"
  "HKCR\MSEdgePDF"
  "HKCR\MSEdgeMHT"
  "HKCR\AppID\{628ACE20-B77A-456F-A88D-547DB6CEEDD5}"
  "HKCR\CLSID\{3A84F9C2-6164-485C-A7D9-4B27F8AC009E}"
  "HKCR\WOW6432Node\CLSID\{3A84F9C2-6164-485C-A7D9-4B27F8AC009E}"
  "HKCR\AppID\ie_to_edge_bho.dll"
  "HKCR\AppID\{31575964-95F7-414B-85E4-0E9A93699E13}"
  "HKCR\CLSID\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
  "HKCR\WOW6432Node\CLSID\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
  "HKCR\ie_to_edge_bho.IEToEdgeBHO"
  "HKCR\ie_to_edge_bho.IEToEdgeBHO.1"
  "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}"
  "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\Microsoft Edge"
  "HKLM\SOFTWARE\Clients\StartMenuInternet\Microsoft Edge"
  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe"
  "HKLM\SOFTWARE\Microsoft\Edge"
  "HKLM\SOFTWARE\WOW6432Node\Microsoft\Edge"
  "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
  "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update"
  "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate"
  "HKLM\SYSTEM\CurrentControlSet\Services\EventLog\Application\Edge"
  "HKLM\SOFTWARE\Microsoft\MediaPlayer\ShimInclusionList\msedge.exe"
  "HKLM\SOFTWARE\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{c9abcf16-8dc2-4a95-bae3-24fd98f2ed29}"
  "HKLM\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{c9abcf16-8dc2-4a95-bae3-24fd98f2ed29}"
  "HKLM\SOFTWARE\Microsoft\Internet Explorer\ProtocolExecute\microsoft-edge"
  "HKLM\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\ProtocolExecute\microsoft-edge"
  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
  "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
  "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
  "HKCU\SOFTWARE\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}"
  "HKCU\SOFTWARE\Microsoft\Edge"
) do reg delete "%%~K" /f > nul 2>&1

reg delete "HKCR\.htm\OpenWithProgIds" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.html\OpenWithProgIds" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.shtml\OpenWithProgids" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.svg\OpenWithProgIds" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.xht\OpenWithProgIds" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.xhtml\OpenWithProgIds" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.webp\OpenWithProgids" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.xml\OpenWithProgIds" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.pdf\ShellEx\{8895b1c6-b41f-4c1c-a562-0d564250836f}" /ve /f > nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Microsoft Edge Update" /f > nul 2>&1
reg delete "HKCU\SOFTWARE\RegisteredApplications" /v "Microsoft Edge" /f > nul 2>&1
reg delete "HKLM\SOFTWARE\RegisteredApplications" /v "Microsoft Edge" /f > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PreviewHandlers" /v "{3A84F9C2-6164-485C-A7D9-4B27F8AC009E}" /f > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main\EnterpriseMode" /v MSEdgePath /f > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Ext\CLSID" /v "{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}" /f > nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMigratedBrowserPin /f > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v "MSEdgeHTM_microsoft-edge" /f > nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v "MSEdgeHTM_microsoft-edge" /f > nul 2>&1
for %%E in (htm html shtml svg xht xhtml webp) do reg delete "HKCU\SOFTWARE\Classes\.%%E\OpenWithProgids" /v MSEdgeHTM /f > nul 2>&1

:: --- OEM блокировка автозапуска ---
reg add "HKLM\Software\OEM\MicrosoftEdge" /v AutoLaunchOnLogonBehavior /t REG_DWORD /d 0 /f > nul 2>&1

:: --- Edge Game Assist AppX ---
powershell -NoProfile -Command ^
  "$n='Microsoft.Edge.GameAssist'; $p=Get-AppxPackage -AllUsers -Name $n -EA 0; if($p){ $f=$p.PackageFullName;$a=$p.PackageFamilyName;$s='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore'; Set-NonRemovableAppsPolicy -Online -PackageFamilyName $a -NonRemovable 0 -EA 0; New-Item -Force -Path ($s+'\Deprovisioned\'+$a) | Out-Null; foreach($u in $p.PackageUserInformation){$i=$u.UserSecurityId.Sid;New-Item -Force -Path ($s+'\EndOfLife\'+$i+'\'+$f) | Out-Null}; Remove-AppxPackage -Package $f -AllUsers -EA 0 }"

echo.
echo [OK] Готово: Удалить Microsoft Edge
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
