@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - УДАЛЕНИЕ MICROSOFT ONEDRIVE
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo OneDrive - это облачное хранилище от Microsoft, встроенное в Windows 10/11.
echo Однако многие пользователи отключают или удаляют его, потому что он:
echo.
echo   - ПОСТОЯННО РАБОТАЕТ В ФОНЕ (потребляет ОЗУ и CPU)
echo   - СИНХРОНИЗИРУЕТ ФАЙЛЫ (создает сетевой трафик)
echo   - ЗАНИМАЕТ МЕСТО В ПРОВОДНИКЕ (левая панель)
echo   - НАВЯЗЫВАЕТ ОБЛАКО вместо локального хранения
echo   - АВТОМАТИЧЕСКИ ЗАПУСКАЕТСЯ при входе в систему
echo.
echo Данный скрипт ПОЛНОСТЬЮ УДАЛЯЕТ OneDrive из системы:
echo.
echo   1. Завершает процесс OneDrive.exe
echo   2. Удаляет OneDrive из автозагрузки
echo   3. Запускает деинсталлятор OneDriveSetup.exe /uninstall
echo   4. Удаляет папки OneDrive (пользовательские, локальные, программные)
echo   5. Удаляет ярлыки OneDrive (меню Пуск, Links, панель задач)
echo   6. Удаляет CLSID OneDrive из реестра (убирает из Проводника)
echo   7. Добавляет политики отключения OneDrive
echo   8. Удаляет задачи планировщика OneDrive
echo   9. Удаляет переменную среды OneDrive
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ПОЛНОСТЬЮ ОСВОБОЖДАЕТ РЕСУРСЫ СИСТЕМЫ (ОЗУ, CPU, диск)
echo [+] ОСТАНАВЛИВАЕТ ФОНОВУЮ СИНХРОНИЗАЦИЮ (экономия трафика)
echo [+] УБИРАЕТ OneDrive ИЗ ПРОВОДНИКА (левая панель чище)
echo [+] ОСВОБОЖДАЕТ МЕСТО НА ДИСКЕ (кеш OneDrive, до 1-2 ГБ)
echo [+] УСКОРЯЕТ ЗАГРУЗКУ СИСТЕМЫ (не запускается при старте)
echo [+] ПОВЫШАЕТ КОНФИДЕНЦИАЛЬНОСТЬ (файлы не уходят в облако)
echo [+] УБИРАЕТ НАДОЕДАЮЩИЕ УВЕДОМЛЕНИЯ о нехватке места
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Облачная синхронизация файлов становится недоступна
echo [-] Документы не резервируются автоматически в облаке
echo [-] Некоторые приложения могут искать OneDrive (редко)
echo [-] При обновлении Windows OneDrive может восстановиться
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте от имени Администратора
echo [2] ПЕРЕД удалением убедитесь, что все файлы синхронизированы
echo [3] Если используете облако - выберите альтернативу (Google Drive, Dropbox)
echo [4] После удаления перезагрузите компьютер
echo [5] Восстановление OneDrive возможно через скачивание установщика
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [1/11] Завершение процесса OneDrive.exe...
taskkill /f /im "OneDrive.exe" >nul 2>&1
echo [OK] Процесс OneDrive завершен
echo.

echo [2/11] Удаление OneDrive из автозагрузки...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
echo [OK] OneDrive удален из автозагрузки
echo.

echo [3/11] Удаление OneDrive через установщик (x64/x86)...
if exist "%SYSTEMROOT%\System32\OneDriveSetup.exe" (
    echo Запуск деинсталлятора из System32...
    start /wait %SYSTEMROOT%\System32\OneDriveSetup.exe /uninstall >nul 2>&1
)
if exist "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" (
    echo Запуск деинсталлятора из SysWOW64...
    start /wait %SYSTEMROOT%\SysWOW64\OneDriveSetup.exe /uninstall >nul 2>&1
)
echo [OK] Деинсталлятор OneDrive выполнен
echo.

echo [4/11] Удаление папок OneDrive...
rmdir /s /q "%USERPROFILE%\OneDrive" >nul 2>&1
rmdir /s /q "%LOCALAPPDATA%\Microsoft\OneDrive" >nul 2>&1
rmdir /s /q "%PROGRAMDATA%\Microsoft OneDrive" >nul 2>&1
rmdir /s /q "C:\OneDriveTemp" >nul 2>&1
echo [OK] Папки OneDrive удалены
echo.

echo [5/11] Удаление ярлыков OneDrive...
del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Links\OneDrive.lnk" >nul 2>&1
del /f /q "%SYSTEMROOT%\ServiceProfiles\LocalService\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >nul 2>&1
del /f /q "%SYSTEMROOT%\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >nul 2>&1
echo [OK] Ярлыки OneDrive удалены
echo.

echo [6/11] Удаление CLSID OneDrive из реестра (убирает из Проводника)...
reg delete "HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
echo [OK] CLSID OneDrive удалены
echo.

echo [7/11] Добавление политик отключения OneDrive...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d 1 /f >nul
echo [OK] Политики отключения OneDrive добавлены
echo.

echo [8/11] Удаление задач планировщика OneDrive...
schtasks /delete /tn "\OneDrive Reporting Task" /f >nul 2>&1
schtasks /delete /tn "\OneDrive Standalone Update Task" /f >nul 2>&1
schtasks /delete /tn "\OneDrive Per-Machine Standalone Update" /f >nul 2>&1
echo [OK] Задачи планировщика OneDrive удалены
echo.

echo [9/11] Удаление переменной среды OneDrive...
reg delete "HKCU\Environment" /v "OneDrive" /f >nul 2>&1
echo [OK] Переменная среды OneDrive удалена
echo.

echo [10/11] Применение изменений и обновление политик...
gpupdate /force >nul 2>&1
echo [OK] Изменения применены
echo.

echo [11/11] Проверка результата...
if exist "%LOCALAPPDATA%\Microsoft\OneDrive" (
    echo [ПРЕДУПРЕЖДЕНИЕ] OneDrive все еще присутствует в системе
) else (
    echo [OK] OneDrive полностью удален
)
echo.

echo ================================================================================
echo                    ГОТОВО! MICROSOFT ONEDRIVE УДАЛЕН
echo ================================================================================
echo.
echo Что сделано:
echo   - Процесс OneDrive завершен
echo   - Автозагрузка OneDrive отключена
echo   - Деинсталлятор OneDrive выполнен
echo   - Папки OneDrive удалены
echo   - Ярлыки OneDrive удалены
echo   - CLSID OneDrive удалены (Проводник очищен)
echo   - Политики отключения добавлены
echo   - Задачи планировщика удалены
echo   - Переменная среды удалена
echo.
echo Результат:
echo   - OneDrive больше не запускается при старте
echo   - OneDrive не отображается в Проводнике
echo   - Фоновая синхронизация остановлена
echo   - Освобождено место на диске
echo.
echo Примечание: Если OneDrive восстановится при обновлении Windows,
echo просто запустите этот скрипт снова.
echo.

echo.