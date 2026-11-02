@echo off
chcp 65001 >nul
echo Очистка кэша браузеров...
taskkill /f /im chrome.exe  /t >nul 2>&1
taskkill /f /im msedge.exe  /t >nul 2>&1
taskkill /f /im browser.exe /t >nul 2>&1
taskkill /f /im opera.exe   /t >nul 2>&1
taskkill /f /im firefox.exe /t >nul 2>&1

del /f /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*.*"              >nul 2>&1
del /f /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Code Cache\*.*"         >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*.*"             >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Code Cache\*.*"        >nul 2>&1
del /f /s /q "%LocalAppData%\Yandex\YandexBrowser\User Data\Default\Cache\*.*"       >nul 2>&1
del /f /s /q "%LocalAppData%\Yandex\YandexBrowser\User Data\Default\Code Cache\*.*"  >nul 2>&1
del /f /s /q "%LocalAppData%\Opera Software\Opera Stable\Cache\*.*"                  >nul 2>&1
del /f /s /q "%LocalAppData%\Mozilla\Firefox\Profiles\*\cache2\*.*"                  >nul 2>&1
echo Готово.
