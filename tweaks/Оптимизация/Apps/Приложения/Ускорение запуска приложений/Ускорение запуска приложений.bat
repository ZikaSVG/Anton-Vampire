@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ОТКЛЮЧЕНИЕ ЗАДАЧ ОПТИМИЗАЦИИ
echo                  (.NET NGEN, REGISTRY, DATA INTEGRITY)
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Отключает задачи оптимизации .NET NGEN, резервного копирования реестра
echo и проверки целостности данных.
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] Снижает фоновую нагрузку на CPU и диск
echo [+] Ускоряет запуск приложений
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] .NET приложения могут запускаться чуть дольше
echo [-] Резервная копия реестра не создается автоматически
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

schtasks /change /tn "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64 Critical" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 Critical" /disable >nul 2>&1

schtasks /change /tn "\Microsoft\Windows\Registry\RegIdleBackup" /disable >nul 2>&1

schtasks /change /tn "\Microsoft\Windows\Data Integrity Scan\Data Integrity Check And Scan" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan for Crash Recovery" /disable >nul 2>&1

echo.
echo ================================================================================
echo                 ГОТОВО! ЗАДАЧИ ОПТИМИЗАЦИИ ОТКЛЮЧЕНЫ
echo ================================================================================

echo.