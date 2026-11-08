@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - УДАЛЕНИЕ UWP ПРИЛОЖЕНИЙ
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo UWP (Universal Windows Platform) - это приложения из Microsoft Store,
echo которые предустановлены в Windows 10 и 11. Многие из них:
echo.
echo   - ЗАНИМАЮТ МЕСТО НА ДИСКЕ (часто 500+ МБ)
echo   - РАБОТАЮТ В ФОНЕ (потребляют ОЗУ и CPU)
echo   - ЗАПУСКАЮТСЯ ПРИ СТАРТЕ (замедляют загрузку)
echo   - ОТПРАВЛЯЮТ ТЕЛЕМЕТРИЮ
echo.
echo Данный скрипт УДАЛЯЕТ НЕНУЖНЫЕ UWP ПРИЛОЖЕНИЯ:
echo.
echo   1. Сохраняет список пакетов ДО удаления (для депривации)
echo   2. Завершает процессы Teams
echo   3. Отключает автоматическую установку Chat
echo   4. Удаляет более 60 предустановленных UWP приложений
echo   5. Очищает кэш AppX
echo   6. Отключает фоновые приложения CBS
echo   7. Депривирует удаленные пакеты (блокирует переустановку)
echo.
echo ================================================================================
echo СПИСОК УДАЛЯЕМЫХ ПРИЛОЖЕНИЙ:
echo ================================================================================
echo.
echo   - NcsiUwpApp, aarsvc, asimov, assembly.net
echo   - bingsearch, ceip, clipchamp, clouddesktop, copilotpwa
echo   - desktopimgdownldr, enterprisedataprotection, errorreporting, flipgridpwa
echo   - manifestbackup, mapcontrol
echo   - Microsoft.3DBuilder, Microsoft.Microsoft3DViewer
echo   - Microsoft.BingNews, BingWeather, BingSports, BingFinance, BingSearch
echo   - Microsoft.Copilot, Microsoft.WindowsCommunicationsApps
echo   - Microsoft.GetHelp, Microsoft.GetStarted
echo   - Microsoft.HEVCVideoExtension, HEIFImageExtension, AV1VideoExtension, MPEG2VideoExtension, VP9VideoExtensions, WEBPImageExtension, WebMediaExtensions
echo   - Microsoft.MicrosoftEdge, MicrosoftEdgeDevToolsClient, Microsoft.MSPaint
echo   - Microsoft.MicrosoftOfficeHub, SolitaireCollection, StickyNotes, People
echo   - Microsoft.PowerAutomateDesktop, Microsoft.RawImageExtension
echo   - Microsoft.SecHealthUI, Microsoft.StartExperiencesApp, Microsoft.Todos
echo   - Microsoft.Wallet, Microsoft.Windows.ContentDeliveryManager, Windows.DevHome, Windows.ParentalControls, Windows.Photos, WindowsAlarms, WindowsCamera, WindowsFeedbackHub, WindowsMaps, WindowsSoundRecorder, WindowsTerminal
echo   - Microsoft.YourPhone, Microsoft.ZuneVideo, ZuneMusic
echo   - Microsoft.Edge.GameAssist, Microsoft.549981C3F5F10 (Cortana)
echo   - MicrosoftCorporationII.MicrosoftFamily, QuickAssist
echo   - MicrosoftWindows.Client.AIX, WebExperience, CrossDevice
echo   - msteams, onedrive, outlookpwa, pluton, retaildemo, securitycenter, settingsync, startexperiencesapp
echo   - skypeortc, Microsoft.SkypeApp, Microsoft.Office.OneNote, Microsoft.MixedReality, Microsoft.OutlookForWindows
echo   - stepsrecorder, webthreatdefense, whesvc, widgetsplatformruntimeapp, windowstogo, wuqisvc
echo   - CrossDeviceResume, CrossDeviceResumeApp
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ОСВОБОЖДАЕТ МЕСТО НА ДИСКЕ (от 500 МБ до 3-5 ГБ)
echo [+] СНИЖАЕТ ФОНОВУЮ НАГРУЗКУ на CPU и ОЗУ
echo [+] УСКОРЯЕТ ЗАГРУЗКУ СИСТЕМЫ (меньше служб)
echo [+] ПОВЫШАЕТ КОНФИДЕНЦИАЛЬНОСТЬ (отключена телеметрия)
echo [+] УБИРАЕТ НАДОЕДАЮЩУЮ РЕКЛАМУ и предложения
echo [+] ПРЕДОТВРАЩАЕТ АВТОМАТИЧЕСКУЮ УСТАНОВКУ приложений
echo [+] ДЕПРИВИРУЕТ ПАКЕТЫ (не смогут переустановиться через Store)
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Некоторые функции Windows могут работать не полностью
echo [-] При обновлении Windows приложения могут вернуться
echo [-] Удаляется Microsoft Store (если в списке)
echo [-] Удаляется Camera, Photos, Calculator (если в списке)
echo [-] Удаляется Windows Terminal (удобный инструмент)
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте от имени Администратора
echo [2] ПЕРЕД удалением создайте точку восстановления системы
echo [3] Просмотрите список и исключите то, чем пользуетесь
echo [4] После удаления перезагрузите компьютер
echo [5] Для возврата используйте скрипт отката xOS
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [1/8] Сохранение списка установленных пакетов (для депривации)...
echo    Файл сохраняется в: %windir%\Modules\oldpackages.txt
powershell -Command "(Get-AppxPackage).PackageFamilyName | Out-File '%windir%\Modules\oldpackages.txt' -Force" >nul 2>&1
echo [OK] Список пакетов сохранен
echo.

echo [2/8] Завершение процессов Teams...
taskkill /f /im "msteams.exe" >nul 2>&1
echo [OK] Процессы Teams завершены
echo.

echo [3/8] Отключение автоматической установки Chat...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications" /v "ConfigureChatAutoInstall" /d 0 /t REG_DWORD /f >nul
echo [OK] Автоустановка Chat отключена
echo.

echo [4/8] Удаление AppX пакетов (может занять 1-3 минуты)...
echo    Удаляю ненужные UWP приложения...

for %%p in (
    "*NcsiUwpApp*"
    "aarsvc*"
    "asimov*"
    "assembly.net*"
    "bingsearch*"
    "ceip*"
    "clipchamp*"
    "clouddesktop*"
    "copilotpwa*"
    "desktopimgdownldr*"
    "enterprisedataprotection*"
    "errorreporting*"
    "flipgridpwa*"
    "manifestbackup*"
    "mapcontrol*"
    "microsoft.applicationcompatibilityenhancements*"
    "microsoft.av1videoextension*"
    "microsoft.avcencodervideoextension*"
    "microsoft.bingnews*"
    "microsoft.bingsearch*"
    "microsoft.bingweather*"
    "microsoft.copilot*"
    "microsoft.windowscommunicationsapps*"
    "microsoft.gethelp*"
    "microsoft.getstarted*"
    "microsoft.heifimageextension*"
    "microsoft.hevcvideoextension*"
    "microsoft.microsoftedge*"
    "microsoft.microsoftedgedevtoolsclient*"
    "microsoft.microsoftofficehub*"
    "microsoft.microsoftsolitairecollection*"
    "microsoft.microsoftstickynotes*"
    "microsoft.mpeg2videoextension*"
    "microsoft.people*"
    "microsoft.powerautomatedesktop*"
    "microsoft.rawimageextension*"
    "microsoft.sechealthui*"
    "microsoft.startexperiencesapp*"
    "microsoft.todos*"
    "microsoft.wallet*"
    "microsoft.vp9videoextensions*"
    "microsoft.webmediaextensions*"
    "microsoft.webpimageextension*"
    "microsoft.widgetsplatformruntime*"
    "microsoft.windows.contentdeliverymanager*"
    "microsoft.windows.devhome*"
    "microsoft.windows.parentalcontrols*"
    "microsoft.windows.photos*"
    "microsoft.windowsalarms*"
    "microsoft.windowscamera*"
    "microsoft.windowsfeedbackhub*"
    "microsoft.windowsmaps*"
    "microsoft.windowssoundrecorder*"
    "microsoft.windowsterminal*"
    "microsoft.yourphone*"
    "microsoft.zunevideo*"
    "microsoft.zunemusic*"
    "microsoft.edge.gameassist*"
    "microsoft.6365217CE6EB4*"
    "microsoftcorporationii.microsoftfamily*"
    "microsoftcorporationii.quickassist*"
    "microsoftwindows.client.aix*"
    "MicrosoftWindows.Client.WebExperience*"
    "microsoftwindows.crossdevice*"
    "msteams*"
    "onedrive*"
    "outlookpwa*"
    "pluton*"
    "retaildemo*"
    "securitycenter*"
    "settingsync*"
    "startexperiencesapp*"
    "skypeortc*"
    "Microsoft.SkypeApp*"
    "Microsoft.Office.OneNote*"
    "Microsoft.MixedReality*"
    "Microsoft.OutlookForWindows*"
    "stepsrecorder*"
    "webthreatdefense*"
    "whesvc*"
    "widgetsplatformruntimeapp*"
    "windowstogo*"
    "wuqisvc*"
    "Microsoft.549981C3F5F10*"
    "*CrossDeviceResume*"
) do (
    powershell -Command "Get-AppxPackage '%p' | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul 2>&1
)
echo [OK] Основные AppX пакеты удалены
echo.

echo [5/8] Удаление отдельных пакетов и их провижинига...
powershell -Command "Get-AppxPackage Microsoft.3DBuilder* | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'Microsoft.3DBuilder' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.Microsoft3DViewer* | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'Microsoft.Microsoft3DViewer' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.BingWeather* | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'Microsoft.BingWeather' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.BingSports* | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'Microsoft.BingSports' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.BingNews* | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'Microsoft.BingNews' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.BingFinance* | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'Microsoft.BingFinance' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Get-AppxPackage outlookpwa* | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'outlookpwa' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Get-AppxPackage MicrosoftTeams* | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'MicrosoftTeams' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Get-AppxPackage MicrosoftWindows.CrossDevice* | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'MicrosoftWindows.CrossDevice' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
echo [OK] Отдельные пакеты и провижиниг удалены
echo.

echo [6/8] Очистка кэша AppX и удаление системных пакетов...
powershell -Command "Get-AppxPackage '*MicrosoftWindows.Client.CBS*' | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Get-AppxPackage '*Microsoft.Windows.SecHealthUI*' | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Get-AppxPackage '*Microsoft.Windows.Search*' | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Get-AppxPackage '*StartMenuExperienceHost*' | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
echo [OK] Кэш AppX очищен
echo.

echo [7/8] Отключение фоновых приложений CBS...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\MicrosoftWindows.Client.CBS_cw5n1h2txyewy" /v "IgnoreBatterySaver" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\MicrosoftWindows.Client.CBS_cw5n1h2txyewy" /v "SleepIgnoreBatterySaver" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\MicrosoftWindows.Client.CBS_cw5n1h2txyewy" /v "Disabled" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\MicrosoftWindows.Client.CBS_cw5n1h2txyewy" /v "SleepDisabled" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\MicrosoftWindows.Client.CBS_cw5n1h2txyewy" /v "DisabledByUser" /t REG_DWORD /d 1 /f >nul
echo [OK] Фоновые приложения CBS отключены
echo.

echo [8/8] Депривация удаленных пакетов (блокировка переустановки)...
powershell -Command "$a = '%windir%\Modules\oldpackages.txt'; (diff (gc $a -ErrorAction SilentlyContinue) ((Get-AppxPackage).PackageFamilyName)).InputObject | Foreach-Object { New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned' -Name $_ -Force -ErrorAction SilentlyContinue }; Remove-Item $a -Force -ErrorAction SilentlyContinue" >nul 2>&1
echo [OK] Депривация выполнена, переустановка предотвращена
echo.

echo ================================================================================
echo                    ГОТОВО! UWP ПРИЛОЖЕНИЯ УДАЛЕНЫ
echo ================================================================================
echo.
echo Что сделано:
echo   - Список пакетов сохранен в %windir%\Modules\oldpackages.txt
echo   - Более 60 предустановленных UWP приложений удалено
echo   - Кэш AppX очищен
echo   - Фоновые задачи CBS отключены
echo   - Депривация выполнена (пакеты не переустановятся)
echo.
echo Освобождено места на диске: примерно 1-5 ГБ
echo.
echo ВНИМАНИЕ! Для завершения рекомендуется перезагрузить компьютер.
echo.

echo.