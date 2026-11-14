@echo off
setlocal

fltmc >nul 2>&1 || (echo [ERROR] Run as Administrator & pause & exit /b 1)

set "GUID_BAL=90a358c8-3bbc-4fb3-8b4e-d7ab065d2614"
set "GUID_MAX=a1b2c3d4-e5f6-4789-a0ab-cdef12345678"
set "GUID_SAV=d8e76bb7-6943-4b7c-ab30-441296b72264"

set "BASE_BAL=381b4222-f694-41f0-9685-ff5bb260df2e"
set "BASE_MAX=8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
set "BASE_SAV=a1841308-3541-4fab-bc81-f71556f20b4a"

:: --- GUIDs подсистем ---
set "SUB_DISK=0012ee47-9041-4b5d-9b77-535fba8b1442"
set "DISKIDLE=6738e2c4-e8a5-4a42-b16a-e040e769756e"
set "SUB_USB=2a737441-1930-4402-8d77-b2bebba308a3"
set "USBSUSPEND=48e6b7a6-50f5-4782-a5d4-53bb8f07e226"
set "SUB_VIDEO=7516b95f-f776-4464-8c53-06167f40cc99"
set "VIDEOIDLE=3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e"

echo Switching to standard Balanced scheme before cleanup...
powercfg /setactive %BASE_BAL% >nul 2>&1

echo Removing old custom schemes...
powercfg /delete %GUID_BAL% >nul 2>&1
powercfg /delete %GUID_MAX% >nul 2>&1
powercfg /delete %GUID_SAV% >nul 2>&1

echo Creating schemes...
powercfg /duplicatescheme %BASE_BAL% %GUID_BAL% >nul || goto :fail
powercfg /duplicatescheme %BASE_MAX% %GUID_MAX% >nul || goto :fail
powercfg /duplicatescheme %BASE_SAV% %GUID_SAV% >nul || goto :fail

powercfg /changename %GUID_BAL% "Balanced Performance VampireOS" "Balanced performance for everyday tasks and gaming." >nul
powercfg /changename %GUID_MAX% "Maximum Performance VampireOS" "Maximum performance in games and work applications." >nul
powercfg /changename %GUID_SAV% "Power Saving VampireOS" "Reduced power consumption and maximum battery life." >nul

echo Applying safe tweaks...

:: --- HDD: никогда не отключать диск (0 = never) ---
:: Это предотвращает частые остановки/раскрутки механического HDD.
:: На SSD эта настройка не влияет.
powercfg /setacvalueindex %GUID_BAL% %SUB_DISK% %DISKIDLE% 0
powercfg /setdcvalueindex %GUID_BAL% %SUB_DISK% %DISKIDLE% 0
powercfg /setacvalueindex %GUID_MAX% %SUB_DISK% %DISKIDLE% 0
powercfg /setdcvalueindex %GUID_MAX% %SUB_DISK% %DISKIDLE% 0
powercfg /setacvalueindex %GUID_SAV% %SUB_DISK% %DISKIDLE% 0
powercfg /setdcvalueindex %GUID_SAV% %SUB_DISK% %DISKIDLE% 0

:: --- USB: отключить selective suspend (0 = disabled) ---
:: Чтобы внешние диски, мыши, хабы не «засыпали» и не давали задержек.
powercfg /setacvalueindex %GUID_BAL% %SUB_USB% %USBSUSPEND% 0
powercfg /setdcvalueindex %GUID_BAL% %SUB_USB% %USBSUSPEND% 0
powercfg /setacvalueindex %GUID_MAX% %SUB_USB% %USBSUSPEND% 0
powercfg /setdcvalueindex %GUID_MAX% %SUB_USB% %USBSUSPEND% 0
powercfg /setacvalueindex %GUID_SAV% %SUB_USB% %USBSUSPEND% 0
powercfg /setdcvalueindex %GUID_SAV% %SUB_USB% %USBSUSPEND% 0

:: --- Экран: безопасные тайм-ауты ---
:: Balanced: 15 мин от сети / 5 мин от батареи
powercfg /setacvalueindex %GUID_BAL% %SUB_VIDEO% %VIDEOIDLE% 900
powercfg /setdcvalueindex %GUID_BAL% %SUB_VIDEO% %VIDEOIDLE% 300

:: Maximum: 15 мин от сети / 10 мин от батареи
powercfg /setacvalueindex %GUID_MAX% %SUB_VIDEO% %VIDEOIDLE% 900
powercfg /setdcvalueindex %GUID_MAX% %SUB_VIDEO% %VIDEOIDLE% 600

:: Power Saving: 5 мин от сети / 2 мин от батареи
powercfg /setacvalueindex %GUID_SAV% %SUB_VIDEO% %VIDEOIDLE% 300
powercfg /setdcvalueindex %GUID_SAV% %SUB_VIDEO% %VIDEOIDLE% 120

powercfg /setactive %GUID_BAL%

echo.
echo Done. Three safe schemes created.
echo Active: Balanced Performance VampireOS
echo.
powercfg /list
pause
exit /b 0

:fail
echo [FAIL] Could not create one of the schemes.
pause
exit /b 1