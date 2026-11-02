@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\DeviceDirectoryClient\HandleCommand"
    "\Microsoft\Windows\DeviceDirectoryClient\HandleWnsCommand"
    "\Microsoft\Windows\DeviceDirectoryClient\IntegrityCheck"
    "\Microsoft\Windows\DeviceDirectoryClient\LocateCommandUserSession"
    "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceAccountChange"
    "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceLocationRightsChange"
    "\Microsoft\Windows\DeviceDirectoryClient\RegisterDevicePeriodic24"
    "\Microsoft\Windows\DeviceDirectoryClient\RegisterDevicePolicyChange"
    "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceProtectionStateChanged"
    "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceSettingChange"
    "\Microsoft\Windows\DeviceDirectoryClient\RegisterUserDevice"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul