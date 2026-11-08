@echo off
setlocal DisableDelayedExpansion
title AtlasOS-style tweaks [no themes / wallpapers / aux files]

rem ================================================================================================
rem  ATLASOS-ПОДОБНАЯ НАСТРОЙКА WINDOWS ОДНИМ BAT-ФАЙЛОМ
rem  (без тем, обоев, аватарок, ярлыков, AtlasModules/AtlasDesktop и установки софта)
rem ================================================================================================
rem
rem  ЧТО ЭТО:
rem   Автономный пакетный файл, который применяет основную часть твиков плейбука AtlasOS 0.5.x
rem   (файлы .\Configuration\atlas\*.yml и .\Configuration\tweaks\*.yml) напрямую через
rem   reg.exe / sc.exe / DISM / PowerShell. Ничего не скачивает и не копирует в C:\Windows.
rem
rem  ТРЕБОВАНИЯ И ЗАПУСК:
rem   - Windows 10 2004+ или Windows 11 (x64/ARM64);
rem   - запуск от имени администратора (скрипт сам запросит UAC);
rem   - запускать ИЗ-ПОД ТОГО ПОЛЬЗОВАТЕЛЯ, для которого нужны настройки HKCU;
rem   - после работы ОБЯЗАТЕЛЬНА перезагрузка;
rem   - точка восстановления НЕ создаётся (сделайте вручную, если нужно);
rem   - сообщения в консоли на английском, чтобы не зависеть от кодовой страницы.
rem
rem  ЧТО ДЕЛАЕТСЯ ПО ПОРЯДКУ:
rem
rem   1. DISM-компоненты (start.yml, debloat\disable-reserved-storage.yml):
rem       - включение DirectPlay;
rem       - удаление возможности "Steps Recorder";
rem       - отключение зарезервированного хранилища обновлений (Reserved Storage);
rem       - очистка хранилища компонентов (StartComponentCleanup).
rem
rem   2. AppX-приложения (appx.yml):
rem       - снимок установленных пакетов;
rem       - удаление Teams (старый и новый), Copilot, Clipchamp, Disney+, Spotify, Cortana,
rem         Xbox Console Companion, Почта и Календарь, Paint 3D, Tips, Фильмы и ТВ,
rem         Microsoft Family, Mixed Reality Portal, Dev Home, Погода, Новости, Bing Search,
rem         Outlook for Windows, Get Help, 3D Viewer, Office Hub, Пасьянс, Sticky Notes,
rem         OneNote, People, Power Automate, Ножницы, Skype, To Do, Будильники, Камера,
rem         Feedback Hub, Карты, Диктофон, Ink Handwriting, Phone Link;
rem       - удаление провижиненных копий, чтобы приложения не вернулись;
rem       - добавление ключей Deprovisioned для остатков, которые не удалились;
rem       - kill процессов Teams.
rem
rem   3. Компоненты (components.yml):
rem       - убирается автозапуск SecurityHealth;
rem       - отключается Smart App Control (VerifiedAndReputablePolicyState=0);
rem       - OneDrive: остановка, uninstall, чистка ключей/задач/ярлыков;
rem       - (опционально, по вопросу) удаление AppX-Edge и ключи Deprovisioned для Edge.
rem
rem   4. Службы и драйверы (services.yml):
rem       - OneSyncSvc, TrkWks, PcaSvc, DiagTrack, diagnosticshub, WerSvc, wercplsupport,
rem         UCPD, GpuEnergyDrv, NetBT, Telemetry -> disabled (Start=4).
rem
rem   5. Сеть и общий доступ (services.yml, DisableFileSharing.ps1, networking\shares\*):
rem       - отключение клиента/сервера SMB, LLTD, ответчика на запросы;
rem       - NetBIOS over TCP/IP = 2, служба NetBT отключена;
rem       - профиль сети -> Public;
rem       - правила брандмауэра "File and Printer Sharing"/"Network Discovery" выкл.;
rem       - скрытие "Сеть" в проводнике и удаление "Предоставить доступ";
rem       - RestrictNullSessAccess, RestrictAnonymous, DisableBandwidthThrottling;
rem       - твики сетевых адаптеров: AutoDisableGigabit, ApCompatMode, SipsEnabled,
rem         ReduceSpeedOnPowerDown, DMACoalescing = 0 (с префиксом * и без).
rem
rem   6. Геолокация и поиск (services.yml, indexConf):
rem       - lfsvc/MapsBroker отключены, Find My Device выключен, ConsentStore\location = Deny;
rem       - минимальная индексация: из индекса исключён C:\Users, RespectPowerModes=1.
rem
rem   7. Производительность (performance\*):
rem       - MMCSS SystemResponsiveness=10;
rem       - авто-обнаружение типа папок отключено (Bags);
rem       - Maintenance WakeUp=0, фоновые приложения выключены;
rem       - FTH сброшен и отключён;
rem       - Sleep Study и диагностические журналы выключены, задача AnalyzeSystem отключена;
rem       - NTFS: disablelastaccess=1, 8dot3name=1;
rem       - SvcHostSplitDisable=1 для всех служб кроме Xbox/Xbl;
rem       - Win32PrioritySeparation=38 (приоритет активному окну).
rem
rem   8. Приватность (privacy\*):
rem       - телеметрия: AllowTelemetry=0, DiagTrack-Listener off, очистка ETLLogs;
rem       - CEIP, KMS-телеметрия, диагностическая трассировка, .NET CLI телеметрия;
rem       - рекламный ID, Activity Feed, отслеживание запуска приложений, PCA, WER, RSoP;
rem       - онлайн-распознавание речи, авто-обновление речевых моделей, ввод/рукопись;
rem       - синхронизация настроек, Tailored experiences, Spotlight-политики;
rem       - поиск в Интернете/Bing отключён, SearchboxTaskbarMode=1;
rem       - запрет подключения MSA-аккаунтов, отключение публикации активностей;
rem       - Recall (DisableAIDataAnalysis), права приложений (appDiagnostics/location/
rem         userAccountInformation = Deny);
rem       - WMP DRM/телеметрия, NVIDIA/Office телеметрия, уведомления sync-провайдеров.
rem
rem   9. Деблоат (debloat\*):
rem       - Content Delivery Manager: без рекомендованного контента, типов и рекламы;
rem       - Storage Sense: ежемесячная очистка временных файлов, Downloads не трогаем;
rem       - отключение 6 задач планировщика и Ubpm CriticalMaintenance_UsageDataReporting;
rem       - скрытие страниц "Семья", "Производительность устройства", "Защита учётной записи".
rem
rem  10. QoL-твики (tweaks\qol\*), большой блок:
rem       - bcdedit: legacy-меню загрузки, timeout 10;
rem       - визуальные эффекты Atlas;
rem       - отключение ускорения мыши, задержки меню, Aero Shake, Low Disk Warning;
rem       - Проводник: показ скрытых файлов и расширений, классический поиск, компактный вид,
rem         длинные пути, отключение чекбоксов, скрытие Галереи, автозапуск, «Быстрый доступ»,
rem         открытие на «Этот компьютер», без «Предыдущих версий», без «Поделиться»,
rem         без «Cast to Device», без «Extract», без «Print» в контекстном меню,
rem         без «Include in Library», без «New Bitmap/RTF», без «Edit with Paint 3D»,
rem         без «Troubleshoot compatibility», пункты «Создать» для .bat/.ps1/.reg,
rem         ассоциация .pow, отключение авто-обнаружения типа папок, «Меню Пуск» без MFU;
rem       - панель задач: выравнивание влево, без Copilot/Chat/Meet Now/News/Peek,
rem         End task, скрытие Task View;
rem       - Пуск: без рекомендаций, без недавно добавленных, без частых приложений;
rem       - Центр уведомлений: открепление неиспользуемых быстрых действий;
rem       - спец. возможности: без залипания клавиш/звуков/Narrator/Shift x5;
rem       - UAC без Secure Desktop;
rem       - скрытие неиспользуемых страниц Параметров;
rem       - автовоспроизведение/автозапуск выключены;
rem       - уменьшено время завершения работы;
rem       - Crash Control: без дампов, без авто-перезагрузки, показ параметров BSOD;
rem       - отключение WPBT;
rem       - синие подсказки, Dynamic Lighting off, PrintScreen-хоткей off,
rem         автоархивация приложений off, USB-уведомления off, Windows Feedback off,
rem         Windows Spotlight off, Ink Workspace без подсказок, Tablet Mode never;
rem       - отключение «Get tips/tricks/suggestions», настроек планшета и т.д.
rem
rem  11. Обновления Windows (qol\windows-update\*):
rem       - без навязчивых уведомлений и авто-перезагрузки;
rem       - Insider заблокирован, MSRT-телеметрия выключена;
rem       - фиксация TargetReleaseVersion (фича-апдейты не приходят);
rem       - AUOptions=2 (без авто-скачивания), Delivery Optimization off;
rem       - блок повторной установки Dev Home/Outlook из Windows Update.
rem
rem  12. Безопасность (security\*):
rem       - RestrictAnonymousSAM=1;
rem       - отключение Remote Assistance и соответствующего правила брандмауэра.
rem
rem  13. Прочее:
rem       - NTP-серверы pool.ntp.org, пересборка счётчиков производительности.
rem
rem  14. Отключение Core Isolation/VBS и/или митигаций CPU.
rem
rem  15. Финал: PowerShell ExecutionPolicy=RemoteSigned, напоминание о перезагрузке.
rem
rem  ЧЕГО СКРИПТ НЕ ДЕЛАЕТ (в отличие от полного AtlasOS):
rem   - не ставит темы, обои, картинки профиля, не меняет раскладку Пуска/панель задач;
rem   - не копирует AtlasDesktop/AtlasModules, не создаёт ярлыки и OEM-информацию;
rem   - не ставит 7-Zip/NanaZip, VC++ Runtime, DirectX, браузеры, Toolbox, Process Explorer;
rem   - не настраивает ассоциации файлов/браузеров и не пинит их на панель задач;
rem   - не отключает Защитник Windows и не применяет CBS-пакеты NoDefender/NoTelemetry
rem     (вместо этого — только политики телеметрии из раздела 8);
rem   - не запускает NGEN, Disk Cleanup с пресетом, не удаляет точки восстановления;
rem   - не удаляет Microsoft Edge Stable (только AppX и ключи, по желанию).
rem ================================================================================================

rem --- Определяем сборку Windows ---
set "BUILD=0"
for /f "tokens=6 delims=[.] " %%a in ('ver') do set "BUILD=%%a"

echo.
echo ================================================================
echo  AtlasOS-style tweaks: no themes / wallpapers / aux files
echo  Windows build: %BUILD%
echo  Reboot is REQUIRED after this script.
echo  Make a restore point/backup beforehand if you need one.
echo ================================================================

rem ================================================================================================
rem  1. DISM
rem ================================================================================================
echo.
echo [1/15] DISM components (this can take a few minutes)...
dism /Online /Enable-Feature /FeatureName:DirectPlay /NoRestart /All >nul 2>&1
dism /Online /Remove-Capability /CapabilityName:App.StepsRecorder~~~~0.0.1.0 /NoRestart >nul 2>&1
dism /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
dism /Online /Cleanup-Image /StartComponentCleanup >nul 2>&1

rem ================================================================================================
rem  2. AppX
rem ================================================================================================
echo.
echo [2/15] Removing AppX packages...
taskkill /f /im "msteams.exe" >nul 2>&1
taskkill /f /im "ms-teams.exe" >nul 2>&1

powershell -NoProfile -ExecutionPolicy Bypass -Command "(Get-AppxPackage -AllUsers).PackageFamilyName | Set-Content -LiteralPath '%TEMP%\atlas_old_appx.txt'" >nul 2>&1

for %%p in (
  "MicrosoftTeams*"
  "MSTeams*"
  "Microsoft.Copilot*"
  "Clipchamp.Clipchamp*"
  "Disney.37853FC22B2CE*"
  "SpotifyAB.SpotifyMusic*"
  "Microsoft.549981C3F5F10*"
  "Microsoft.XboxApp*"
  "microsoft.windowscommunicationsapps*"
  "Microsoft.MSPaint*"
  "Microsoft.Getstarted*"
  "Microsoft.ZuneVideo*"
  "MicrosoftCorporationII.MicrosoftFamily*"
  "Microsoft.MixedReality.Portal*"
  "Microsoft.Windows.DevHome*"
  "Microsoft.BingWeather*"
  "Microsoft.BingNews*"
  "Microsoft.BingSearch*"
  "Microsoft.OutlookForWindows*"
  "Microsoft.GetHelp*"
  "Microsoft.Microsoft3DViewer*"
  "Microsoft.MicrosoftOfficeHub*"
  "Microsoft.MicrosoftSolitaireCollection*"
  "Microsoft.MicrosoftStickyNotes*"
  "Microsoft.Office.OneNote*"
  "Microsoft.People*"
  "Microsoft.PowerAutomateDesktop*"
  "Microsoft.ScreenSketch*"
  "Microsoft.SkypeApp*"
  "Microsoft.Todos*"
  "Microsoft.WindowsAlarms*"
  "Microsoft.WindowsCamera*"
  "Microsoft.WindowsFeedbackHub*"
  "Microsoft.WindowsMaps*"
  "Microsoft.WindowsSoundRecorder*"
  "Ink.Handwriting.Main.Store.en-US1.0"
  "Microsoft.YourPhone*"
) do (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers -Name '%%~p' -ErrorAction SilentlyContinue | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like '%%~p' } | Remove-AppxProvisionedPackage -Online -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
)

powershell -NoProfile -ExecutionPolicy Bypass -Command "$o=Get-Content -LiteralPath '%TEMP%\atlas_old_appx.txt' -EA 0; $n=(Get-AppxPackage -AllUsers).PackageFamilyName; if($o){ Compare-Object $o $n | Where-Object { $_.SideIndicator -eq '<=' } | ForEach-Object { New-Item -Path ('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\' + $_.InputObject) -Force | Out-Null } }; Remove-Item -LiteralPath '%TEMP%\atlas_old_appx.txt' -Force -EA 0" >nul 2>&1

rem ================================================================================================
rem  3. Компоненты
rem ================================================================================================
echo.
echo [3/15] Components: SecurityHealth, Smart App Control, OneDrive, Edge...

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" /v VerifiedAndReputablePolicyState /t REG_DWORD /d 0 /f >nul 2>&1

rem OneDrive
taskkill /f /im OneDrive.exe >nul 2>&1
if exist "%SystemRoot%\System32\OneDriveSetup.exe" start /wait "" "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall >nul 2>&1
if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" start /wait "" "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall >nul 2>&1
rmdir /s /q "%ProgramData%\Microsoft OneDrive" >nul 2>&1
rmdir /s /q "%LOCALAPPDATA%\Microsoft\OneDrive" >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDriveSetup /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDriveSetup /f >nul 2>&1
reg delete "HKCU\Environment" /v OneDrive /f >nul 2>&1
for /f "delims=" %%k in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SyncRootManager" 2^>nul ^| findstr /i "OneDrive"') do reg delete "%%k" /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ScheduledTask -EA 0 | Where-Object { $_.TaskName -like 'OneDrive*' } | Unregister-ScheduledTask -Confirm:$false -EA 0" >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1

rem Microsoft Edge (опционально)
choice /c yn /n /m "Remove Microsoft Edge AppX and block it from reinstalling? [Y/N] "
if errorlevel 2 goto skipEdge
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\Microsoft.MicrosoftEdge.Stable_8wekyb3d8bbwe" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers -Name 'Microsoft.MicrosoftEdge*' -EA 0 | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -EA 0 }" >nul 2>&1
:skipEdge

rem ================================================================================================
rem  4. Службы и драйверы
rem ================================================================================================
echo.
echo [4/15] Services and drivers...

reg add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wercplsupport" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UCPD" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Telemetry" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop DiagTrack >nul 2>&1

rem ================================================================================================
rem  5. Сеть и общий доступ
rem ================================================================================================
echo.
echo [5/15] Networking and file sharing...

powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-NetAdapter -Physical -EA 0 | Disable-NetAdapterBinding -ComponentID ms_msclient,ms_server,ms_lltdio,ms_rspndr -EA 0" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces' -EA 0 | ForEach-Object { if ($null -ne (Get-ItemProperty -Path $_.PSPath -Name NetbiosOptions -EA 0)) { Set-ItemProperty -Path $_.PSPath -Name NetbiosOptions -Value 2 } }" >nul 2>&1
sc config NetBT start= disabled >nul 2>&1
sc stop NetBT >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-NetConnectionProfile -EA 0 | Set-NetConnectionProfile -NetworkCategory Public -EA 0" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-NetFirewallRule -Group '@FirewallAPI.dll,-28502','@FirewallAPI.dll,-32752' -EA 0 | Disable-NetFirewallRule -EA 0" >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /v RestrictNullSessAccess /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RestrictAnonymous /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v DisableBandwidthThrottling /t REG_DWORD /d 1 /f >nul 2>&1

reg delete "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1

reg add "HKCU\SOFTWARE\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f >nul 2>&1

powershell -NoProfile -ExecutionPolicy Bypass -Command "$v='AutoDisableGigabit','ApCompatMode','SipsEnabled','ReduceSpeedOnPowerDown','DMACoalescing'; Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Control\Class' -EA 0 | Where-Object { $_.PSChildName -like '{4d36e972*' } | ForEach-Object { $k=$_.PSPath; $names=(Get-Item -LiteralPath $k).GetValueNames(); foreach($n in $v){ foreach($x in @($n,'*'+$n)){ if($names -contains $x){ Set-ItemProperty -LiteralPath $k -Name $x -Value '0' -Type String } } } }" >nul 2>&1

rem ================================================================================================
rem  6. Геолокация и поиск
rem ================================================================================================
echo.
echo [6/15] Location and search indexing...

sc config lfsvc start= disabled >nul 2>&1
sc config MapsBroker start= disabled >nul 2>&1
sc stop lfsvc >nul 2>&1
sc stop MapsBroker >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v AllowFindMyDevice /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v LocationSyncEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v ShowGlobalPrompts /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\DefaultExcludedPaths" /v "file:///C:\Users\*" /t REG_SZ /d "file:///C:\Users\*" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Search\CurrentPolicies\DefaultExcludedPaths" /v "file:///C:\Users\*" /t REG_SZ /d "file:///C:\Users\*" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows Search\Gather\Windows\SystemIndex" /v RespectPowerModes /t REG_DWORD /d 1 /f >nul 2>&1
sc config WSearch start= delayed-auto >nul 2>&1

rem ================================================================================================
rem  7. Производительность
rem ================================================================================================
echo.
echo [7/15] Performance tweaks...

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul 2>&1
reg delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags" /f >nul 2>&1
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v FolderType /t REG_SZ /d NotSpecified /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Task Scheduler\Maintenance" /v WakeUp /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f >nul 2>&1
rundll32.exe fthsvc.dll,FthSysprepSpecialize >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
wevtutil set-log "Microsoft-Windows-SleepStudy/Diagnostic" /e:false >nul 2>&1
wevtutil set-log "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /e:false >nul 2>&1
wevtutil set-log "Microsoft-Windows-UserModePowerService/Diagnostic" /e:false >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable >nul 2>&1
fsutil behavior set disablelastaccess 1 >nul 2>&1
fsutil 8dot3name set 1 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Services' | Where-Object { $_.PSChildName -notmatch 'Xbl|Xbox' } | ForEach-Object { $p='Registry::'+$_.Name; if ($null -ne (Get-ItemProperty -Path $p -Name Start -EA 0)) { Set-ItemProperty -Path $p -Name SvcHostSplitDisable -Type DWord -Value 1 -Force -EA 0 } }" >nul 2>&1

rem ================================================================================================
rem  8. Приватность
rem ================================================================================================
echo.
echo [8/15] Privacy tweaks...

rem --- App permissions
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v Value /t REG_SZ /d Deny /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d Deny /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v Value /t REG_SZ /d Deny /f >nul 2>&1

rem --- Windows Media Player
reg add "HKLM\SOFTWARE\Policies\Microsoft\WMDRM" /v DisableOnline /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v AcceptedPrivacyStatement /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v UsageTracking /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Разное
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v Value /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreenCamera /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v HasAccepted /t REG_DWORD /d 0 /f >nul 2>&1

rem --- PCA
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v AITEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableEngine /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisablePCA /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableUAR /t REG_DWORD /d 1 /f >nul 2>&1

rem --- PerfTrack / RSoP / Privacy experience / Recall / Speech updates
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}" /v ScenarioExecutionEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v DisablePrivacyExperience /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v RSoPLogging /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Speech" /v AllowSpeechModelUpdate /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Tailored / tracking / language list / MSA / activities
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoInstrumentation /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v NoConnectedUser /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Windows Error Reporting
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v DoReport /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DontShowUI /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v ShowUI /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v LoggingDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DontSendAdditionalData /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v DisableWerReporting /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v DisableSendGenericDriverNotFoundToWER /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v DisableSendRequestAdditionalSoftwareToWER /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Поиск
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsAADCloudSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsDeviceSearchHistoryEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsMSACloudSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v SafeSearchMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v EnableDynamicContentInWSB /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Телеметрия приложений
reg add "HKCU\Software\NVIDIA Corporation\NVControlPanel2\Client" /v OptInOrOutPreference /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\office\16.0\common" /v sendcustomerdata /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\office\common\clienttelemetry" /v sendtelemetry /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\office\16.0\common" /v qmenable /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Реклама
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Облако
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSync /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSyncUserOverride /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSyncOnPaidNetwork /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableWindowsSettingSync /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v SyncPolicy /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Messaging" /v AllowMessageSync /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Телеметрия ОС
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v NoGenTicket /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\AppV\CEIP" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Diagnostics\Performance" /v DisableDiagnosticTracing /t REG_DWORD /d 1 /f >nul 2>&1
setx DOTNET_CLI_TELEMETRY_OPTOUT 1 >nul 2>&1
setx POWERSHELL_TELEMETRY_OPTOUT 1 >nul 2>&1

rem --- Ввод / рукопись
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v PreventHandwritingDataSharing /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v PreventHandwritingErrorReports /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Input\Settings" /v InsightsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Отключение сбора данных
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v ShowedToastAtLevel /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v MaxTelemetryAllowed /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey" /v EnableEventTranscript /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey" /v MiniTraceSlotEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v AllowDeviceNameInTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Diagtrack-Listener" /v Start /t REG_DWORD /d 0 /f >nul 2>&1
del /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\DiagTrack*" >nul 2>&1
del /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\DiagTrack*" >nul 2>&1

rem ================================================================================================
rem  9. Деблоат
rem ================================================================================================
echo.
echo [9/15] Debloat...

rem --- Content Delivery Manager
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v ContentDeliveryAllowed /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v FeatureManagementEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContentEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RemediationRequired /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEverEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications" /v EnableAccountNotifications /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338387Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenOverlayEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Storage Sense
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 1024 /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 2048 /t REG_DWORD /d 30 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 04 /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 32 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 02 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 128 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 08 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 256 /t REG_DWORD /d 0 /f >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskCleanup\SilentCleanup" /enable >nul 2>&1

rem --- Задачи
schtasks /change /tn "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /disable >nul 2>&1
reg delete "HKLM\System\CurrentControlSet\Control\Ubpm" /v CriticalMaintenance_UsageDataReporting /f >nul 2>&1

rem --- Страницы Windows Security
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Family options" /v UILockdown /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device performance and health" /v UILockdown /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Account protection" /v UILockdown /t REG_DWORD /d 1 /f >nul 2>&1

rem ================================================================================================
rem  10. QoL
rem ================================================================================================
echo.
echo [10/15] QoL tweaks...

rem --- Boot
bcdedit /timeout 10 >nul 2>&1
bcdedit /set "{default}" bootmenupolicy legacy >nul 2>&1

rem --- Внешний вид
reg add "HKCU\Control Panel\Colors" /v InfoWindow /t REG_SZ /d "246 253 255" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v IconsOnly /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v AlwaysHibernateThumbnails /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Мышь, меню, звук
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v MouseHoverTime /t REG_SZ /d 20 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Multimedia\Audio" /v UserDuckingPreference /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Multimedia\Audio\DeviceCpl" /v ShowDisconnectedDevices /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Multimedia\Audio\DeviceCpl" /v ShowHiddenDevices /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Пуск
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoStartMenuMFUprogramsList /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v ShowOrHideMostUsedApps /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HideRecentlyAddedApps /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HideRecommendedPersonalizedSites /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_AccountNotifications /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_Layout /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Панель задач
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DontUsePowerShellOnWinX /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisablePreviewDesktop /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AllUpView" /v Enabled /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableCloudOptimizedContent /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" /v ChatIcon /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v TaskbarEndTask /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v MultiTaskingAltTabFilter /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisallowShaking /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Быстрые действия (Win11)
if %BUILD% GEQ 22000 (
    reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v Microsoft.QuickAction.Cast /t REG_NONE /f >nul 2>&1
    reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v Microsoft.QuickAction.NearShare /t REG_NONE /f >nul 2>&1
    reg add "HKCU\Control Panel\Quick Actions\Control Center\QuickActionsStateCapture" /v Toggles /t REG_SZ /d "Toggles,Microsoft.QuickAction.BlueLightReduction:false,Microsoft.QuickAction.Accessibility:false,Microsoft.QuickAction.ProjectL2:false" /f >nul 2>&1
) else (
    reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v Microsoft.QuickAction.Connect /t REG_NONE /f >nul 2>&1
    reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v Microsoft.QuickAction.Location /t REG_NONE /f >nul 2>&1
    reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v Microsoft.QuickAction.ScreenClipping /t REG_NONE /f >nul 2>&1
    reg add "HKCU\Control Panel\Quick Actions\Control Center\QuickActionsStateCapture" /v Toggles /t REG_SZ /d "Toggles,Microsoft.QuickAction.BlueLightReduction:false,Microsoft.QuickAction.AllSettings:false,Microsoft.QuickAction.Project:false" /f >nul 2>&1
)

rem --- Проводник
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v EnthusiastMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Classes\CLSID\{1d64637d-31e9-4b06-9124-e83fb178ac6e}\TreatAs" /ve /t REG_SZ /d "{64bc32b5-4eec-4de7-972d-bd8bd0324537}" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{1d64637d-31e9-4b06-9124-e83fb178ac6e}\TreatAs" /ve /t REG_SZ /d "{64bc32b5-4eec-4de7-972d-bd8bd0324537}" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Classes\CLSID\{1d64637d-31e9-4b06-9124-e83fb178ac6e}\TreatAs" /ve /t REG_SZ /d "{64bc32b5-4eec-4de7-972d-bd8bd0324537}" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v AutoCheckSelect /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoResolveSearch /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoResolveTrack /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v MultipleInvokePromptMinimum /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowFrequent /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowRecent /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v ClearRecentDocsOnExit /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoRecentDocsHistory /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v NoRemoteDestinations /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoInternetOpenWith /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCloudFilesInQuickAccess /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseCompactMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "Max Cached Icons" /t REG_SZ /d 4096 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /v ShortcutNameTemplate /t REG_SZ /d "\"%%s.lnk\"" /f >nul 2>&1

rem --- Удаление пунктов контекстного меню
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /t REG_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}" /t REG_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{BD472F60-27FA-11cf-B8B4-444553540000}" /t REG_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{EE07CEF5-3441-4CFB-870A-4002C724783A}" /t REG_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{D12E3394-DE4B-4777-93E9-DF0AC88F8584}" /t REG_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{1d27f844-3a1f-4410-85ac-14651078412d}" /t REG_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{1d27f844-3a1f-4410-85ac-14651078412d}" /t REG_SZ /f >nul 2>&1
reg delete "HKCR\Folder\ShellEx\ContextMenuHandlers\Library Location" /f >nul 2>&1
reg delete "HKCR\.bmp\ShellNew" /f >nul 2>&1
reg delete "HKCR\.rtf\ShellNew" /f >nul 2>&1
reg delete "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f >nul 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\ModernSharing" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.3mf\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.bmp\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.fbx\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.gif\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.jfif\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.jpe\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.jpeg\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.jpg\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.png\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.tif\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.tiff\Shell\3D Edit" /f >nul 2>&1

rem --- «Предыдущие версии»
reg delete "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v NoPreviousVersionsPage /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Policies\Microsoft\PreviousVersions" /v DisableLocalPage /f >nul 2>&1

rem --- «Печать» в контекстном меню
reg add "HKCR\SystemFileAssociations\image\shell\print" /v ProgrammaticAccessOnly /t REG_SZ /f >nul 2>&1
for %%a in (batfile cmdfile docxfile fonfile htmlfile inffile inifile JSEFile otffile pfmfile regfile rtffile ttcfile ttffile txtfile VBEFile VBSFile WSFFile) do reg add "HKCR\%%a\shell\print" /v ProgrammaticAccessOnly /t REG_SZ /f >nul 2>&1
if %BUILD% GEQ 22000 (
    reg add "HKCR\AppX4ztfk9wxr86nxmzzq47px0nh0e58b8fw\Shell\Print" /v LegacyDisable /t REG_SZ /f >nul 2>&1
    reg add "HKCR\AppX4ztfk9wxr86nxmzzq47px0nh0e58b8fw\Shell\Print" /v ProgrammaticAccessOnly /t REG_SZ /f >nul 2>&1
    reg add "HKCR\AppX4ztfk9wxr86nxmzzq47px0nh0e58b8fw\Shell\Print" /v HideBasedOnVelocityId /t REG_DWORD /d 6527944 /f >nul 2>&1
    reg add "HKCR\AppX4ztfk9wxr86nxmzzq47px0nh0e58b8fw\Shell\PrintTo" /v LegacyDisable /t REG_SZ /f >nul 2>&1
    reg add "HKCR\AppX4ztfk9wxr86nxmzzq47px0nh0e58b8fw\Shell\PrintTo" /v ProgrammaticAccessOnly /t REG_SZ /f >nul 2>&1
    reg add "HKCR\AppX4ztfk9wxr86nxmzzq47px0nh0e58b8fw\Shell\PrintTo" /v HideBasedOnVelocityId /t REG_DWORD /d 6527944 /f >nul 2>&1
)

rem --- «Создать» для .bat/.ps1/.reg
reg add "HKCR\.bat\ShellNew" /v ItemName /t REG_EXPAND_SZ /d "%%windir%%\System32\acppage.dll,-6002" /f >nul 2>&1
reg add "HKCR\.bat\ShellNew" /v NullFile /t REG_SZ /f >nul 2>&1
reg add "HKCR\.ps1" /ve /t REG_SZ /d Microsoft.PowerShellScript.1 /f >nul 2>&1
reg add "HKCR\.ps1\ShellNew" /v NullFile /t REG_SZ /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellScript.1" /ve /t REG_SZ /d "Windows PowerShell Script" /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellScript.1" /v FriendlyTypeName /t REG_SZ /d "Windows PowerShell Script" /f >nul 2>&1
reg add "HKCR\.reg\ShellNew" /v NullFile /t REG_SZ /f >nul 2>&1
reg add "HKCR\.reg\ShellNew" /v ItemName /t REG_EXPAND_SZ /d "%%windir%%\regedit.exe,-309" /f >nul 2>&1

rem --- Ассоциация .pow
reg add "HKCR\powerscheme\DefaultIcon" /ve /t REG_SZ /d "%%windir%%\System32\powercpl.dll,1" /f >nul 2>&1
reg add "HKCR\powerscheme\Shell\open\command" /ve /t REG_SZ /d "powercfg /import \"%%1\"" /f >nul 2>&1
reg add "HKCR\.pow" /ve /t REG_SZ /d powerscheme /f >nul 2>&1
reg add "HKCR\.pow" /v FriendlyTypeName /t REG_SZ /d "Power Scheme" /f >nul 2>&1

rem --- Прочие QoL
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" /v PenWorkspaceAppSuggestionsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\Appx" /v AllowAutomaticAppArchiving /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Lighting" /v AmbientLightingEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Keyboard" /v PrintScreenKeyForSnippingEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Settings\AllowOnlineTips" /v value /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v AllowOnlineTips /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableAutocorrection /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableDoubleTapSpace /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v EnablePredictionSpaceInsertion /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableSpellchecking /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableTextPrediction /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v AutoDownload /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableAutoShiftEngage /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableKeyAudioFeedback /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Cursors" /v GestureVisualization /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Cursors" /v ContactVisualization /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Shell\USB" /v NotifyOnUsbErrors /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Shell\USB" /v NotifyOnWeakCharger /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\ValueBanner.IdealStateFeatureControlProvider" /v ActivationType /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v PeriodInNanoSeconds /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightWindowsWelcomeExperience /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnActionCenter /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnSettings /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableThirdPartySuggestions /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Спец. возможности
reg add "HKCU\SOFTWARE\Microsoft\Ease of Access" /v selfscan /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Ease of Access" /v selfvoice /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\HighContrast" /v Flags /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v Flags /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\MouseKeys" /v Flags /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v Flags /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKCU\Control Panel\Input Method\Hot Keys\00000104" /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Layout Hotkey" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Language Hotkey" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Hotkey" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Narrator\NoRoam" /v WinEnterLaunchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\SlateLaunch" /v LaunchAT /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility" /v "Warning Sounds" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility" /v "Sound on Activation" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\SoundSentry" /v WindowsEffect /t REG_SZ /d 0 /f >nul 2>&1

rem --- UAC, скрытые страницы, автозапуск
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f >nul 2>&1
if %BUILD% GEQ 22000 (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v SettingsPageVisibility /t REG_SZ /d "hide:recovery;maps;maps-downloadmaps;privacy;privacy-feedback;privacy-activityhistory;search-permissions;privacy-general;sync;mobile-devices;mobile-devices-addphone;workplace;family-group;deviceusage;home;privacy-location;findmydevice;cortana-windowssearch" /f >nul 2>&1
) else (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v SettingsPageVisibility /t REG_SZ /d "hide:recovery;maps;maps-downloadmaps;privacy;privacy-speechtyping;privacy-speech;privacy-feedback;privacy-activityhistory;search-permissions;privacy-general;sync;mobile-devices;mobile-devices-addphone;workplace;backup;privacy-location;findmydevice;cortana-windowssearch" /f >nul 2>&1
)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\CameraAlternate" /v MSTakeNoAction /t REG_NONE /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\StorageOnArrival" /v MSTakeNoAction /t REG_NONE /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\CameraAlternate\ShowPicturesOnArrival" /v MSTakeNoAction /t REG_NONE /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\StorageOnArrival" /v MSTakeNoAction /t REG_NONE /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP\SettingsPage" /v BluetoothLastDisabledNearShare /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v NearShareChannelUserAuthzPolicy /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v CdpSessionUserAuthzPolicy /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoLowDiskSpaceChecks /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d 2000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v WaitToKillAppTimeOut /t REG_SZ /d 2000 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 2000 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v AutoReboot /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v LogEvent /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v DisplayParameters /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl\StorageTelemetry" /v DeviceDumpEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v DisableWpbtExecution /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /ve /t REG_SZ /d "All Tasks" /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /v InfoTip /t REG_SZ /d "View list of all Control Panel tasks" /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /v System.ControlPanel.Category /t REG_SZ /d 5 /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}\DefaultIcon" /ve /t REG_SZ /d "%%windir%%\System32\imageres.dll,-27" /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}\Shell\Open\Command" /ve /t REG_SZ /d "explorer.exe shell:::{ED7BA470-8E54-465E-825C-99712043E01C}" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /ve /t REG_SZ /d "All Tasks" /f >nul 2>&1

rem --- Автообновления и WU
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAUAsDefaultShutdownOption /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v HideMCTLink /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ManagePreviewBuilds /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ManagePreviewBuildsPolicyValue /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v AllowBuildPreview /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v EnableConfigFlighting /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v EnableExperimentation /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v HideInsiderPage /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontReportInfectionInformation /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\RemovalTools\MpGears" /v HeartbeatTrackingIndex /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\RemovalTools\MpGears" /v SpyNetReportingLocation /t REG_MULTI_SZ /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v TargetReleaseVersion /t REG_DWORD /d 1 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "$os=(Get-CimInstance Win32_OperatingSystem).Caption; $a=if($os -match '11'){'Windows 11'}else{'Windows 10'}; New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name 'ProductVersion' -Value $a -PropertyType String -Force | Out-Null; $ver=(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').DisplayVersion; New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name 'TargetReleaseVersion' -Value $ver -PropertyType String -Force | Out-Null" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 2 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\DevHomeUpdate" /v workCompleted /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\OutlookUpdate" /v workCompleted /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v AUPowerManagement /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >nul 2>&1

rem ================================================================================================
rem  11. Безопасность
rem ================================================================================================
echo.
echo [11/15] Security tweaks...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RestrictAnonymousSAM /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowFullControl /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f >nul 2>&1
netsh advfirewall firewall set rule group="Remote Assistance" new enable=no >nul 2>&1

rem ================================================================================================
rem  12. Прочее
rem ================================================================================================
echo.
echo [12/15] Misc: time servers, perf counters...
sc config w32time start= demand >nul 2>&1
sc start w32time >nul 2>&1
w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org" >nul 2>&1
w32tm /config /update >nul 2>&1
w32tm /resync >nul 2>&1
lodctr /r >nul 2>&1
lodctr /r >nul 2>&1
winmgmt /resyncperf >nul 2>&1

rem ================================================================================================
rem  13. Опциональные твики
rem ================================================================================================
echo.
echo [13/15] Optional tweaks (answer carefully)...

reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\KernelShadowStacks" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RunAsPPL /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >nul 2>&1

rem ================================================================================================
rem  Отключение митигаций CPU
rem ================================================================================================
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DisableExceptionChainValidation /t REG_DWORD /d 1 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ProcessMitigation -System -Disable CFG" >nul 2>&1
set "mask="
for /f "tokens=3 skip=2" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" 2^>nul') do set "mask=%%a"
if defined mask (
    for /l %%i in (0,1,9) do set "mask=!mask:%%i=2!"
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v MitigationAuditOptions /t REG_BINARY /d "!mask!" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v MitigationOptions /t REG_BINARY /d "!mask!" /f >nul 2>&1
)
bcdedit /set nx OptIn >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v ProtectionMode /t REG_DWORD /d 0 /f >nul 2>&1

rem ================================================================================================
rem  14. Финал
rem ================================================================================================
echo.
echo [14/15] Finalizing...
reg add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d RemoteSigned /f >nul 2>&1

echo.
echo [15/15] Done.
echo.
echo  Reboot the PC now to apply all changes.
echo  If some AppX packages failed to be removed, they will disappear after reboot
echo  or can be re-removed via the Microsoft Store uninstall.
echo.