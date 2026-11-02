@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ВОССТАНОВЛЕНИЕ ТЕЛЕМЕТРИИ AMD
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт ВОССТАНАВЛИВАЕТ стандартные настройки телеметрии,
echo уведомлений, статистики и служб AMD Radeon.
echo.
echo Это полный откат для скрипта "Твик 1 - Отключение телеметрии,
echo уведомлений и служб AMD.bat".
echo.
echo Восстанавливаемые параметры:
echo   - ReportAnalytics (телеметрия)
echo   - AllowSubscription (подписки)
echo   - NotifySubscription (уведомления)
echo   - ShowReleaseNotes (новости драйверов)
echo   - ECMMode (ECC память)
echo   - Службы AMD Crash Defender и логирования
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] Возвращает стандартные настройки AMD
echo [+] AMD получает телеметрию для улучшения драйверов
echo [+] Возвращаются уведомления о новых драйверах
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Возобновляется отправка телеметрии в AMD
echo [-] Возвращаются уведомления AMD
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте от имени Администратора
echo [2] Запускайте если хотите вернуть стандартные настройки AMD
echo [3] Запускайте если хотите получать новости о драйверах
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

echo [2/3] Восстановление телеметрии, уведомлений и статистики...
reg delete "%target%" /v "ReportAnalytics" /f >nul 2>&1
reg delete "%target%" /v "NotifySubscription" /f >nul 2>&1
reg delete "%target%" /v "AllowSubscription" /f >nul 2>&1
reg delete "%target%" /v "ShowReleaseNotes" /f >nul 2>&1
reg delete "%target%" /v "ECCMode" /f >nul 2>&1
echo [OK] Телеметрия, уведомления и статистика восстановлены
echo.

echo [3/3] Восстановление служб AMD...
set "Root=HKLM\System\CurrentControlSet\Services"

for %%S in ("AMD Crash Defender Service" "amdfendr" "amdfendrmgr" "amdlog") do (
    reg query "%Root%\%%~S" >nul 2>&1
    if !errorlevel! equ 0 (
        reg add "%Root%\%%~S" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
        echo   Восстановлена служба: %%~S
    )
)
echo [OK] Службы AMD восстановлены
echo.

echo ================================================================================
echo                    ГОТОВО! ТВИК 1 AMD ВОССТАНОВЛЕН
echo ================================================================================
echo.
echo Что восстановлено:
echo   - Телеметрия AMD (ReportAnalytics)
echo   - Уведомления AMD (NotifySubscription, ShowReleaseNotes)
echo   - Подписки AMD (AllowSubscription)
echo   - Статистика ECC (ECCMode)
echo   - Службы AMD Crash Defender и логирования
echo.
echo Видеокарта AMD возвращена к стандартным настройкам.
echo.

echo.