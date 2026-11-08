@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ТВИК 5
echo            БЛОКИРОВКА UVD И VCE (ВИДЕОКОДЕКОВ) AMD
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo UVD (Unified Video Decoder) и VCE (Video Coding Engine) - это блоки
echo видеокодеков в видеокартах AMD Radeon для аппаратного кодирования
echo и декодирования видео.
echo.
echo Отключение этих блоков позволяет снизить задержки (latency) в играх,
echo особенно в киберспортивных дисциплинах.
echo.
echo Отключаемые параметры:
echo.
echo   1. POWER GATING (блокировка питания блоков):
echo      - DisableUVDPowerGating = 1 (отключение питания UVD)
echo      - DisableVCEPowerGating = 1 (отключение питания VCE)
echo      - DisableAcpPowerGating = 1 (отключение питания ACP)
echo      - DisableDrmdmaPowerGating = 1 (отключение питания DRM DMA)
echo.
echo   2. POWER GATING ДЛЯ ДРУГИХ БЛОКОВ:
echo      - DisableHdpClockPowerGating = 1 (HDP)
echo      - DisableGmcPowerGating = 1 (GMC)
echo      - DisableSDMAPowerGating = 1 (SDMA)
echo      - DisableSAMUPowerGating = 1 (SAMU)
echo      - SMU_DisableMmhubPowerGating = 1 (MM Hub)
echo      - SMU_DisableAthubPowerGating = 1 (AT Hub)
echo.
echo   3. CLOCK GATING ДЛЯ МЕДИА-БЛОКОВ:
echo      - EnableVceSwClockGating = 0 (отключение тактирования VCE)
echo      - EnableUvdClockGating = 0 (отключение тактирования UVD)
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] СНИЖАЕТ ЗАДЕРЖКИ (LATENCY) В ИГРАХ
echo [+] УЛУЧШАЕТ ПЛАВНОСТЬ В КИБЕРСПОРТИВНЫХ ИГРАХ
echo [+] УБИРАЕТ МИКРО-ЛАГИ
echo [+] ОСВОБОЖДАЕТ РЕСУРСЫ ДЛЯ ИГР
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] АППАРАТНОЕ КОДИРОВАНИЕ ВИДЕО НЕ РАБОТАЕТ
echo [-] OBS может работать хуже (кодирование через CPU)
echo [-] Нельзя использовать AMD VCE в программах захвата
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] ОСОБЕННО РЕКОМЕНДУЕТСЯ ДЛЯ КИБЕРСПОРТА
echo [2] Отключайте если не используете запись видео через VCE
echo [3] Для возврата используйте скрипт "Восстановление твика 5 AMD.bat"
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

echo [2/2] Блокировка UVD, VCE и других блоков видеокодеков...

reg add "%target%" /v "DisableUVDPowerGating" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DisableVCEPowerGating" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DisableAcpPowerGating" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d 1 /f >nul

reg add "%target%" /v "DisableHdpClockPowerGating" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DisableGmcPowerGating" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DisableSDMAPowerGating" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "DisableSAMUPowerGating" /t REG_DWORD /d 1 /f >nul

reg add "%target%" /v "SMU_DisableMmhubPowerGating" /t REG_DWORD /d 1 /f >nul
reg add "%target%" /v "SMU_DisableAthubPowerGating" /t REG_DWORD /d 1 /f >nul

reg add "%target%" /v "EnableVceSwClockGating" /t REG_DWORD /d 0 /f >nul
reg add "%target%" /v "EnableUvdClockGating" /t REG_DWORD /d 0 /f >nul

echo [OK] UVD, VCE и другие блоки видеокодеков заблокированы
echo.

echo ================================================================================
echo                    ГОТОВО! ТВИК 5 ВЫПОЛНЕН
echo ================================================================================
echo.
echo Что сделано:
echo   - Заблокировано питание UVD (видеодекодер)
echo   - Заблокировано питание VCE (видеокодер)
echo   - Заблокировано питание других блоков (ACP, DRM DMA, HDP, GMC, SDMA, SAMU)
echo   - Отключено тактирование UVD и VCE
echo.
echo Результат:
echo   - Снижены задержки в играх
echo   - ОСВОБОЖДЕНЫ РЕСУРСЫ ДЛЯ ИГР
echo   - Аппаратное кодирование видео НЕ РАБОТАЕТ
echo.
echo Для возврата используйте скрипт "Восстановление твика 5 AMD.bat"
echo.

echo.