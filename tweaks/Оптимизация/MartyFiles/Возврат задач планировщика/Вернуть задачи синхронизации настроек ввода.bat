@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\input\InputSettingsRestoreDataAvailable"
    "\Microsoft\Windows\input\LocalUserSyncDataAvailable"
    "\Microsoft\Windows\input\MouseSyncDataAvailable"
    "\Microsoft\Windows\input\PenSyncDataAvailable"
    "\Microsoft\Windows\input\RemoteMouseSyncDataAvailable"
    "\Microsoft\Windows\input\RemotePenSyncDataAvailable"
    "\Microsoft\Windows\input\RemoteTouchpadSyncDataAvailable"
    "\Microsoft\Windows\input\TouchpadSyncDataAvailable"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul