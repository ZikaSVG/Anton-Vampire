@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ОТКЛЮЧЕНИЕ ЭНЕРГОСБЕРЕЖЕНИЯ СЕТИ
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Отключает все энергосберегающие режимы на сетевых адаптерах:
echo   - Управление питанием (EnablePME, EnablePowerManagement)
echo   - Энергосбережение (PowerSavingMode, SavePowerNowEnabled)
echo   - Энергоэффективный Ethernet (EEE, GreenEthernet, GigaLite)
echo   - Выборочное отключение (SelectiveSuspend, ASPM, SipsEnabled)
echo   - Современный режим ожидания (ModernStandby, D3Cold)
echo   - Автоматическое управление (AutoPowerSaver, DynamicPowerGating)
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] СЕТЕВЫЕ АДАПТЕРЫ НИКОГДА НЕ ЗАСЫПАЮТ
echo [+] УБИРАЕТ ЗАДЕРЖКИ ПРИ ПРОБУЖДЕНИИ СЕТИ
echo [+] СТАБИЛЬНЕЕ РАБОТАЕТ ИНТЕРНЕТ
echo [+] УСТРАНЯЕТ ОБРЫВЫ VPN И ПОДКЛЮЧЕНИЙ
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Увеличивается энергопотребление сетевой карты
echo [-] На ноутбуках быстрее садится батарея
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Десктопы - ОДНОЗНАЧНО РЕКОМЕНДУЕТСЯ
echo [2] Ноутбуки - только при игре или работе от сети
echo [3] При проблемах с Wi-Fi - помогает часто
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

for /f %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr "HKEY"') do (

    for /f %%i in ('reg query "%%a" /v "EnablePME" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "EnablePME" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EnablePowerManagement" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "EnablePowerManagement" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "PowerSavingMode" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "PowerSavingMode" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "SavePowerNowEnabled" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "SavePowerNowEnabled" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "AutoPowerSaveModeEnabled" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "AutoPowerSaveModeEnabled" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "ReduceSpeedOnPowerDown" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "ReduceSpeedOnPowerDown" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "PowerDownPll" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "PowerDownPll" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "PowerSaveEnable" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "PowerSaveEnable" /t REG_SZ /d "0" /f >nul 2>&1

    for /f %%i in ('reg query "%%a" /v "*EEE" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*EEE" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "AdvancedEEE" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "AdvancedEEE" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EEELinkAdvertisement" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "EEELinkAdvertisement" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EeePhyEnable" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "EeePhyEnable" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EnableGreenEthernet" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "EnableGreenEthernet" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EnableGigaLite" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "EnableGigaLite" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "GigaLite" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "GigaLite" /t REG_SZ /d "0" /f >nul 2>&1

    for /f %%i in ('reg query "%%a" /v "*SelectiveSuspend" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*SelectiveSuspend" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EnableAspm" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "EnableAspm" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "ASPM" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "ASPM" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*SipsEnabled" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*SipsEnabled" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "ULPMode" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "ULPMode" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "DMACoalescing" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "DMACoalescing" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EnableModernStandby" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "EnableModernStandby" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "EnableD3ColdInS0" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "EnableD3ColdInS0" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "LTROBFF" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "LTROBFF" /t REG_SZ /d "0" /f >nul 2>&1

    for /f %%i in ('reg query "%%a" /v "*DeviceSleepOnDisconnect" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*DeviceSleepOnDisconnect" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*NicAutoPowerSaver" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*NicAutoPowerSaver" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*EnableDynamicPowerGating" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*EnableDynamicPowerGating" /t REG_SZ /d "0" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "DynamicPowerGating" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "DynamicPowerGating" /t REG_SZ /d "0" /f >nul 2>&1

    for /f %%i in ('reg query "%%a" /v "PnPCapabilities" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "PnPCapabilities" /t REG_DWORD /d "24" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "LogLinkStateEvent" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "LogLinkStateEvent" /t REG_SZ /d "0" /f >nul 2>&1
)

echo.
echo ================================================================================
echo                ГОТОВО! ЭНЕРГОСБЕРЕЖЕНИЕ СЕТИ ОТКЛЮЧЕНО
echo ================================================================================

echo.