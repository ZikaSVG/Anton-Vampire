@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - НАСТРОЙКА POWERSHELL
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт выполняет комплексную настройку PowerShell в системе:
echo.
echo   1. ОТКЛЮЧЕНИЕ ТЕЛЕМЕТРИИ POWERSHELL
echo      - Устанавливает переменную окружения POWERSHELL_TELEMETRY_OPTOUT=1
echo      - PowerShell перестает отправлять данные об использовании в Microsoft
echo.
echo   2. НАСТРОЙКА АССОЦИАЦИЙ .PS1 ФАЙЛОВ
echo      - Устанавливает открытие PS1 скриптов через PowerShell
echo      - Добавляет пункт "Запуск от имени Администратора"
echo      - Снимает ограничения на выполнение скриптов (Unrestricted)
echo.
echo   3. НАСТРОЙКА АССОЦИАЦИЙ .PSM1 ФАЙЛОВ
echo      - Модули PowerShell также ассоциируются с PowerShell
echo.
echo   4. НАСТРОЙКА КОНТЕКСТНОГО МЕНЮ
echo      - Добавляет "Запуск от имени Администратора" для PS1 файлов
echo      - Добавляет иконку щита к этому пункту
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ОТКЛЮЧАЕТ ТЕЛЕМЕТРИЮ - повышает конфиденциальность
echo [+] УПРОЩАЕТ ЗАПУСК PS1 СКРИПТОВ - двойной клик по PS1 работает как по EXE
echo [+] ДОБАВЛЯЕТ ЗАПУСК ОТ АДМИНИСТРАТОРА - удобно для скриптов с правами
echo [+] СНИМАЕТ ОГРАНИЧЕНИЯ - позволяет выполнять любые скрипты без подписи
echo [+] НАСТРАИВАЕТ МОДУЛИ - PSM1 файлы тоже правильно открываются
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Снижает безопасность (Unrestricted позволяет выполнять любые скрипты)
echo [-] Отключение телеметрии может нарушить работу некоторых корпоративных систем
echo [-] Изменяет стандартные ассоциации файлов Windows
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Рекомендуется для продвинутых пользователей и админов
echo [2] Перед применением убедитесь, что понимаете риски (Unrestricted)
echo [3] Для возврата к стандартным настройкам используйте скрипт отката
echo [4] После настройки PS1 файлы можно запускать двойным кликом
echo [5] Для запуска скриптов от имени Администратора используйте ПКМ
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [1/9] Отключение телеметрии PowerShell...
setx POWERSHELL_TELEMETRY_OPTOUT 1 >nul
echo [OK] Переменная окружения POWERSHELL_TELEMETRY_OPTOUT установлена в 1
echo.

echo [2/9] Настройка ассоциаций .ps1 файлов...
ftype Microsoft.PowerShellScript.1="%windir%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -EP Unrestricted -File "%1" %*
echo [OK] Тип файлов .ps1 привязан к PowerShell
echo.

echo [3/9] Настройка команды "Открыть" для .ps1...
reg add "HKCR\Microsoft.PowerShellScript.1\Shell" /ve /t REG_SZ /d "Open" /f >nul
echo [OK] Команда "Открыть" добавлена
echo.

echo [4/9] Настройка пути к PowerShell для команды "Открыть"...
reg add "HKCR\Microsoft.PowerShellScript.1\Shell\Open\Command" /ve /t REG_EXPAND_SZ /d "\"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe\" \"%1\"" /f >nul
echo [OK] Путь к PowerShell настроен
echo.

echo [5/9] Добавление пункта "Запуск от имени Администратора"...
reg add "HKCR\Microsoft.PowerShellScript.1\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f >nul
echo [OK] Пункт добавлен, иконка щита установлена
echo.

echo [6/9] Настройка команды для запуска от имени Администратора...
reg add "HKCR\Microsoft.PowerShellScript.1\Shell\RunAs\Command" /ve /t REG_EXPAND_SZ /d "\"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe\" \"%1\"" /f >nul
echo [OK] Команда для администратора настроена
echo.

echo [7/9] Настройка ассоциаций .psm1 (модули PowerShell)...
reg add "HKCR\.psm1" /ve /t REG_SZ /d "Microsoft.PowerShellModule.1" /f >nul
reg add "HKCR\Microsoft.PowerShellModule.1\Shell" /ve /t REG_SZ /d "Open" /f >nul
echo [OK] Ассоциации .psm1 настроены
echo.

echo [8/9] Создание ключей OpenWithProgids для .psm1...
reg add "HKCR\.psm1\OpenWithProgids" /f >nul 2>&1
echo [OK] Ключ OpenWithProgids для .psm1 создан
echo.

echo [9/9] Создание ключей OpenWithProgids для .ps1...
reg add "HKCR\.ps1\OpenWithProgids" /f >nul 2>&1
echo [OK] Ключ OpenWithProgids для .ps1 создан
echo.

echo ================================================================================
echo                    ГОТОВО! POWERSHELL НАСТРОЕН
echo ================================================================================
echo.
echo Что сделано:
echo   - Телеметрия PowerShell отключена
echo   - PS1 файлы теперь открываются двойным кликом
echo   - Добавлен пункт "Запуск от имени Администратора" в контекстном меню PS1
echo   - Ассоциации PSM1 модулей настроены
echo.
echo Проверка: создайте файл test.ps1 и попробуйте открыть его двойным кликом
echo Для отката используйте скрипт "Восстановление стандартных настроек PowerShell.bat"
echo.

echo.