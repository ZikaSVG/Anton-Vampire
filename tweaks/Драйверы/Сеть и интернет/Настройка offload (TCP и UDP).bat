@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - НАСТРОЙКА OFFLOAD TCP/UDP
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Настраивает аппаратное ускорение контрольных сумм TCP/UDP:
echo   - TCP Checksum Offload IPv4
echo   - TCP Checksum Offload IPv6
echo   - TCP Connection Offload IPv4 и IPv6
echo   - TCP/UDP Checksum Offload IPv4 и IPv6
echo   - UDP Checksum Offload IPv4 и IPv6
echo.
echo Значение 3 - включить с сертификацией (максимальная производительность)
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] УСКОРЯЕТ ОБРАБОТКУ СЕТЕВЫХ ПАКЕТОВ
echo [+] Снижает нагрузку на процессор
echo [+] Увеличивает пропускную способность
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Может вызывать проблемы на некоторых сетевых картах
echo [-] Редко, но бывают ошибки контрольных сумм
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] На современных сетевых картах - ОБЯЗАТЕЛЬНО включить
echo [2] При проблемах с сетью - отключить (значение 0)
echo [3] Значение 3 - максимальное аппаратное ускорение
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

for /f %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr "HKEY"') do (
    for /f %%i in ('reg query "%%a" /v "*TCPChecksumOffloadIPv4" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*TCPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*TCPChecksumOffloadIPv6" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*TCPChecksumOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*TCPConnectionOffloadIPv4" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*TCPConnectionOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*TCPConnectionOffloadIPv6" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*TCPConnectionOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*TCPUDPChecksumOffloadIPv4" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*TCPUDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*TCPUDPChecksumOffloadIPv6" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*TCPUDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*UDPChecksumOffloadIPv4" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*UDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    for /f %%i in ('reg query "%%a" /v "*UDPChecksumOffloadIPv6" ^| findstr "HKEY"') do Reg.exe add "%%i" /v "*UDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
)

echo.
echo ================================================================================
echo                 ГОТОВО! OFFLOAD TCP/UDP НАСТРОЕН
echo ================================================================================

echo.