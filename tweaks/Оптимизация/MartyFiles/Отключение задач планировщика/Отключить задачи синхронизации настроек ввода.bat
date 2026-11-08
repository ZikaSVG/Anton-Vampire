@echo off
chcp 866 >nul

:: Отключить задачи синхронизации настроек ввода (мышь, перо, тачпад)
for %%T in (
    "\Microsoft\Windows\input\InputSettingsRestoreDataAvailable"
    "\Microsoft\Windows\input\LocalUserSyncDataAvailable"
    "\Microsoft\Windows\input\MouseSyncDataAvailable"
    "\Microsoft\Windows\input\PenSyncDataAvailable"
    "\Microsoft\Windows\input\RemoteMouseSyncDataAvailable"
    "\Microsoft\Windows\input\RemotePenSyncDataAvailable"
    "\Microsoft\Windows\input\RemoteTouchpadSyncDataAvailable"
    "\Microsoft\Windows\input\TouchpadSyncDataAvailable"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul