@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ЭНЕРГОСБЕРЕЖЕНИЯ AMD
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт ВОССТАНАВЛИВАЕТ стандартные настройки энергосбережения,
echo затворки тактов, PCIe DPM и DeepSleep для видеокарт AMD Radeon.
echo.
echo Это полный откат для скрипта "Твик 2-4 - Полное отключение
echo энергосбережения, затворки тактов, PCIe DPM и DeepSleep AMD.bat".
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

echo [1/2] Поиск видеокарты AMD Radeon...
for /f "tokens=*" %%A in ('reg query "%base%" /k /f "*" ^| findstr /r "\\....$"') do (
    reg query "%%A" /v "ProviderName" 2>nul | find /i "Advanced Micro Devices, Inc." >nul
    if !errorlevel! equ 0 (
        set "target=%%A"
        echo [OK] Найдена AMD Radeon: %%A
        goto :found
    )
)

echo [ОШИБКА] Видеокарта AMD не найдена!
exit /b 1

:found
echo.

echo [ЧАСТЬ 1] ВОССТАНОВЛЕНИЕ ЭНЕРГОСБЕРЕЖЕНИЯ AMD...
echo.

reg delete "%target%" /v "EnableUlps" /f >nul 2>&1
reg delete "%target%" /v "EnableUlps_NA" /f >nul 2>&1
reg delete "%target%" /v "PP_DisableULPS" /f >nul 2>&1
reg delete "%target%" /v "KMD_EnableULPS" /f >nul 2>&1
reg delete "%target%" /v "KMD_ForceD3ColdSupport" /f >nul 2>&1

reg delete "%target%" /v "EnableAspmL0s" /f >nul 2>&1
reg delete "%target%" /v "EnableAspmL1" /f >nul 2>&1
reg delete "%target%" /v "EnableAspmL1SS" /f >nul 2>&1
reg delete "%target%" /v "DisableAspmL0s" /f >nul 2>&1
reg delete "%target%" /v "DisableAspmL1" /f >nul 2>&1
echo [OK] Энергосбережение AMD восстановлено
echo.

echo [ЧАСТЬ 2] ВОССТАНОВЛЕНИЕ ЗАТВОРКИ ТАКТОВ (CLOCK GATING)...
echo.

reg delete "%target%" /v "DisableGfxClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableAllClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableSysClockGating" /f >nul 2>&1

reg delete "%target%" /v "DisableGfxCoarseGrainClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableGfxMediumGrainClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableGfxFineGrainClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableGfxMGCG" /f >nul 2>&1

reg delete "%target%" /v "EnableGfxClockGatingThruSmu" /f >nul 2>&1
reg delete "%target%" /v "EnableSysClockGatingThruSmu" /f >nul 2>&1

reg delete "%target%" /v "EnableVceSwClockGating" /f >nul 2>&1
reg delete "%target%" /v "EnableUvdClockGating" /f >nul 2>&1
echo [OK] Clock Gating восстановлен
echo.

echo [ЧАСТЬ 3] ВОССТАНОВЛЕНИЕ PCIe DPM И DEEPSLEEP...
echo.

reg delete "%target%" /v "PP_PcieDpmDisabled" /f >nul 2>&1
reg delete "%target%" /v "PP_SclkDpmDisabled" /f >nul 2>&1
reg delete "%target%" /v "PP_MclkDpmDisabled" /f >nul 2>&1
reg delete "%target%" /v "PP_SocclkDpmDisabled" /f >nul 2>&1

reg delete "%target%" /v "DalDisableDeepSleep" /f >nul 2>&1
reg delete "%target%" /v "DalDisableDiv2" /f >nul 2>&1
reg delete "%target%" /v "DalForceMaxDisplayClock" /f >nul 2>&1

reg delete "%target%" /v "PP_Force3DPerformanceMode" /f >nul 2>&1
reg delete "%target%" /v "PP_ForceHighDPMLevel" /f >nul 2>&1
echo [OK] PCIe DPM и DeepSleep восстановлены
echo.

echo ================================================================================
echo                    ГОТОВО! ТВИК 2+3+4 AMD ВОССТАНОВЛЕН
echo ================================================================================
echo.
echo Что восстановлено:
echo   - ULPS (ультра-низкое энергосбережение)
echo   - ASPM (управление питанием PCIe)
echo   - D3Cold (холодное состояние)
echo   - Clock Gating (затворка тактов)
echo   - PCIe DPM (динамическое управление питанием)
echo   - DeepSleep дисплея
echo.
echo Видеокарта AMD возвращена к стандартным настройкам.
echo.

echo.