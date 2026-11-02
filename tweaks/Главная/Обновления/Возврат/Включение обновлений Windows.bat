@echo off
chcp 65001 >nul

echo ================================================================================
echo                 SYNERGYOS - ВКЛЮЧЕНИЕ ОБНОВЛЕНИЙ WINDOWS
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт ВОССТАНАВЛИВАЕТ стандартные настройки обновлений Windows.
echo Это полный откат для скрипта "Отключение обновлений Windows.bat".
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

echo [ЧАСТЬ 1] ВКЛЮЧЕНИЕ DELIVERY OPTIMIZATION...
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /f >nul 2>&1
echo [OK] Delivery Optimization восстановлен (стандарт - P2P)
echo.

echo [ЧАСТЬ 2] УДАЛЕНИЕ НАСТРОЕК ПАУЗЫ ОБНОВЛЕНИЙ...
echo.

reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "FlightSettingsMaxPauseDays" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /f >nul 2>&1
echo [OK] Настройки паузы обновлений удалены
echo.

echo [ЧАСТЬ 3] ВКЛЮЧЕНИЕ УВЕДОМЛЕНИЙ ОБ ОБНОВЛЕНИИ ВЕРСИИ...
echo.

reg delete "HKLM\SYSTEM\Setup\UpgradeNotification" /v "UpgradeAvailable" /f >nul 2>&1
echo [OK] Уведомления об обновлении версии включены
echo.

echo [ЧАСТЬ 4] ВКЛЮЧЕНИЕ ПРЕДВАРИТЕЛЬНЫХ СБОРОК...
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /f >nul 2>&1
echo [OK] Предварительные сборки включены (стандарт)
echo.

echo [ЧАСТЬ 5] ПРИНУДИТЕЛЬНАЯ ПРОВЕРКА ОБНОВЛЕНИЙ...
echo.

wuauclt /detectnow >nul 2>&1
echo [OK] Запущена проверка обновлений
echo.

echo ================================================================================
echo                    ГОТОВО! ОБНОВЛЕНИЯ WINDOWS ВКЛЮЧЕНЫ
echo ================================================================================
echo.
echo Что сделано:
echo   - Восстановлена P2P раздача обновлений
echo   - Удалены настройки паузы обновлений
echo   - Включены уведомления об обновлении версии
echo   - Включены предварительные сборки
echo   - Запущена проверка обновлений
echo.
echo Результат:
echo   - Windows снова проверяет и устанавливает обновления
echo   - Рекомендуется перезагрузить компьютер
echo.

echo.