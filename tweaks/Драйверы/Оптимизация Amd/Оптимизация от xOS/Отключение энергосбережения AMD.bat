@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ТВИК 2-4
echo   ПОЛНОЕ ОТКЛЮЧЕНИЕ ЭНЕРГОСБЕРЕЖЕНИЯ, ЗАТВОРКИ ТАКТОВ,
echo             PCIe DPM И DEEPSLEEP AMD
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный твик ОБЪЕДИНЯЕТ ТРИ ОПТИМИЗАЦИИ для видеокарт AMD Radeon.
echo.
echo ЧАСТЬ 1 - ОТКЛЮЧЕНИЕ ЭНЕРГОСБЕРЕЖЕНИЯ:
echo.
echo   1. ULPS (Ultra Low Power State):
echo      - EnableUlps = 0 (отключение ультра-низкого энергосбережения)
echo      - PP_DisableULPS = 1 (принудительное отключение ULPS)
echo      - KMD_EnableULPS = 0
echo.
echo   2. ASPM (Active State Power Management):
echo      - EnableAspmL0s = 0 (отключение ASPM L0s)
echo      - EnableAspmL1 = 0 (отключение ASPM L1)
echo      - DisableAspmL0s = 1, DisableAspmL1 = 1
echo.
echo   3. D3COLD:
echo      - KMD_ForceD3ColdSupport = 0 (отключение холодного состояния)
echo.
echo ЧАСТЬ 2 - ОТКЛЮЧЕНИЕ ЗАТВОРКИ ТАКТОВ (CLOCK GATING):
echo.
echo   1. ОСНОВНЫЕ НАСТРОЙКИ:
echo      - DisableAllClockGating = 1
echo      - DisableGfxClockGating = 1
echo      - DisableSysClockGating = 1
echo.
echo   2. ТОЧНАЯ НАСТРОЙКА:
echo      - DisableGfxCoarseGrainClockGating = 1
echo      - DisableGfxMediumGrainClockGating = 1
echo      - DisableGfxFineGrainClockGating = 1
echo      - DisableGfxMGCG = 1
echo.
echo   3. НАСТРОЙКИ SMU И МЕДИА-БЛОКОВ:
echo      - EnableGfxClockGatingThruSmu = 0
echo      - EnableSysClockGatingThruSmu = 0
echo.
echo ЧАСТЬ 3 - ОТКЛЮЧЕНИЕ PCIe DPM И DEEPSLEEP:
echo.
echo   1. PCIe DPM:
echo      - PP_PcieDpmDisabled = 1
echo      - PP_SclkDpmDisabled = 1
echo      - PP_MclkDpmDisabled = 1
echo      - PP_SocclkDpmDisabled = 1
echo.
echo   2. DEEPSLEEP:
echo      - DalDisableDeepSleep = 1
echo      - DalDisableDiv2 = 1
echo      - DalForceMaxDisplayClock = 1
echo.
echo   3. ПРИНУДИТЕЛЬНЫЙ 3D РЕЖИМ:
echo      - PP_Force3DPerformanceMode = 1
echo      - PP_ForceHighDPMLevel = 1
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] МАКСИМАЛЬНАЯ ПРОИЗВОДИТЕЛЬНОСТЬ GPU
echo [+] PCIe шина всегда на максимальной скорости
echo [+] УБИРАЕТ ВСЕ ЗАДЕРЖКИ ПРИ ПРОБУЖДЕНИИ
echo [+] УБИРАЕТ МИКРО-ФРИЗЫ И ПОДЛАГИВАНИЯ
echo [+] ВИДЕОКАРТА И ДИСПЛЕЙ ВСЕГДА ГОТОВЫ К РАБОТЕ
echo [+] НЕТ ЗАДЕРЖЕК ПРИ ВЫХОДЕ ИЗ РЕЖИМА СНА
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] УВЕЛИЧИВАЕТСЯ ЭНЕРГОПОТРЕБЛЕНИЕ В ПРОСТОЕ
echo [-] ПОВЫШАЕТСЯ ТЕМПЕРАТУРА ВИДЕОКАРТЫ
echo [-] ВИДЕОКАРТА НИКОГДА НЕ СНИЖАЕТ ЧАСТОТЫ
echo [-] НЕ РЕКОМЕНДУЕТСЯ ДЛЯ НОУТБУКОВ
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] ТОЛЬКО ДЛЯ ДЕСКТОПОВ С ХОРОШИМ ОХЛАЖДЕНИЕМ
echo [2] ТРЕБУЕТСЯ ХОРОШЕЕ ОХЛАЖДЕНИЕ
echo [3] НЕ РЕКОМЕНДУЕТСЯ ДЛЯ НОУТБУКОВ (перегрев)
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

echo [1/4] Поиск видеокарты AMD Radeon...
for /f "tokens=*" %%A in ('reg query "%base%" /k /f "*" ^| findstr /r "\\....$"') do (
    reg query "%%A" /v "ProviderName" 2>nul | find /i "Advanced Micro Devices, Inc." >nul
    if !errorlevel! equ 0 (
        set "target=%%A"
        echo [OK] Найдена AMD Radeon: %%A
        goto :found
    )
)

echo [ОШИБКА] Видеокарта AMD не найдена!
echo Убедитесь, что у вас установлена видеокарта AMD Radeon.
exit /b 1

:found
echo.

echo [ЧАСТЬ 1] ОТКЛЮЧЕНИЕ ЭНЕРГОСБЕРЕЖЕНИЯ AMD (ULPS, ASPM, D3COLD)...
echo.

reg add "%target%" /v "EnableUlps" /t REG_DWORD /d 0 /f >nul
reg add "%target%" /v "EnableUlps_NA" /t REG_SZ /d "0" /f >nul
reg add "%target%" /v "PP_DisableULPS" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "KMD_EnableULPS" /t REG_DWORD /d 0 /f >nul
reg add "%target%" /v "KMD_ForceD3ColdSupport" /t REG_DWORD /d 0 /f >nul

reg add "%target%" /v "EnableAspmL0s" /t REG_DWORD /d 0 /f >nul
reg add "%target%" /v "EnableAspmL1" /t REG_DWORD /d 0 /f >nul
reg add "%target%" /v "EnableAspmL1SS" /t REG_DWORD /d 0 /f >nul
reg add "%target%" /v "DisableAspmL0s" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DisableAspmL1" /t REG_DWORD /d 1 /f >nul
echo [OK] Энергосбережение AMD отключено
echo.

echo [ЧАСТЬ 2] ОТКЛЮЧЕНИЕ ЗАТВОРКИ ТАКТОВ (CLOCK GATING)...
echo.

reg add "%target%" /v "DisableGfxClockGating" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DisableAllClockGating" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DisableSysClockGating" /t REG_DWORD /d 1 /f >nul

reg add "%target%" /v "DisableGfxCoarseGrainClockGating" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DisableGfxMediumGrainClockGating" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DisableGfxFineGrainClockGating" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DisableGfxMGCG" /t REG_DWORD /d 1 /f >nul

reg add "%target%" /v "EnableGfxClockGatingThruSmu" /t REG_DWORD /d 0 /f >nul
reg add "%target%" /v "EnableSysClockGatingThruSmu" /t REG_DWORD /d 0 /f >nul

reg add "%target%" /v "EnableVceSwClockGating" /t REG_DWORD /d 0 /f >nul
reg add "%target%" /v "EnableUvdClockGating" /t REG_DWORD /d 0 /f >nul
echo [OK] Clock Gating отключен
echo.

echo [ЧАСТЬ 3] ОТКЛЮЧЕНИЕ PCIe DPM И DEEPSLEEP...
echo.

reg add "%target%" /v "PP_PcieDpmDisabled" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "PP_SclkDpmDisabled" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "PP_MclkDpmDisabled" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "PP_SocclkDpmDisabled" /t REG_DWORD /d 1 /f >nul

reg add "%target%" /v "DalDisableDeepSleep" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DalDisableDiv2" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DalForceMaxDisplayClock" /t REG_DWORD /d 1 /f >nul

reg add "%target%" /v "PP_Force3DPerformanceMode" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "PP_ForceHighDPMLevel" /t REG_DWORD /d 1 /f >nul
echo [OK] PCIe DPM и DeepSleep отключены, 3D режим принудительно включен
echo.

echo ================================================================================
echo                    ГОТОВО! ТВИК 2+3+4 ВЫПОЛНЕН
echo ================================================================================
echo.
echo Что сделано (энергосбережение):
echo   - Отключен ULPS (ультра-низкое энергосбережение)
echo   - Отключен ASPM (управление питанием PCIe)
echo   - Отключен D3Cold (холодное состояние)
echo.
echo Что сделано (clock gating):
echo   - Отключена общая затворка тактов (All Clock Gating)
echo   - Отключена затворка тактов графики (Gfx Clock Gating)
echo   - Отключена затворка тактов для VCE и UVD
echo.
echo Что сделано (PCIe DPM и DeepSleep):
echo   - Отключено динамическое управление питанием PCIe
echo   - Отключен DeepSleep дисплея
echo   - Включен принудительный 3D режим производительности
echo.
echo Результат:
echo   - Видеокарта всегда на максимальной готовности
echo   - Нет задержек и микро-фризов
echo   - Повышено энергопотребление и температура
echo.

echo.