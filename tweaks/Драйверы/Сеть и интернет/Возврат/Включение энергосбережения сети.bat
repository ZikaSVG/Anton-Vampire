@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ВКЛЮЧЕНИЕ ЭНЕРГОСБЕРЕЖЕНИЯ СЕТИ
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Включает обратно все энергосберегающие режимы на сетевых адаптерах,
echo возвращая стандартные настройки Windows.
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] Восстанавливает стандартное энергосбережение Windows
echo [+] На ноутбуках увеличивает время автономной работы
echo [+] Уменьшает нагрев сетевой карты
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Могут вернуться задержки при пробуждении сети
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте на ноутбуках для экономии батареи
echo [2] Запускайте если после оптимизации возникли проблемы
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

for /f %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr "HKEY"') do (

    for /f %%i in ('reg query "%%a" /v "EnablePME" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "EnablePME" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EnablePowerManagement" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "EnablePowerManagement" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "PowerSavingMode" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "PowerSavingMode" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "SavePowerNowEnabled" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "SavePowerNowEnabled" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "AutoPowerSaveModeEnabled" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "AutoPowerSaveModeEnabled" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "ReduceSpeedOnPowerDown" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "ReduceSpeedOnPowerDown" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "PowerDownPll" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "PowerDownPll" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "PowerSaveEnable" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "PowerSaveEnable" /f >nul 2>&1

    for /f %%i in ('reg query "%%a" /v "*EEE" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*EEE" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "AdvancedEEE" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "AdvancedEEE" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EEELinkAdvertisement" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "EEELinkAdvertisement" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EeePhyEnable" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "EeePhyEnable" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EnableGreenEthernet" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "EnableGreenEthernet" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EnableGigaLite" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "EnableGigaLite" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "GigaLite" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "GigaLite" /f >nul 2>&1

    for /f %%i in ('reg query "%%a" /v "*SelectiveSuspend" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*SelectiveSuspend" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EnableAspm" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "EnableAspm" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "ASPM" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "ASPM" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*SipsEnabled" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*SipsEnabled" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "ULPMode" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "ULPMode" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "DMACoalescing" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "DMACoalescing" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EnableModernStandby" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "EnableModernStandby" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EnableD3ColdInS0" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "EnableD3ColdInS0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "LTROBFF" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "LTROBFF" /f >nul 2>&1

    for /f %%i in ('reg query "%%a" /v "*DeviceSleepOnDisconnect" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*DeviceSleepOnDisconnect" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*NicAutoPowerSaver" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*NicAutoPowerSaver" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*EnableDynamicPowerGating" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*EnableDynamicPowerGating" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "DynamicPowerGating" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "DynamicPowerGating" /f >nul 2>&1

    for /f %%i in ('reg query "%%a" /v "PnPCapabilities" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "PnPCapabilities" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "LogLinkStateEvent" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "LogLinkStateEvent" /f >nul 2>&1
)

echo.
echo ================================================================================
echo                ГОТОВО! ЭНЕРГОСБЕРЕЖЕНИЕ СЕТИ ВКЛЮЧЕНО
echo ================================================================================

echo.