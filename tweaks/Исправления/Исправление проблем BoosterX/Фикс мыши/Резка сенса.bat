:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: Эти строки представляют некорректные данные или конфигурации, которые могут быть восстановлены в реестре в формате HEX.
:: Они могут использоваться для настройки кривых мыши, но они комментарии и не выполняются.
:: Это просто информация о настройках мыши.
:: HKEY_CURRENT_USER\Control Panel\Mouse --> SmoothMouseXCurve"=hex:\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,00,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> C0,CC,0C,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 80,99,19,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 40,66,26,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,33,33,00,00,00,00,00
:: HKEY_CURRENT_USER\Control Panel\Mouse --> SmoothMouseYCurve"=hex:\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,00,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,38,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,70,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,A8,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,E0,00,00,00,00,00
:: ------------------------------------------------------------------------------------------------------------------------------------------------
REM ; Windows_10+8.x_MouseFix_ItemsSize=100%_Scale=1-to-1_@6-of-11
REM Добавляет или изменяет значение "MouseSensitivity" в реестре для текущего пользователя.
REM Устанавливает чувствительность мыши на "10".
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f
REM Для пользователя по умолчанию добавляет следующие настройки мыши, устанавливая их значения на "0":
REM 1. MouseSpeed: скорость мыши.
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
REM 2. MouseThreshold1: первая пороговая скорость мыши (чувствительность).
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
REM 3. MouseThreshold2: вторая пороговая скорость мыши (чувствительность).
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f
REM Устанавливает значение "Win32PrioritySeparation" в реестре системы, что отвечает за приоритет обработки.
REM Значение "22" означает "высокий приоритет".
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "22" /f
TITLE Made by Melody, coded by Artanis, adopted by Cat :)
REM Устанавливает заголовок окна командной строки, указывая информацию о разработчиках.
REM Отключает режим простоя для USB-устройств.
FOR /F %%a in ('WMIC PATH Win32_USBHub GET DeviceID^| FINDSTR /L "VID_"') DO (
    REM Добавляет в реестр параметры, отключающие управление энергией для каждого USB-устройства.
    REG ADD "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters" /F /V "EnhancedPowerManagementEnabled" /T REG_DWORD /d 0 >NUL 2>&1
    REG ADD "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters" /F /V "AllowIdleIrpInD3" /T REG_DWORD /d 0 >NUL 2>&1
    REG ADD "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters" /F /V "SelectiveSuspendOn" /T REG_DWORD /d 0 >NUL 2>&1
    REG ADD "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters" /F /V "DeviceSelectiveSuspended" /T REG_DWORD /d 0 >NUL 2>&1
    REG ADD "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters" /F /V "SelectiveSuspendEnabled" /T REG_DWORD /d 0 >NUL 2>&1
    REM Выводит сообщение о том, что режим простоя USB для устройства отключен.
    ECHO Disabling USB idling for %%a
)