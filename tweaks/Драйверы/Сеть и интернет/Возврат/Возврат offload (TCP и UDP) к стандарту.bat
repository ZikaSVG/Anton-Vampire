@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ВОЗВРАТ OFFLOAD TCP/UDP
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Удаляет настройки offload, возвращая стандартные значения Windows.
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] Возвращает стандартные настройки Windows
echo [+] Исправляет проблемы с сетью если они возникли после оптимизации
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Нет минусов
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

for /f %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr "HKEY"') do (
    for /f %%i in ('reg query "%%a" /v "*TCPChecksumOffloadIPv4" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*TCPChecksumOffloadIPv4" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*TCPChecksumOffloadIPv6" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*TCPChecksumOffloadIPv6" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*TCPConnectionOffloadIPv4" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*TCPConnectionOffloadIPv4" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*TCPConnectionOffloadIPv6" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*TCPConnectionOffloadIPv6" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*TCPUDPChecksumOffloadIPv4" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*TCPUDPChecksumOffloadIPv4" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*TCPUDPChecksumOffloadIPv6" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*TCPUDPChecksumOffloadIPv6" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*UDPChecksumOffloadIPv4" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*UDPChecksumOffloadIPv4" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*UDPChecksumOffloadIPv6" ^| findstr "HKEY"') do Reg.exe delete "%%i" /v "*UDPChecksumOffloadIPv6" /f >nul 2>&1
)

echo.
echo ================================================================================
echo                  ГОТОВО! OFFLOAD ВОЗВРАЩЕН К СТАНДАРТУ
echo ================================================================================

echo.