@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - УДАЛЕНИЕ АССОЦИАЦИЙ MICROSOFT EDGE
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Microsoft Edge (Chromium) глубоко интегрирован в Windows 10/11 и
echo часто "навязывает" себя в качестве браузера по умолчанию для многих форматов.
echo.
echo Данный скрипт УДАЛЯЕТ ВСЕ АССОЦИАЦИИ MICROSOFT EDGE:
echo.
echo   1. Удаляет ключи реестра Edge (CLSID, AppID, Interface, TypeLib)
echo   2. Удаляет ассоциации файлов (HTM, HTML, SVG, XML, WEBP, PDF и др.)
echo   3. Удаляет Edge из списка рекомендуемых приложений
echo   4. Удаляет Edge из автозагрузки (Microsoft Edge Update)
echo   5. Удаляет Edge из зарегистрированных приложений
echo   6. Удаляет обработчик PDF через Edge
echo
echo ВАЖНО! Edge сам остается в системе, но перестает быть связанным с форматами.
echo После выполнения скрипта система спросит "Чем открыть этот файл?"
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] MICROSOFT EDGE ПЕРЕСТАЕТ БЫТЬ БРАУЗЕРОМ ПО УМОЛЧАНИЮ
echo [+] ПРИ ОТКРЫТИИ HTML/HTM СИСТЕМА СПРОСИТ - какой браузер использовать
echo [+] ПОЛЬЗОВАТЕЛЬ ПОЛУЧАЕТ РЕАЛЬНЫЙ ВЫБОР браузера
echo [+] УДАЛЯЕТСЯ НАВЯЗЧИВАЯ ИНТЕГРАЦИЯ Edge в систему
echo [+] Edge не пытается перехватывать PDF при каждом обновлении
echo [+] ИСПРАВЛЯЕТ СИТУАЦИЮ, когда Edge самопроизвольно становится браузером по умолчанию
echo [+] Удаляется автообновление Edge из автозагрузки
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] При обновлении Windows может восстановить ассоциации
echo [-] Некоторые приложения, использующие Edge WebView2, могут работать иначе
echo [-] Если Edge полностью удален, скрипт выдаст ошибки (но это не страшно)
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте ПОСЛЕ установки альтернативного браузера (Chrome, Firefox, Opera)
echo [2] Запускайте ОТ ИМЕНИ АДМИНИСТРАТОРА
echo [3] Рекомендуется выполнить после каждого крупного обновления Windows
echo [4] После выполнения проверьте ассоциации файлов в Параметрах -> Приложения по умолчанию
echo [5] Если нужно вернуть Edge - используйте скрипт отката
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [ЧАСТЬ 1] Удаление ключей реестра Edge...
echo.

echo [1/26] Удаление TaskbarMigratedBrowserPin...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMigratedBrowserPin" /f >nul 2>&1

echo [2/26] Удаление CLSID {1FCBE96C-1697-43AF-9140-2897C7C69767}...
reg delete "HKCR\CLSID\{1FCBE96C-1697-43AF-9140-2897C7C69767}" /f >nul 2>&1

echo [3/26] Удаление AppID {1FCBE96C-1697-43AF-9140-2897C7C69767}...
reg delete "HKCR\AppID\{1FCBE96C-1697-43AF-9140-2897C7C69767}" /f >nul 2>&1

echo [4/26] Удаление Interface {C9C2B807-7731-4F34-81B7-44FF7779522B}...
reg delete "HKCR\Interface\{C9C2B807-7731-4F34-81B7-44FF7779522B}" /f >nul 2>&1

echo [5/26] Удаление TypeLib {C9C2B807-7731-4F34-81B7-44FF7779522B}...
reg delete "HKCR\TypeLib\{C9C2B807-7731-4F34-81B7-44FF7779522B}" /f >nul 2>&1

echo [6/26] Удаление MSEdgeHTM...
reg delete "HKCR\MSEdgeHTM" /f >nul 2>&1

echo [7/26] Удаление MSEdgePDF...
reg delete "HKCR\MSEdgePDF" /f >nul 2>&1

echo [8/26] Удаление MSEdgeMHT...
reg delete "HKCR\MSEdgeMHT" /f >nul 2>&1

echo [9/26] Удаление AppID {628ACE20-B77A-456F-A88D-547DB6CEEDD5}...
reg delete "HKCR\AppID\{628ACE20-B77A-456F-A88D-547DB6CEEDD5}" /f >nul 2>&1

echo [10/26] Удаление ie_to_edge_bho.dll...
reg delete "HKCR\AppID\ie_to_edge_bho.dll" /f >nul 2>&1

echo [11/26] Удаление AppID {31575964-95F7-414B-85E4-0E9A93699E13}...
reg delete "HKCR\AppID\{31575964-95F7-414B-85E4-0E9A93699E13}" /f >nul 2>&1

echo [12/26] Удаление CLSID {1FD49718-1D00-4B19-AF5F-070AF6D5D54C}...
reg delete "HKCR\CLSID\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}" /f >nul 2>&1

echo [13/26] Удаление WOW6432Node CLSID {1FD49718-1D00-4B19-AF5F-070AF6D5D54C}...
reg delete "HKCR\WOW6432Node\CLSID\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}" /f >nul 2>&1

echo [14/26] Удаление ie_to_edge_bho.IEToEdgeBHO...
reg delete "HKCR\ie_to_edge_bho.IEToEdgeBHO" /f >nul 2>&1

echo [15/26] Удаление ie_to_edge_bho.IEToEdgeBHO.1...
reg delete "HKCR\ie_to_edge_bho.IEToEdgeBHO.1" /f >nul 2>&1

echo [16/26] Удаление Microsoft Edge Update из автозагрузки...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Microsoft Edge Update" /f >nul 2>&1

echo [17/26] Удаление CLSID {3A84F9C2-6164-485C-A7D9-4B27F8AC009E}...
reg delete "HKCR\CLSID\{3A84F9C2-6164-485C-A7D9-4B27F8AC009E}" /f >nul 2>&1

echo [18/26] Удаление WOW6432Node CLSID {3A84F9C2-6164-485C-A7D9-4B27F8AC009E}...
reg delete "HKCR\WOW6432Node\CLSID\{3A84F9C2-6164-485C-A7D9-4B27F8AC009E}" /f >nul 2>&1

echo [19/26] Удаление Active Setup компонента {9459C573-B17A-45AE-9F64-1857B5D58CEE}...
reg delete "HKCU\SOFTWARE\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}" /f >nul 2>&1

echo [20/26] Удаление HKCU\SOFTWARE\Microsoft\Edge...
reg delete "HKCU\SOFTWARE\Microsoft\Edge" /f >nul 2>&1
echo.

echo [ЧАСТЬ 2] Удаление ассоциаций файлов с Edge...
echo.

echo [21/26] Удаление ассоциаций для .htm, .html, .shtml, .svg, .xht, .xhtml, .webp, .xml...
reg delete "HKCR\.htm\OpenWithProgIds" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCR\.html\OpenWithProgIds" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCR\.shtml\OpenWithProgids" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCR\.svg\OpenWithProgIds" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCR\.xht\OpenWithProgIds" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCR\.xhtml\OpenWithProgIds" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCR\.webp\OpenWithProgids" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCR\.xml\OpenWithProgIds" /v "MSEdgeHTM" /f >nul 2>&1

reg delete "HKCU\SOFTWARE\Classes\.htm\OpenWithProgids" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Classes\.html\OpenWithProgids" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Classes\.shtml\OpenWithProgids" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Classes\.svg\OpenWithProgids" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Classes\.xht\OpenWithProgids" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Classes\.xhtml\OpenWithProgids" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Classes\.webp\OpenWithProgids" /v "MSEdgeHTM" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Classes\.xml\OpenWithProgids" /v "MSEdgeHTM" /f >nul 2>&1

echo [22/26] Удаление уведомлений MSEdgeHTM...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v "MSEdgeHTM_microsoft-edge" /f >nul 2>&1

echo [23/26] Удаление обработчика PDF через Edge...
reg delete "HKCR\.pdf\ShellEx\{8895b1c6-b41f-4c1c-a562-0d564250836f}" /f >nul 2>&1

echo [24/26] Удаление Edge из зарегистрированных приложений...
reg delete "HKCU\SOFTWARE\RegisteredApplications" /v "Microsoft Edge" /f >nul 2>&1

echo.
echo ================================================================================
echo                    ГОТОВО! АССОЦИАЦИИ EDGE УДАЛЕНЫ
echo ================================================================================
echo.
echo Что сделано:
echo   - Удалены все ключи реестра, связанные с Microsoft Edge
echo   - Удалены ассоциации файлов: .htm, .html, .shtml, .svg, .xht, .xhtml, .webp, .xml, .pdf
echo   - Edge удален из автозагрузки
echo   - Edge удален из списка зарегистрированных приложений
echo.
echo Рекомендации после выполнения:
echo   - Перезагрузите компьютер
echo   - Установите браузер по умолчанию через Параметры -> Приложения по умолчанию
echo   - При открытии HTML файлов Windows спросит - какой браузер использовать
echo.
echo Примечание: Сам Microsoft Edge не удаляется, только его ассоциации.
echo Для полного удаления Edge используйте специальные скрипты.
echo.

echo.