@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ВОССТАНОВЛЕНИЕ НАСТРОЕК .NET
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт ВОССТАНАВЛИВАЕТ стандартные настройки .NET Framework.
echo Это полный откат для скрипта "Оптимизация .NET Framework.bat".
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] Возвращает стандартное поведение .NET
echo [+] Включает сбор мусора в фоне (экономия памяти)
echo [+] Включает телеметрию (если нужна)
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] .NET приложения могут запускаться медленнее
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [1/7] Удаление настроек телеметрии .NET...
reg delete "HKCU\SOFTWARE\Microsoft\.NETFramework" /v "AllowTelemetry" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\.NETFramework" /v "AllowTelemetry" /f >nul 2>&1
echo [OK] Телеметрия включена
echo.

echo [2/7] Удаление настроек многопроцессорной компиляции...
reg delete "HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727\NGEN" /v "Processors" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319\NGEN" /v "Processors" /f >nul 2>&1
echo [OK] Стандартная компиляция восстановлена
echo.

echo [3/7] Удаление настроек сборки мусора...
reg delete "HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /v "GCLatencyMode" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /v "GCConcurrent" /f >nul 2>&1
echo [OK] Стандартная сборка мусора восстановлена
echo.

echo [4/7] Запуск службы .NET Optimization Service в фоне...
sc config "clr_optimization_v2.0.50727_32" start= manual >nul 2>&1
sc config "clr_optimization_v2.0.50727_64" start= manual >nul 2>&1
sc config "clr_optimization_v4.0.30319_32" start= manual >nul 2>&1
sc config "clr_optimization_v4.0.30319_64" start= manual >nul 2>&1
echo [OK] Служба оптимизации .NET настроена на ручной запуск
echo.

echo [5/7] Запуск фоновой оптимизации .NET...
if exist "%windir%\Microsoft.NET\Framework\v4.0.30319\ngen.exe" (
    %windir%\Microsoft.NET\Framework\v4.0.30319\ngen.exe update /queue >nul 2>&1
)
if exist "%windir%\Microsoft.NET\Framework64\v4.0.30319\ngen.exe" (
    %windir%\Microsoft.NET\Framework64\v4.0.30319\ngen.exe update /queue >nul 2>&1
)
echo [OK] Фоновая оптимизация запущена
echo.

echo [6/7] Очистка очереди NGEN (если есть)...
if exist "%windir%\Microsoft.NET\Framework\v4.0.30319\ngen.exe" (
    %windir%\Microsoft.NET\Framework\v4.0.30319\ngen.exe executeQueuedItems >nul 2>&1
)
echo [OK] Очередь NGEN очищена
echo.

echo [7/7] Перезапуск системы (рекомендовано)...
echo [ВНИМАНИЕ] Рекомендуется перезагрузить компьютер для полного применения изменений
echo.

echo ================================================================================
echo                    ГОТОВО! НАСТРОЙКИ .NET ВОССТАНОВЛЕНЫ
echo ================================================================================
echo.
echo Что сделано:
echo   - Удалены пользовательские настройки .NET
echo   - Включена телеметрия (если была отключена)
echo   - Восстановлен фоновый сбор мусора
echo   - Запущена фоновая оптимизация
echo.
echo Для повторной оптимизации используйте скрипт "Оптимизация .NET Framework.bat"
echo.

echo.