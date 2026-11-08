@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

echo ================================================================================
echo                 xOS PLAYBOOK - УДАЛЕНИЕ UPDATE HEALTH TOOLS
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Update Health Tools - это компонент Windows, который отслеживает состояние
echo обновлений, автоматически исправляет проблемы с Windows Update и собирает
echo диагностические данные (телеметрию).
echo.
echo Скрипт полностью удаляет:
echo   - Update Health Tools из списка установленных программ
echo   - Все записи из реестра (Uninstall, Products, Features, Components)
echo   - Коды обновлений (UpgradeCodes)
echo   - Записи о папках в Installer
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ОТКЛЮЧАЕТ ТЕЛЕМЕТРИЮ Microsoft
echo [+] Снижает фоновую нагрузку на систему
echo [+] Освобождает место на диске
echo [+] Убирает лишний фоновый процесс
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] При проблемах с Windows Update диагностика будет недоступна
echo [-] Microsoft может вернуть компонент при следующем крупном обновлении
echo [-] Невозможно откатить через стандартные средства
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте от имени Администратора
echo [2] Рекомендуется для продвинутых пользователей
echo [3] Перед удалением создайте точку восстановления
echo [4] Для возврата используйте скрипт отката в папке Undo
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [1/8] Поиск GUID компонента в реестре...
for /f "usebackq tokens=7 delims=\" %%e in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /d /f "Update Health Tools" /s 2^>nul ^| findstr /i /c:"CurrentVersion\Uninstall\\"`) do set "GUID=%%e"

if not "!GUID!"=="" (
    echo [OK] Найден GUID: !GUID!
    echo [2/8] Удаление из ветки Uninstall...
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\!GUID!" /f >nul 2>&1
    echo [OK] Удалено
) else (
    echo [ПРЕДУПРЕЖДЕНИЕ] GUID не найден
)
echo.

echo [3/8] Поиск Product ID...
for /f "usebackq tokens=4 delims=\" %%e in (`reg query "HKCR\Installer\Products" /d /f "Update Health Tools" /s 2^>nul ^| findstr /i /c:"Installer\Products\\"`) do set "ProdID=%%e"

echo [OK] Найден Product ID: !ProdID!
echo.

echo [4/8] Удаление UpgradeCodes...
for /f "usebackq delims=" %%e in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UpgradeCodes" /d /f "!ProdID!" /s 2^>nul ^| findstr /i /c:"Installer\UpgradeCodes\\"`) do (
    reg delete "%%e" /f >nul 2>&1
)
echo [OK] UpgradeCodes удалены
echo.

echo [5/8] Удаление из ветки Products...
reg delete "HKCR\Installer\Products\!ProdID!" /f >nul 2>&1
echo [OK] Products удален
echo.

echo [6/8] Удаление из ветки Features...
reg delete "HKCR\Installer\Features\!ProdID!" /f >nul 2>&1
echo [OK] Features удален
echo.

echo [7/8] Удаление оставшихся UpgradeCodes...
for /f "usebackq delims=" %%e in (`reg query "HKCR\Installer\UpgradeCodes" /d /f "!ProdID!" /s 2^>nul ^| findstr /i /c:"Installer\UpgradeCodes\\"`) do (
    reg delete "%%e" /f >nul 2>&1
)
echo [OK] Оставшиеся UpgradeCodes удалены
echo.

echo [8/8] Удаление записей о папках...
for /f "usebackq delims=" %%e in (`PowerShell -NoP -C "(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\Folders' -ErrorAction SilentlyContinue).Property" 2^>nul ^| findstr /i /c:"Update Health Tools"`) do (
    set "var=%%e"
    if "!var:~-1!"=="\" set "var=%%e\"
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\Folders" /v "!var!" /f >nul 2>&1
)

rem Дополнительная очистка UserData
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\!ProdID!" /f >nul 2>&1

echo [OK] Записи о папках удалены
echo.

echo ================================================================================
echo                  ГОТОВО! UPDATE HEALTH TOOLS УДАЛЕН
echo ================================================================================
echo.
echo Что удалено:
echo   - Update Health Tools из списка установленных программ
echo   - Все записи из реестра (Uninstall, Products, Features, Components)
echo   - Коды обновлений (UpgradeCodes)
echo   - Записи о папках
echo.
echo Для полного применения рекомендуется перезагрузить компьютер.
echo При следующем крупном обновлении Windows может вернуть компонент.
echo.

echo.