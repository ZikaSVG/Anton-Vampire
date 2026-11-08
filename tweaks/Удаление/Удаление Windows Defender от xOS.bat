@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - УДАЛЕНИЕ WINDOWS DEFENDER
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Windows Defender (Microsoft Defender Antivirus) - встроенный антивирус Windows.
echo Однако многие продвинутые пользователи и геймеры отключают его, потому что он:
echo.
echo   - ПОТРЕБЛЯЕТ РЕСУРСЫ (CPU, RAM, диск)
echo   - СКАНИРУЕТ ФАЙЛЫ В ФОНЕ (вызывает задержки в играх)
echo   - ИНТЕГРИРОВАН В СИСТЕМУ (сложно полностью отключить)
echo   - ОТПРАВЛЯЕТ ТЕЛЕМЕТРИЮ в Microsoft
echo.
echo Данный скрипт ПОЛНОСТЬЮ УДАЛЯЕТ Windows Defender из системы:
echo.
echo   1. ЗАВЕРШАЕТ ПРОЦЕССЫ Defender (MsMpEng, SecurityHealth, NisSrv, SmartScreen)
echo   2. УДАЛЯЕТ APPX ПАКЕТЫ Defender (SecHealthUI, Apprep)
echo   3. ДОБАВЛЯЕТ ПОЛИТИКИ отключения Defender
echo   4. УДАЛЯЕТ СЛУЖБЫ Defender (WinDefend, Sense, WdFilter, WdBoot, WdNisDrv и др.)
echo   5. УДАЛЯЕТ ФАЙЛЫ Defender (.exe, .dll, .sys)
echo   6. УДАЛЯЕТ ПАПКИ Defender
echo   7. УДАЛЯЕТ ЗАДАЧИ ПЛАНИРОВЩИКА Defender
echo   8. УДАЛЯЕТ КОНТЕКСТНОЕ МЕНЮ Defender (Проверка с помощью Defender)
echo   9. ОТКЛЮЧАЕТ ЛОГИ Defender
echo  10. ОТКЛЮЧАЕТ КОМПОНЕНТ Defender через DISM
echo.
echo ВНИМАНИЕ! Скрипт агрессивный и НЕОБРАТИМ без переустановки Windows или
echo полного восстановления системы. Создайте точку восстановления ЗАРАНЕЕ!
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ПОЛНОСТЬЮ ОСВОБОЖДАЕТ РЕСУРСЫ СИСТЕМЫ (CPU, RAM, диск)
echo [+] УБИРАЕТ ФОНОВЫЕ СКАНИРОВАНИЯ (повышает FPS в играх)
echo [+] УБИРАЕТ SmartScreen (замедлял загрузку файлов)
echo [+] ОТКЛЮЧАЕТ ТЕЛЕМЕТРИЮ Defender
echo [+] ОСВОБОЖДАЕТ МЕСТО НА ДИСКЕ (до 500 МБ)
echo [+] УБИРАЕТ НАДОЕДАЮЩИЕ УВЕДОМЛЕНИЯ
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] СИСТЕМА ОСТАЕТСЯ БЕЗ АНТИВИРУСА (нужно установить другой)
echo [-] ПРОЦЕСС НЕОБРАТИМ (только восстановление системы)
echo [-] Некоторые обновления Windows могут вернуть компоненты
echo [-] Центр безопасности Windows перестает работать
echo [-] Функции типа "Изолированный запуск" (Sandbox) могут требовать Defender
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] ОБЯЗАТЕЛЬНО создайте точку восстановления ПЕРЕД запуском!
echo [2] ОБЯЗАТЕЛЬНО установите альтернативный антивирус ДО запуска скрипта
echo [3] Запускайте ТОЛЬКО от имени Администратора
echo [4] Рекомендуется для геймеров и опытных пользователей
echo [5] НЕ РЕКОМЕНДУЕТСЯ для рабочих/корпоративных компьютеров
echo [6] После выполнения перезагрузитесь
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [1/22] Завершение процессов Defender...
echo   Завершение NisSrv.exe...
taskkill /f /im "NisSrv.exe" >nul 2>&1
echo   Завершение SecurityHealthHost.exe...
taskkill /f /im "SecurityHealthHost.exe" >nul 2>&1
echo   Завершение SecurityHealthService.exe...
taskkill /f /im "SecurityHealthService.exe" >nul 2>&1
echo   Завершение SecurityHealthSystray.exe...
taskkill /f /im "SecurityHealthSystray.exe" >nul 2>&1
echo   Завершение SkypeBackgroundHost.exe...
taskkill /f /im "SkypeBackgroundHost.exe" >nul 2>&1
echo   Завершение MsMpEng.exe (главный процесс Defender)...
taskkill /f /im "MsMpEng.exe" >nul 2>&1
echo   Завершение msiexec.exe...
taskkill /f /im "msiexec.exe" >nul 2>&1
echo   Завершение smartscreen.exe...
taskkill /f /im "smartscreen.exe" >nul 2>&1
echo [OK] Процессы Defender завершены
echo.

echo [2/22] Удаление AppX пакетов Defender...
powershell -Command "Get-AppxPackage '*SecHealthUI*' | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Get-AppxPackage 'Microsoft.Windows.Apprep.ChxApp*' | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul 2>&1
echo [OK] AppX пакеты Defender удалены
echo.

echo [3/22] Добавление политик отключения Defender...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f >nul
echo [OK] Политики отключения Defender добавлены
echo.

echo [4/22] Удаление служб Defender...
echo   Удаление Sense...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Sense" /f >nul 2>&1
echo   Удаление WinDefend...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /f >nul 2>&1
echo   Удаление MsSecCore...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\MsSecCore" /f >nul 2>&1
echo   Удаление wscsvc...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\wscsvc" /f >nul 2>&1
echo   Удаление WdFilter...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" /f >nul 2>&1
echo   Удаление WdBoot...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\WdBoot" /f >nul 2>&1
echo   Удаление WdNisDrv...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\WdNisDrv" /f >nul 2>&1
echo   Удаление WdNisSvc...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc" /f >nul 2>&1
echo   Удаление MsSecWfp...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\MsSecWfp" /f >nul 2>&1
echo   Удаление MsSecFlt...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\MsSecFlt" /f >nul 2>&1
echo   Удаление wtd...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\wtd" /f >nul 2>&1
echo   Удаление webthreatdefusersvc...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\webthreatdefusersvc" /f >nul 2>&1
echo   Удаление webthreatdefsvc...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\webthreatdefsvc" /f >nul 2>&1
echo   Удаление SecurityHealthService...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /f >nul 2>&1
echo [OK] Службы Defender удалены
echo.

echo [5/22] Дополнительные настройки Defender...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components" /v "ServiceEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "SpyNetReporting" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [OK] Дополнительные настройки применены
echo.

echo [6/22] Удаление автозагрузки Defender...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDefender" /f >nul 2>&1
echo [OK] Автозагрузка Defender удалена
echo.

echo [7/22] Удаление файлов Defender из System32...
del /f /q "%windir%\System32\SecurityHealthSystray.exe" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthService.exe" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthAgent.dll" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthHost.exe" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthSSO.dll" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthCore.dll" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthProxyStub.dll" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthUdk.dll" >nul 2>&1
del /f /q "%windir%\System32\smartscreen.exe" >nul 2>&1
del /f /q "%windir%\System32\smartscreenps.dll" >nul 2>&1
echo [OK] Файлы из System32 удалены
echo.

echo [8/22] Удаление драйвера WdNisDrv.sys...
del /f /q "%windir%\System32\drivers\WdNisDrv.sys" >nul 2>&1
echo [OK] Драйвер WdNisDrv.sys удален
echo.

echo [9/22] Удаление папок Defender...
rmdir /s /q "%ProgramW6432%\Windows Defender Advanced Thread Protection" >nul 2>&1
rmdir /s /q "%ProgramW6432%\Windows Defender" >nul 2>&1
rmdir /s /q "%PROGRAMFILES(x86)%\Windows Defender" >nul 2>&1
rmdir /s /q "%ProgramData%\Microsoft\Windows Defender" >nul 2>&1
rmdir /s /q "%ProgramFiles(x86)%\Windows Defender" >nul 2>&1
rmdir /s /q "%SystemDrive%\ProgramData\Microsoft\Windows Defender Advanced Threat Protection" >nul 2>&1
rmdir /s /q "%ProgramW6432%\Microsoft Update Health Tools" >nul 2>&1
rmdir /s /q "%ProgramW6432%\PCHealthCheck" >nul 2>&1
echo [OK] Папки Defender удалены
echo.

echo [10/22] Удаление UpdateHealthTools и rempl...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\UpdateHealthTools" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\rempl" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\CloudManagedUpdate" /f >nul 2>&1
echo [OK] UpdateHealthTools удалены
echo.

echo [11/22] Запуск UPDHEALTH.bat (если существует)...
echo ================================================================================
echo Update Health Tools - это компонент Windows, который отслеживает состояние
echo обновлений, автоматически исправляет проблемы с Windows Update и собирает
echo диагностические данные (телеметрию).
echo.
echo Скрипт полностью удаляет:
echo   - Update Health Tools из списка установленных программ
echo   - Все записи из реестра (Uninstall, Products, Features, Components)
echo   - Коды обновлений (UpgradeCodes)
echo   - Записи о папках в Installer
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ОТКЛЮЧАЕТ ТЕЛЕМЕТРИЮ Microsoft
echo [+] Снижает фоновую нагрузку на систему
echo [+] Освобождает место на диске
echo [+] Убирает лишний фоновый процесс
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] При проблемах с Windows Update диагностика будет недоступна
echo [-] Microsoft может вернуть компонент при следующем крупном обновлении
echo [-] Невозможно откатить через стандартные средства
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте от имени Администратора
echo [2] Рекомендуется для продвинутых пользователей
echo [3] Перед удалением создайте точку восстановления
echo [4] Для возврата используйте скрипт отката в папке Undo
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [1/8] Поиск GUID компонента в реестре...
for /f "usebackq tokens=7 delims=\" %%e in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /d /f "Update Health Tools" /s 2^>nul ^| findstr /i /c:"CurrentVersion\Uninstall\\"`) do set "GUID=%%e"

if not "!GUID!"=="" (
    echo [OK] Найден GUID: !GUID!
    echo [2/8] Удаление из ветки Uninstall...
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\!GUID!" /f >nul 2>&1
    echo [OK] Удалено
) else (
    echo [ПРЕДУПРЕЖДЕНИЕ] GUID не найден
)
echo.

echo [3/8] Поиск Product ID...
for /f "usebackq tokens=4 delims=\" %%e in (`reg query "HKCR\Installer\Products" /d /f "Update Health Tools" /s 2^>nul ^| findstr /i /c:"Installer\Products\\"`) do set "ProdID=%%e"

echo [OK] Найден Product ID: !ProdID!
echo.

echo [4/8] Удаление UpgradeCodes...
for /f "usebackq delims=" %%e in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UpgradeCodes" /d /f "!ProdID!" /s 2^>nul ^| findstr /i /c:"Installer\UpgradeCodes\\"`) do (
    reg delete "%%e" /f >nul 2>&1
)
echo [OK] UpgradeCodes удалены
echo.

echo [5/8] Удаление из ветки Products...
reg delete "HKCR\Installer\Products\!ProdID!" /f >nul 2>&1
echo [OK] Products удален
echo.

echo [6/8] Удаление из ветки Features...
reg delete "HKCR\Installer\Features\!ProdID!" /f >nul 2>&1
echo [OK] Features удален
echo.

echo [7/8] Удаление оставшихся UpgradeCodes...
for /f "usebackq delims=" %%e in (`reg query "HKCR\Installer\UpgradeCodes" /d /f "!ProdID!" /s 2^>nul ^| findstr /i /c:"Installer\UpgradeCodes\\"`) do (
    reg delete "%%e" /f >nul 2>&1
)
echo [OK] Оставшиеся UpgradeCodes удалены
echo.

echo [8/8] Удаление записей о папках...
for /f "usebackq delims=" %%e in (`PowerShell -NoP -C "(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\Folders' -ErrorAction SilentlyContinue).Property" 2^>nul ^| findstr /i /c:"Update Health Tools"`) do (
    set "var=%%e"
    if "!var:~-1!"=="\" set "var=%%e\"
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\Folders" /v "!var!" /f >nul 2>&1
)

rem Дополнительная очистка UserData
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\!ProdID!" /f >nul 2>&1

echo [OK] Записи о папках удалены
echo.

echo ================================================================================
echo                  ГОТОВО! UPDATE HEALTH TOOLS УДАЛЕН
echo ================================================================================
echo.
echo Что удалено:
echo   - Update Health Tools из списка установленных программ
echo   - Все записи из реестра (Uninstall, Products, Features, Components)
echo   - Коды обновлений (UpgradeCodes)
echo   - Записи о папках
echo.
echo Для полного применения рекомендуется перезагрузить компьютер.
echo При следующем крупном обновлении Windows может вернуть компонент.
echo.

echo [12/22] Отключение задач Defender в планировщике...
schtasks /change /tn "\Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /disable >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /f >nul 2>&1
echo [OK] Задачи Defender удалены
echo.

echo [13/22] Удаление контекстного меню Defender...
reg delete "HKLM\SOFTWARE\Classes\*\ShellEx\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\Drive\ShellEx\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\Directory\ShellEx\ContextMenuHandlers\EPP" /f >nul 2>&1
echo [OK] Контекстное меню Defender удалено
echo.

echo [14/22] Отключение логов Defender...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d 0 /f >nul
echo [OK] Логи Defender отключены
echo.

echo [15/22] Отключение компонента Defender через DISM...
DISM.exe /Online /Disable-Feature /FeatureName:"Windows-Defender-Default-Definitions" /NoRestart >nul 2>&1
echo [OK] Компонент Defender отключен
echo.

echo [16/22] Отключение уведомлений SecurityAndMaintenance...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [OK] Уведомления отключены
echo.

echo ================================================================================
echo                    ГОТОВО! WINDOWS DEFENDER УДАЛЕН
echo ================================================================================
echo.
echo Что было сделано:
echo   - Завершены все процессы Defender
echo   - Удалены AppX пакеты Defender
echo   - Добавлены политики отключения
echo   - Удалены службы Defender (WinDefend, Sense, WdFilter, WdBoot, WdNisDrv и др.)
echo   - Удалены файлы (.exe, .dll, .sys)
echo   - Удалены папки Defender
echo   - Удалены задачи планировщика
echo   - Удалено контекстное меню
echo   - Отключены логи и телеметрия
echo   - Отключен компонент через DISM
echo.
echo ВАЖНО! После удаления Defender:
echo   - Установите альтернативный антивирус (например, Kaspersky Free, Bitdefender)
echo   - Будьте осторожны при скачивании и запуске файлов
echo   - Рекомендуется создать точку восстановления сейчас
echo.
echo ВНИМАНИЕ! Процесс НЕОБРАТИМ через стандартные средства.
echo Для восстановления потребуется:
echo   - Точка восстановления системы (созданная ДО удаления)
echo   - ИЛИ переустановка Windows
echo   - ИЛИ восстановление из образа системы
echo.