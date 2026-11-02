@echo off
TITLE Discord Debloat by CatGamerOP
echo Discord Debloat by CatGamerOP
TASKKILL /T /F /IM Discord.exe >nul 2>&1
DEL "%HOMEPATH%\Desktop\Discord.lnk" /F /Q
del /f /q %LOCALAPPDATA%\Discord\app.ico, %LOCALAPPDATA%\Discord\Discord_updater*, %LOCALAPPDATA%\Discord\SquirrelSetup*, %LOCALAPPDATA%\Discord\Update.exe >nul 2>&1
rmdir /s /q "%LOCALAPPDATA%\Discord\Packages" >nul 2>&1
rmdir /s /q "%LOCALAPPDATA%\Discord\app-1.0.9007" >nul 2>&1
rmdir /s /q "%LOCALAPPDATA%\Discord\app-1.0.9008" >nul 2>&1
rmdir /s /q "%LOCALAPPDATA%\Discord\app-1.0.9009" >nul 2>&1
rmdir /s /q "%LOCALAPPDATA%\Discord\app-1.0.9010" >nul 2>&1
rmdir /s /q "%LOCALAPPDATA%\Discord\app-1.0.9011" >nul 2>&1
rmdir /s /q "%LOCALAPPDATA%\Discord\app-1.0.9012" >nul 2>&1
cd /d %LOCALAPPDATA%\Discord\app-1.0.??1? >nul 2>&1
del /f /q app.ico >nul 2>&1
rmdir /s /q swiftshader >nul 2>&1
cd /d %LOCALAPPDATA%\Discord\app-1.0.*\modules >nul 2>&1
for %%a in ("discord_cloudsync-1" "discord_dispatch-1" "discord_erlpack-1" "discord_game_utils-1" "discord_media-1" "discord_spellcheck-1" "discord_hook-1") do rmdir /s /q "%%~a" >nul 2>&1
CHOICE /C YN /M "Would you like to remove overlay?"
IF %ERRORLEVEL% EQU 1 (
cd /d %LOCALAPPDATA%\Discord\app-1.0.*\modules   >nul 2>&1
for %%b in ("discord_rpc-1" "discord_overlay-1") do rmdir /s /q "%%~b"  >nul 2>&1
@echo Done!
)
cd /d %LOCALAPPDATA%\Discord\app-1.0.* >nul 2>&1
copy "locales\en-US.pak" "%LOCALAPPDATA%\Discord\" >nul 2>&1
rmdir /s /q "locales" >nul 2>&1
mkdir "locales" >nul 2>&1
move "%LOCALAPPDATA%\Discord\en-US.pak" "locales" >nul 2>&1
del /f /q chrome*.pak >nul 2>&1
mklink "Discord Debloated.exe" "%cd%\Discord.exe" >nul 2>&1
move "Discord Debloated.exe" %HOMEPATH%\Desktop >nul 2>&1
:: Used to be Matekoo's script, but it was too big :/