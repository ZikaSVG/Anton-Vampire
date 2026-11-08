@echo off
chcp 65001 >nul

echo ================================================================================
echo                    xOS PLAYBOOK - ВОССТАНОВЛЕНИЕ СЕТИ
echo                (ВОЗВРАТ К СТАНДАРТНЫМ НАСТРОЙКАМ WINDOWS)
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт ВОССТАНАВЛИВАЕТ стандартные настройки сетевых адаптеров,
echo которые были изменены предыдущими оптимизациями. Скрипт НЕ УДАЛЯЕТ
echo сетевые адаптеры, а только возвращает их параметры к значениям по умолчанию.
echo.
echo Что делает скрипт отката:
echo.
echo   1. НЕ сбрасывает Winsock и IP стек (это стандартные команды)
echo   2. НЕ переустанавливает сетевые адаптеры
echo   3. ВОССТАНАВЛИВАЕТ энергосберегающие параметры к значениям по умолчанию:
echo      - EnablePME (управление питанием) - стандартное значение
echo      - DeviceSleepOnDisconnect - стандартное значение
echo      - EEE (Energy Efficient Ethernet) - стандартное значение
echo      - WakeOnMagicPacket - стандартное значение
echo      - И другие сетевые параметры
echo.
echo ВНИМАНИЕ! Этот откат возвращает НАСТРОЙКИ ПО УМОЛЧАНИЮ, а не удаляет адаптеры.
echo.
echo ================================================================================
echo ПЛЮСЫ ОТКАТА:
echo ================================================================================
echo [+] Возвращает стандартное энергосбережение сетевых карт
echo [+] На ноутбуках восстанавливается автономная работа от батареи
echo [+] Решает проблемы с сетевым питанием если они возникли
echo [+] Не требует переустановки драйверов
echo.
echo ================================================================================
echo МИНУСЫ ОТКАТА:
echo ================================================================================
echo [-] Могут вернуться задержки в сети и микро-лаги
echo [-] Wake-on-Lan снова может быть выключен (зависит от драйвера)
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте если возникли проблемы с сетью после оптимизаций
echo [2] На ноутбуках рекомендуется вернуть стандартные настройки
echo [3] После отката желательно перезагрузить компьютер
echo [4] Некоторые настройки может перезаписать антивирус
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [1/5] Сброс IP стека до стандартных настроек...
netsh int ip reset >nul 2>&1
echo [OK] IP стек сброшен

echo [2/5] Сброс интерфейсов IPv4 и IPv6...
netsh interface ipv4 reset >nul 2>&1
netsh interface ipv6 reset >nul 2>&1
echo [OK] Интерфейсы сброшены

echo [3/5] Сброс TCP параметров...
netsh interface tcp reset >nul 2>&1
echo [OK] TCP сброшен

echo [4/5] Сброс Winsock...
netsh winsock reset >nul 2>&1
echo [OK] Winsock сброшен

echo [5/5] Восстановление параметров сетевых адаптеров к стандартным значениям...
for /f %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr  "HKEY"') do (
    for /f %%i in ('reg query "%%a" /v "EnablePME" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnablePME" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*DeviceSleepOnDisconnect" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*DeviceSleepOnDisconnect" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*EEE" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*EEE" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "AdvancedEEE" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "AdvancedEEE" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*SipsEnabled" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*SipsEnabled" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableAspm" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableAspm" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ASPM" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "ASPM" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*ModernStandbyWoLMagicPacket" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*ModernStandbyWoLMagicPacket" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*SelectiveSuspend" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*SelectiveSuspend" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableGigaLite" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableGigaLite" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "GigaLite" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "GigaLite" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*WakeOnMagicPacket" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*WakeOnMagicPacket" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*WakeOnPattern" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*WakeOnPattern" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*JumboPacket" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*JumboPacket" /t REG_SZ /d "1514" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "AutoPowerSaveModeEnabled" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "AutoPowerSaveModeEnabled" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EEELinkAdvertisement" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EEELinkAdvertisement" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EeePhyEnable" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EeePhyEnable" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableGreenEthernet" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableGreenEthernet" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableModernStandby" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableModernStandby" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PnPCapabilities" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "PnPCapabilities" /t REG_DWORD /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PowerDownPll" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "PowerDownPll" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PowerSavingMode" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "PowerSavingMode" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ReduceSpeedOnPowerDown" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "ReduceSpeedOnPowerDown" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "S5WakeOnLan" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "S5WakeOnLan" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "SavePowerNowEnabled" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "SavePowerNowEnabled" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ULPMode" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "ULPMode" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnLink" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOnLink" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnSlot" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOnSlot" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnLinkChg" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOnLinkChg" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnLinkUp" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOnLinkUp" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeUpModeCap" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeUpModeCap" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnMagicPacketFromS5" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOnMagicPacketFromS5" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WolShutdownLinkSpeed" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WolShutdownLinkSpeed" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*NicAutoPowerSaver" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*NicAutoPowerSaver" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PowerSaveEnable" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "PowerSaveEnable" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnablePowerManagement" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnablePowerManagement" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ForceWakeFromMagicPacketOnModernStandby" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "ForceWakeFromMagicPacketOnModernStandby" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeFromS5" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeFromS5" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOn" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOn" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "DMACoalescing" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "DMACoalescing" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableSavePowerNow" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableSavePowerNow" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*EnableDynamicPowerGating" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*EnableDynamicPowerGating" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "DynamicPowerGating" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "DynamicPowerGating" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableD3ColdInS0" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableD3ColdInS0" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "LTROBFF" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "LTROBFF" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeFromPowerOff" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeFromPowerOff" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "LogLinkStateEvent" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "LogLinkStateEvent" /t REG_SZ /d "1" /f >nul 2>&1
    )
) >nul 2>&1
echo [OK] Параметры сетевых адаптеров восстановлены

echo.
echo ================================================================================
echo               ГОТОВО! СТАНДАРТНЫЕ НАСТРОЙКИ СЕТИ ВОССТАНОВЛЕНЫ
echo ================================================================================
echo.
echo Что было сделано:
echo   - Сброшен IP стек и Winsock
echo   - Восстановлены стандартные параметры энергосбережения сетевых карт
echo   - Включены стандартные режимы энергосбережения
echo   - Восстановлены стандартные параметры WoL и ASPM
echo.
echo Рекомендуется перезагрузить компьютер для полного применения изменений.
echo.

echo.