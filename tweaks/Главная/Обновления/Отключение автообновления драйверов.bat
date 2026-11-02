@echo off
chcp 65001 >nul

echo ================================================================================
echo                 SYNERGYOS - ОТКЛЮЧЕНИЕ АВТООБНОВЛЕНИЯ ДРАЙВЕРОВ
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Windows Update автоматически ищет и устанавливает драйверы для устройств.
echo Это часто приводит к проблемам:
echo.
echo   - ПРОБЛЕМЫ СОВМЕСТИМОСТИ (Windows ставит неподходящие драйверы)
echo   - СБРОС НАСТРОЕК (видеокарта, звук, сеть)
echo   - СНИЖЕНИЕ ПРОИЗВОДИТЕЛЬНОСТИ (особенно на старых устройствах)
echo   - ЗАМЕНА ОПТИМАЛЬНЫХ ДРАЙВЕРОВ на более новые, но нестабильные
echo.
echo Данный твик ПОЛНОСТЬЮ ОТКЛЮЧАЕТ АВТОМАТИЧЕСКУЮ УСТАНОВКУ ДРАЙВЕРОВ
echo через Windows Update, но позволяет устанавливать их вручную.
echo.
echo Отключаемые параметры:
echo.
echo   1. ИСКЛЮЧЕНИЕ ДРАЙВЕРОВ ИЗ ОБНОВЛЕНИЙ (5 ключей реестра):
echo      - ExcludeWUDriversInQualityUpdate = 1
echo      - Блокирует загрузку драйверов через Центр обновлений
echo      - Применяется через PolicyManager и WindowsUpdate
echo.
echo   2. ОТКЛЮЧЕНИЕ МЕТАДАННЫХ УСТРОЙСТВ:
echo      - PreventDeviceMetadataFromNetwork = 1
echo      - Блокирует загрузку информации об устройствах (иконки, описания)
echo      - Экономит трафик и ускоряет работу Диспетчера устройств
echo.
echo   3. ОТКЛЮЧЕНИЕ ПОИСКА ДРАЙВЕРОВ:
echo      - SearchOrderConfig = 0 (не искать драйверы в Windows Update)
echo      - DontSearchWindowsUpdate = 1 (не использовать WU для поиска драйверов)
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ПОЛНЫЙ КОНТРОЛЬ НАД ДРАЙВЕРАМИ (устанавливаете только то, что нужно)
echo [+] Windows НЕ ЗАМЕНЯЕТ ДРАЙВЕРЫ без вашего ведома
echo [+] НАСТРОЙКИ ВИДЕОКАРТЫ НЕ СБРАСЫВАЮТСЯ
echo [+] ЗВУК, СЕТЬ, ПРИНТЕРЫ работают стабильнее
echo [+] ЭКОНОМИЯ ТРАФИКА (драйверы не скачиваются в фоне)
echo [+] УСКОРЕНИЕ РАБОТЫ СИСТЕМЫ (нет фоновых проверок)
echo [+] ДИСПЕТЧЕР УСТРОЙСТВ РАБОТАЕТ БЫСТРЕЕ (без метаданных)
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] НУЖНО ВРУЧНУЮ устанавливать драйверы для новых устройств
echo [-] Нужно самим следить за обновлениями драйверов
echo [-] Устройства могут работать некорректно без драйверов
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте от имени Администратора или TrustedInstaller
echo [2] ОСОБЕННО РЕКОМЕНДУЕТСЯ ДЛЯ ВИДЕОКАРТ AMD И NVIDIA
echo [3] Рекомендуется для продвинутых пользователей
echo [4] Для возврата используйте скрипт "Включение автоустановки драйверов.bat"
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

echo [ЧАСТЬ 1] ИСКЛЮЧЕНИЕ ДРАЙВЕРОВ ИЗ ОБНОВЛЕНИЙ WINDOWS...
echo.

reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f
echo [1/7] PolicyManager (current) - ExcludeWUDriversInQualityUpdate = 1
echo.

reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f
echo [2/7] PolicyManager (default) - ExcludeWUDriversInQualityUpdate = 1
echo.

reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f
echo [3/7] WindowsUpdate UX - ExcludeWUDriversInQualityUpdate = 1
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f
echo [4/7] WindowsUpdate Policies - ExcludeWUDriversInQualityUpdate = 1
echo.

reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate" /v "value" /t REG_DWORD /d 1 /f
echo [5/7] PolicyManager value - ExcludeWUDriversInQualityUpdate = 1
echo.

echo [ЧАСТЬ 2] ОТКЛЮЧЕНИЕ МЕТАДАННЫХ УСТРОЙСТВ...
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f
echo [6/7] Device Metadata - PreventDeviceMetadataFromNetwork = 1 (иконки устройств не скачиваются)
echo.

echo [ЧАСТЬ 3] ОТКЛЮЧЕНИЕ ПОИСКА ДРАЙВЕРОВ В WINDOWS UPDATE...
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d 1 /f
echo [7/7] DriverSearching - SearchOrderConfig = 0, DontSearchWindowsUpdate = 1
echo.

echo ================================================================================
echo              ГОТОВО! АВТОУСТАНОВКА ДРАЙВЕРОВ ОТКЛЮЧЕНА
echo ================================================================================
echo.
echo Что сделано:
echo   - Windows Update НЕ будет устанавливать драйверы автоматически
echo   - Метаданные устройств (иконки, описания) НЕ скачиваются
echo   - Поиск драйверов в Windows Update ОТКЛЮЧЕН
echo.
echo Результат:
echo   - Драйверы не заменяются без вашего ведома
echo   - Настройки видеокарты не сбрасываются
echo   - Диспетчер устройств работает быстрее
echo   - Экономия интернет-трафика
echo.
echo Как установить драйвер вручную:
echo   - Скачайте драйвер с сайта производителя
echo   - Запустите установку вручную
echo   - Или через Диспетчер устройств -> Обновить драйвер
echo.
echo Для возврата используйте скрипт "Включение автоустановки драйверов.bat"
echo.

echo.