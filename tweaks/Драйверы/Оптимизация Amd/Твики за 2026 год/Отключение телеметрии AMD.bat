@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ТВИК 1
echo        ОТКЛЮЧЕНИЕ ТЕЛЕМЕТРИИ, УВЕДОМЛЕНИЙ И СЛУЖБ AMD
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный твик отключает следующие функции AMD Radeon:
echo.
echo   1. ТЕЛЕМЕТРИЯ:
echo      - ReportAnalytics (отправка аналитических данных в AMD)
echo      - AllowSubscription (разрешение на подписки)
echo.
echo   2. УВЕДОМЛЕНИЯ:
echo      - NotifySubscription (уведомления о подписках)
echo      - ShowReleaseNotes (показ новостей драйверов)
echo.
echo   3. СТАТИСТИКА:
echo      - ECMMode (режим ECC памяти)
echo.
echo   4. СЛУЖБЫ AMD:
echo      - AMD Crash Defender Service
echo      - amdfendr (AMD Crash Defender)
echo      - amdfendrmgr (AMD Crash Defender Manager)
echo      - amdlog (AMD Logging)
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ОТКЛЮЧАЕТ ОТПРАВКУ ТЕЛЕМЕТРИИ В AMD
echo [+] УБИРАЕТ НАДОЕДАЮЩИЕ УВЕДОМЛЕНИЯ AMD
echo [+] СНИЖАЕТ ФОНОВУЮ НАГРУЗКУ НА СИСТЕМУ
echo [+] ОСВОБОЖДАЕТ ОПЕРАТИВНУЮ ПАМЯТЬ
echo [+] ПОВЫШАЕТ КОНФИДЕНЦИАЛЬНОСТЬ
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] AMD не получает данные для улучшения драйверов
echo [-] Не будут приходить новости о новых драйверах
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте от имени Администратора
echo [2] ТОЛЬКО ДЛЯ ВИДЕОКАРТ AMD
echo [3] Для возврата используйте скрипт отката
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

echo [1/3] Поиск видеокарты AMD Radeon...
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

echo [2/3] Отключение телеметрии, уведомлений и статистики...
reg add "%target%" /v "ReportAnalytics" /t REG_DWORD /d 0 /f >nul
reg add "%target%" /v "NotifySubscription" /t REG_DWORD /d 0 /f >nul
reg add "%target%" /v "AllowSubscription" /t REG_DWORD /d 0 /f >nul
reg add "%target%" /v "ShowReleaseNotes" /t REG_DWORD /d 0 /f >nul
reg add "%target%" /v "ECCMode" /t REG_DWORD /d 0 /f >nul
echo [OK] Телеметрия, уведомления и статистика отключены
echo.

echo [3/3] Отключение ненужных служб AMD...
set "Root=HKLM\System\CurrentControlSet\Services"

for %%S in ("AMD Crash Defender Service" "amdfendr" "amdfendrmgr" "amdlog") do (
    reg query "%Root%\%%~S" >nul 2>&1
    if !errorlevel! equ 0 (
        reg add "%Root%\%%~S" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
        echo   Отключена служба: %%~S
    )
)
echo [OK] Службы AMD отключены
echo.

echo ================================================================================
echo                    ГОТОВО! ТВИК 1 ВЫПОЛНЕН
echo ================================================================================
echo.
echo Что сделано:
echo   - Отключена телеметрия AMD
echo   - Отключены уведомления AMD
echo   - Отключена статистика ECC
echo   - Отключены службы AMD Crash Defender и логирования
echo.

echo.