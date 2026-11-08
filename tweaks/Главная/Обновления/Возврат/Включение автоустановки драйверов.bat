@echo off
chcp 65001 >nul

echo ================================================================================
echo                 SYNERGYOS - ВКЛЮЧЕНИЕ АВТОУСТАНОВКИ ДРАЙВЕРОВ
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт ВОССТАНАВЛИВАЕТ стандартные настройки автоматической
echo установки драйверов через Windows Update.
echo.
echo Это полный откат для скрипта "Отключение автоустановки драйверов.bat".
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

echo [ЧАСТЬ 1] УДАЛЕНИЕ ИСКЛЮЧЕНИЙ ДРАЙВЕРОВ...
echo.

reg delete "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update" /v "ExcludeWUDriversInQualityUpdate" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update" /v "ExcludeWUDriversInQualityUpdate" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ExcludeWUDriversInQualityUpdate" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate" /v "value" /f >nul 2>&1
echo [OK] Исключения драйверов удалены (драйверы снова будут в обновлениях)
echo.

echo [ЧАСТЬ 2] ВКЛЮЧЕНИЕ МЕТАДАННЫХ УСТРОЙСТВ...
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /f >nul 2>&1
echo [OK] Метаданные устройств включены (иконки устройств будут скачиваться)
echo.

echo [ЧАСТЬ 3] ВОССТАНОВЛЕНИЕ ПОИСКА ДРАЙВЕРОВ...
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 1 /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "DontSearchWindowsUpdate" /f >nul 2>&1
echo [OK] Поиск драйверов включен (стандартные настройки Windows)
echo.

echo ================================================================================
echo              ГОТОВО! АВТОУСТАНОВКА ДРАЙВЕРОВ ВКЛЮЧЕНА
echo ================================================================================
echo.
echo Что восстановлено:
echo   - Windows Update снова будет устанавливать драйверы
echo   - Метаданные устройств снова скачиваются
echo   - Поиск драйверов в Windows Update включен
echo.
echo Результат:
echo   - Драйверы для новых устройств устанавливаются автоматически
echo   - Windows может заменять драйверы на свои версии
echo.
echo Для повторного отключения используйте скрипт "Отключение автоустановки драйверов.bat"
echo.

echo.