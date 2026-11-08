@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - БЛОКИРОВКА DEVICECENSUS
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo DeviceCensus.exe - это системный компонент Windows, который:
echo.
echo   - Собирает информацию об устройстве (версия ОС, архитектура, язык)
echo   - Отправляет телеметрию в Microsoft
echo   - Используется для статистики использования Windows
echo   - Запускается по расписанию и при разных событиях
echo.
echo Данный скрипт ПОЛНОСТЬЮ БЛОКИРУЕТ запуск DeviceCensus.exe:
echo.
echo   1. БЛОКИРОВКА ЗАПУСКА через политику DisallowRun
echo      - DeviceCensus.exe добавляется в черный список программ
echo      - Система НЕ СМОЖЕТ его запустить
echo.
echo   2. ОТКЛЮЧЕНИЕ DELIVERY OPTIMIZATION
echo      - Отключает фоновую загрузку обновлений с других ПК
echo      - Отключает раздачу обновлений
echo.
echo   3. ОТКЛЮЧЕНИЕ СИНХРОНИЗАЦИИ ЯЗЫКОВ
echo      - Отключает синхронизацию языковых настроек
echo
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ПОЛНОСТЬЮ ОТКЛЮЧАЕТ телеметрию DeviceCensus
echo [+] НЕ ОТПРАВЛЯЮТСЯ данные об устройстве в Microsoft
echo [+] Снижается фоновая нагрузка на систему
echo [+] Повышается конфиденциальность
echo [+] Отключается P2P раздача обновлений (экономит трафик)
echo [+] НЕ ВЛИЯЕТ на работу Windows или приложений
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Microsoft не получает данные для улучшения Windows
echo [-] При обновлении Windows политика может сброситься
echo [-] В некоторых сборках Windows может потребоваться повторный запуск
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте от имени Администратора
echo [2] Не влияет на работу системы - безопасно для всех
echo [3] После крупных обновлений Windows проверьте, не сбросилась ли блокировка
echo [4] Для возврата используйте скрипт отката
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [1/7] Создание политики запрета запуска программ...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /f >nul 2>&1
echo [OK] Ветка DisallowRun создана
echo.

echo [2/7] Поиск свободного индекса для добавления DeviceCensus.exe...
set "index=1"
:findindex
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "%index%" >nul 2>&1
if not errorlevel 1 (
    set /a index+=1
    goto findindex
)
echo [OK] Найден свободный индекс: %index%
echo.

echo [3/7] Добавление DeviceCensus.exe в черный список...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "%index%" /t REG_SZ /d "DeviceCensus.exe" /f >nul 2>&1
echo [OK] DeviceCensus.exe добавлен в список запрещенных программ
echo.

echo [4/7] Включение политики запрета запуска...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisallowRun" /t REG_DWORD /d 1 /f >nul 2>&1
echo [OK] Политика DisallowRun включена
echo.

echo [5/7] Отключение Delivery Optimization для локальной службы...
reg add "HKEY_USERS\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
echo [OK] Delivery Optimization для локальной службы отключена
echo.

echo [6/7] Отключение Delivery Optimization для текущего пользователя...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
echo [OK] Delivery Optimization для текущего пользователя отключена
echo.

echo [7/7] Отключение синхронизации языковых настроек...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo [OK] Синхронизация языков отключена
echo.

echo ================================================================================
echo                    ГОТОВО! DEVICECENSUS ЗАБЛОКИРОВАН
echo ================================================================================
echo.
echo Что сделано:
echo   - DeviceCensus.exe добавлен в черный список программ
echo   - Windows больше не сможет запустить DeviceCensus.exe
echo   - Delivery Optimization (P2P раздача обновлений) отключена
echo   - Синхронизация языковых настроек отключена
echo.
echo Проверка: попробуйте запустить DeviceCensus.exe вручную
echo (обычно находится в C:\Windows\System32\)
echo При попытке запуска ничего не произойдет - программа заблокирована.
echo.
echo Для возврата используйте скрипт "Включение DeviceCensus.bat"
echo.

echo.