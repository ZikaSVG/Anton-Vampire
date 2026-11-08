@echo off
chcp 65001 >nul

echo ================================================================================
echo                 SYNERGYOS - ОТКЛЮЧЕНИЕ ОБНОВЛЕНИЙ WINDOWS
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный твик ПОЛНОСТЬЮ ОТКЛЮЧАЕТ автоматические обновления Windows и
echo оптимизацию доставки обновлений (Delivery Optimization).
echo.
echo Что делает скрипт:
echo.
echo   1. ОТКЛЮЧАЕТ DELIVERY OPTIMIZATION:
echo      - DODownloadMode = 0 (отключение P2P раздачи обновлений)
echo      - Экономит интернет-трафик (не раздает обновления другим ПК)
echo      - Отключает фоновую загрузку
echo.
echo   2. ПРИОСТАНАВЛИВАЕТ ОБНОВЛЕНИЯ НА 15 ЛЕТ (до 2038 года):
echo      - FlightSettingsMaxPauseDays = 5269 дней (максимальная пауза)
echo      - PauseFeatureUpdatesEndTime = 2038-01-19 (дата окончания)
echo      - PauseQualityUpdatesEndTime = 2038-01-19
echo      - PauseUpdatesExpiryTime = 2038-01-19
echo.
echo   3. ОТКЛЮЧАЕТ ПРЕДВАРИТЕЛЬНЫЕ СБОРКИ:
echo      - AllowBuildPreview = 0 (отключение тестовых сборок Windows)
echo.
echo   4. ОТКЛЮЧАЕТ УВЕДОМЛЕНИЯ ОБ ОБНОВЛЕНИИ ВЕРСИИ:
echo      - UpgradeAvailable = 0
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ПОЛНЫЙ КОНТРОЛЬ над обновлениями Windows
echo [+] НЕТ ПРИНУДИТЕЛЬНЫХ ПЕРЕЗАГРУЗОК
echo [+] НЕТ ФОНОВОЙ ЗАГРУЗКИ обновлений
echo [+] НЕТ P2P РАЗДАЧИ обновлений другим компьютерам
echo [+] ЭКОНОМИЯ ИНТЕРНЕТ-ТРАФИКА
echo [+] ЭКОНОМИЯ МЕСТА НА ДИСКЕ
echo [+] УМЕНЬШЕНИЕ НАГРУЗКИ НА CPU
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] ОБНОВЛЕНИЯ WINDOWS НЕ УСТАНАВЛИВАЮТСЯ АВТОМАТИЧЕСКИ
echo [-] Microsoft не получает телеметрию о проблемах
echo [-] Нужно вручную проверять и устанавливать обновления
echo [-] Снижается безопасность без критических обновлений
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте от имени Администратора или TrustedInstaller
echo [2] Рекомендуется для геймеров и опытных пользователей
echo [3] Регулярно проверяйте обновления вручную (раз в 1-2 недели)
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

echo [ЧАСТЬ 1] ОТКЛЮЧЕНИЕ DELIVERY OPTIMIZATION (P2P РАЗДАЧА)...
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f
echo [OK] Delivery Optimization отключена (DODownloadMode = 0)
echo.

echo [ЧАСТЬ 2] НАСТРОЙКА ПАУЗЫ ОБНОВЛЕНИЙ (до 2038 года)...
echo.

reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "FlightSettingsMaxPauseDays" /t REG_DWORD /d 5269 /f
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /t REG_SZ /d "2023-08-17T12:47:51Z" /f
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /t REG_SZ /d "2038-01-19T03:14:07Z" /f
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /t REG_SZ /d "2023-08-17T12:47:51Z" /f
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /t REG_SZ /d "2038-01-19T03:14:07Z" /f
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /t REG_SZ /d "2023-08-17T12:47:51Z" /f
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d "2038-01-19T03:14:07Z" /f
echo [OK] Обновления приостановлены до 2038 года
echo.

echo [ЧАСТЬ 3] ОТКЛЮЧЕНИЕ УВЕДОМЛЕНИЙ ОБ ОБНОВЛЕНИИ ВЕРСИИ...
echo.

reg add "HKLM\SYSTEM\Setup\UpgradeNotification" /v "UpgradeAvailable" /t REG_DWORD /d 0 /f
echo [OK] Уведомления об обновлении версии отключены
echo.

echo [ЧАСТЬ 4] ОТКЛЮЧЕНИЕ ПРЕДВАРИТЕЛЬНЫХ СБОРОК...
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /t REG_DWORD /d 0 /f
echo [OK] Предварительные сборки отключены
echo.

echo ================================================================================
echo                    ГОТОВО! ОБНОВЛЕНИЯ WINDOWS ОТКЛЮЧЕНЫ
echo ================================================================================
echo.
echo Что сделано:
echo   - Отключена P2P раздача обновлений (Delivery Optimization)
echo   - Обновления приостановлены до 2038 года (15 лет)
echo   - Отключены уведомления об обновлении версии
echo   - Отключены предварительные сборки Windows
echo.
echo Результат:
echo   - Windows НЕ проверяет обновления автоматически
echo   - Windows НЕ загружает обновления
echo   - Windows НЕ раздает обновления другим ПК
echo   - Windows НЕ предлагает обновиться до новой версии
echo.
echo Для установки обновлений:
echo   - Откройте Параметры -> Центр обновления Windows
echo   - Нажмите "Проверить наличие обновлений" вручную
echo.

echo.