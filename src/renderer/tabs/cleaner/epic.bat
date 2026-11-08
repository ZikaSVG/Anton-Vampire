@echo off
chcp 65001 >nul
echo Очистка кэша Epic Games Launcher...
taskkill /f /im EpicGamesLauncher.exe /t >nul 2>&1
del /f /s /q "%LocalAppData%\EpicGamesLauncher\Saved\webcache\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\EpicGamesLauncher\Saved\Logs\*.*"     >nul 2>&1
del /f /s /q "%LocalAppData%\EpicGamesLauncher\Saved\Crashes\*.*"  >nul 2>&1
echo Готово.
