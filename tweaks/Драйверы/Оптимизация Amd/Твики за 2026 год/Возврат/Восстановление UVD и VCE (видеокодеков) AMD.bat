@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ВОССТАНОВЛЕНИЕ UVD И VCE AMD
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Восстанавливает стандартные настройки UVD, VCE и видеокодеков AMD.
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ОШИБКА] Запустите от имени Администратора!
    echo.
    exit /b 1
)

set "base=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
set "target="

for /f "tokens=*" %%A in ('reg query "%base%" /k /f "*" ^| findstr /r "\\....$"') do (
    reg query "%%A" /v "ProviderName" 2>nul | find /i "Advanced Micro Devices, Inc." >nul
    if !errorlevel! equ 0 (
        set "target=%%A"
        goto :found
    )
)

echo [ОШИБКА] Видеокарта AMD не найдена!
exit /b 1

:found

reg delete "%target%" /v "DisableUVDPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableVCEPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableAcpPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableDrmdmaPowerGating" /f >nul 2>&1

reg delete "%target%" /v "DisableHdpClockPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableGmcPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableSDMAPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableSAMUPowerGating" /f >nul 2>&1

reg delete "%target%" /v "SMU_DisableMmhubPowerGating" /f >nul 2>&1
reg delete "%target%" /v "SMU_DisableAthubPowerGating" /f >nul 2>&1

reg delete "%target%" /v "EnableVceSwClockGating" /f >nul 2>&1
reg delete "%target%" /v "EnableUvdClockGating" /f >nul 2>&1

echo.
echo ================================================================================
echo                    ГОТОВО! ТВИК 5 AMD ВОССТАНОВЛЕН
echo ================================================================================
echo.

echo.