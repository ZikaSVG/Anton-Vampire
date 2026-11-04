@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Microsoft Edge

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Удалить Microsoft Edge
echo.

taskkill /f /im msedge > nul 2>&1
taskkill /f /im msedgewebview2 > nul 2>&1
taskkill /f /im MicrosoftEdgeUpdate > nul 2>&1
taskkill /f /im setup.exe > nul 2>&1

:: --- Службы
sc delete edgeupdate > nul 2>&1
sc delete edgeupdatem > nul 2>&1
sc delete MicrosoftEdgeElevationService > nul 2>&1

:: --- AppX
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage Microsoft.MicrosoftEdge.Stable* | Remove-AppxPackage -EA 0" > nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage Microsoft.MicrosoftEdgeDevToolsClient* | Remove-AppxPackage -EA 0" > nul 2>&1

:: --- Ярлыки
del /f /q "%SystemDrive%\Users\Public\Desktop\Microsoft Edge.lnk" > nul 2>&1
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" > nul 2>&1

:: --- Файлы в system32
del /f /q "%windir%\system32\MicrosoftEdgeBCHost.exe" > nul 2>&1
del /f /q "%windir%\system32\MicrosoftEdgeCP.exe" > nul 2>&1
del /f /q "%windir%\system32\MicrosoftEdgeDevTools.exe" > nul 2>&1
del /f /q "%windir%\system32\MicrosoftEdgeSH.exe" > nul 2>&1

:: --- Задачи
del /f /q "%windir%\system32\Tasks\MicrosoftEdge*" > nul 2>&1

:: --- Папки
rd /s /q "%ProgramFiles(x86)%\Microsoft\Edge" > nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Microsoft\EdgeUpdate" > nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Microsoft\EdgeCore" > nul 2>&1

:: --- Uninstall-ключи
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /f > nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update" /f > nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate" /f > nul 2>&1

:: --- Active Setup
reg delete "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}" /f > nul 2>&1

:: --- Реестр Edge
for %%K in (
  "HKCR\CLSID\{1FCBE96C-1697-43AF-9140-2897C7C69767}"
  "HKCR\AppID\{1FCBE96C-1697-43AF-9140-2897C7C69767}"
  "HKCR\Interface\{C9C2B807-7731-4F34-81B7-44FF7779522B}"
  "HKCR\TypeLib\{C9C2B807-7731-4F34-81B7-44FF7779522B}"
  "HKCR\MSEdgeHTM"
  "HKCR\MSEdgePDF"
  "HKCR\MSEdgeMHT"
  "HKCR\AppID\{628ACE20-B77A-456F-A88D-547DB6CEEDD5}"
  "HKLM\SOFTWARE\Clients\StartMenuInternet\Microsoft Edge"
  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe"
  "HKCR\AppID\ie_to_edge_bho.dll"
  "HKCR\AppID\{31575964-95F7-414B-85E4-0E9A93699E13}"
  "HKCR\CLSID\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
  "HKCR\WOW6432Node\CLSID\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
  "HKCR\ie_to_edge_bho.IEToEdgeBHO"
  "HKCR\ie_to_edge_bho.IEToEdgeBHO.1"
  "HKCU\SOFTWARE\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}"
  "HKCU\SOFTWARE\Microsoft\Edge"
) do reg delete %%K /f > nul 2>&1

:: --- Значения
reg delete "HKLM\SOFTWARE\RegisteredApplications" /v "Microsoft Edge" /f > nul 2>&1
reg delete "HKCR\.htm\OpenWithProgIds" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.html\OpenWithProgIds" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.shtml\OpenWithProgids" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.svg\OpenWithProgIds" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.xht\OpenWithProgIds" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.xhtml\OpenWithProgIds" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.webp\OpenWithProgids" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCR\.xml\OpenWithProgIds" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v "MSEdgeHTM_microsoft-edge" /f > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main\EnterpriseMode" /v MSEdgePath /f > nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Microsoft Edge Update" /f > nul 2>&1
reg delete "HKCU\SOFTWARE\RegisteredApplications" /v "Microsoft Edge" /f > nul 2>&1
for %%E in (htm html shtml svg xht xhtml webp) do reg delete "HKCU\SOFTWARE\Classes\.%%E\OpenWithProgids" /v MSEdgeHTM /f > nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v "MSEdgeHTM_microsoft-edge" /f > nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMigratedBrowserPin /f > nul 2>&1

:: --- Edge Update политики
reg add "HKLM\Software\Policies\Microsoft\EdgeUpdate" /v "Install{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\EdgeUpdate" /v "Update{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\EdgeUpdate" /v "Update{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\EdgeUpdate" /v "Update{2CD8A007-E189-409D-A2C8-9AF4EF3C72AA}" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\EdgeUpdate" /v "Update{65C35B14-6C1D-4122-AC46-7148CC9D6497}" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\EdgeUpdate" /v "Update{0D50BFEC-CD6A-4F9A-964C-C7416E3ACB10}" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\EdgeUpdate" /v "Install{65C35B14-6C1D-4122-AC46-7148CC9D6497}" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\EdgeUpdate" /v "InstallDefault" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\EdgeUpdate" /v "CreateDesktopShortcutDefault" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\EdgeUpdate" /v "UpdateDefault" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f > nul 2>&1
reg add "HKLM\Software\OEM\MicrosoftEdge" /v "AutoLaunchOnLogonBehavior" /t REG_DWORD /d 0 /f > nul 2>&1

:: --- Задачи Edge Update
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ScheduledTask -EA 0 | Where-Object { $_.TaskName -like '*MicrosoftEdgeUpdate*' } | ForEach-Object { Unregister-ScheduledTask -TaskName $_.TaskName -Confirm:$false }" > nul 2>&1

echo.
echo [OK] Готово: Удалить Microsoft Edge
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
