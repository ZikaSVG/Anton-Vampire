@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ================================================================================
echo              MICROSOFT EDGE — БЛОКИРОВКА (без удаления)
echo ================================================================================
echo.
echo   НЕ удаляет Edge. Отключает:
echo     - автозапуск при старте Windows
echo     - предзагрузку (Prelaunch)
echo     - фоновый режим
echo     - Startup Boost
echo     - автообновления Edge
echo     - задачу обновления EdgeUpdate
echo.
echo   Полезно, если Edge нужен как fallback-браузер,
echo   но не должен висеть в фоне и жрать ресурсы.
echo.
echo ================================================================================
echo.

echo [1/6] Завершение фоновых процессов Edge...
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im MicrosoftEdgeUpdate.exe >nul 2>&1
taskkill /f /im identity_helper.exe >nul 2>&1
timeout /t 1 /nobreak >nul
echo [OK] Фоновые процессы завершены
echo.

echo [2/6] Удаление из автозагрузки...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f >nul 2>&1
echo [OK] Автозагрузка очищена
echo.

echo [3/6] Отключение предзагрузки и фонового режима...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "AllowPrelaunch" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HardwareAccelerationModeEnabled" /t REG_DWORD /d 1 /f >nul
echo [OK] Политики Edge добавлены
echo.

echo [4/6] Отключение автообновлений Edge...
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "UpdateDefault" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "InstallDefault" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "AllowInstallation" /t REG_DWORD /d 0 /f >nul
echo [OK] Автообновления отключены
echo.

echo [5/6] Отключение задачи обновления Edge...
schtasks /change /tn "MicrosoftEdgeUpdateTaskMachineCore" /disable >nul 2>&1
schtasks /change /tn "MicrosoftEdgeUpdateTaskMachineUA" /disable >nul 2>&1
schtasks /change /tn "\MicrosoftEdgeUpdateTaskMachineCore" /disable >nul 2>&1
schtasks /change /tn "\MicrosoftEdgeUpdateTaskMachineUA" /disable >nul 2>&1
echo [OK] Задачи отключены
echo.

echo [6/6] Применение политик...
gpupdate /force >nul 2>&1
echo [OK] Готово
echo.

echo ================================================================================
echo                    ГОТОВО! EDGE ЗАБЛОКИРОВАН (не удалён)
echo ================================================================================
echo.
echo Edge остался в системе, но больше не висит в фоне.
echo Для возврата — удалите политики Edge вручную или через сброс настроек.
echo.
pause