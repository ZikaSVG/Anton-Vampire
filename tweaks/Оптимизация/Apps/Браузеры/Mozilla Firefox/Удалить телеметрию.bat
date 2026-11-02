:: Остановка службы Mozilla Maintenance
SC STOP MozillaMaintenance
:: Отключение автоматического запуска службы Mozilla Maintenance
SC CONFIG MozillaMaintenance start= disabled
:: Удаление службы Mozilla Maintenance
SC DELETE MozillaMaintenance
:: Добавление политик для Firefox
:: Отключение телеметрии
reg add "HKU\%~1\Software\Policies\Mozilla\Firefox" /v "DisableTelemetry" /t REG_DWORD /d 1 /f 
:: Отключение Pocket
reg add "HKU\%~1\Software\Policies\Mozilla\Firefox" /v "DisablePocket" /t REG_DWORD /d 1 /f 
:: Отключение Captive Portal, отключает обнаружение портала захвата
reg add "HKU\%~1\Software\Policies\Mozilla\Firefox" /v "CaptivePortal" /t REG_DWORD /d 0 /f 
:: Отключение Firefox Studies, отключает участие в исследованиях Firefox
reg add "HKU\%~1\Software\Policies\Mozilla\Firefox" /v "DisableFirefoxStudies" /t REG_DWORD /d 1 /f 
:: Установка и настройка расширения uBlock Origin
reg add "HKU\%~1\Software\Policies\Mozilla\Firefox" /v "ExtensionSettings" /t REG_MULTI_SZ /d "{\0    \"uBlock0@raymondhill.net\": {\0        \"installation_mode\": \"force_installed\",\0        \"install_url\": \"https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi\"\0    }\0}" /f 
:: Отключение Default Browser Agent
reg add "HKU\%~1\Software\Policies\Mozilla\Firefox" /v "DisableDefaultBrowserAgent" /t REG_DWORD /d 1 /f 
:: Установка предпочтений для Firefox, добавляет несколько настроек для браузера, включая блокировку cookie и настройки новой вкладки
reg add "HKU\%~1\Software\Policies\Mozilla\Firefox" /v "Preferences" /t REG_MULTI_SZ /d "{\"network.cookie.sameSite.laxByDefault\":{\"Value\":true,\"Status\":\"user\"},\"network.cookie.sameSite.noneRequiresSecure\":{\"Value\":true,\"Status\":\"user\"},\"network.cookie.sameSite.schemeful\":{\"Value\":true,\"Status\":\"user\"},\"browser.contentblocking.category\":{\"Value\":\"strict\",\"Status\":\"user\"},\"browser.newtabpage.activity-stream.showSponsored\":{\"Value\":false,\"Status\":\"user\"},\"browser.newtabpage.activity-stream.showSponsoredTopSites\":{\"Value\":false,\"Status\":\"user\"}}" /f 
:: Удаление службы Mozilla Maintenance
"%ProgramFiles(x86)%\Mozilla Maintenance Service\uninstall.exe" /S