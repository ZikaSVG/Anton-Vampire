@echo off
:: Отключение служб, указанных в конфигурации
:: Службы, для которых в файле задан запуск "4" (Disabled)

:: Отключить драйвер модератора активности рабочего стола
:: dam (Desktop Activity Moderator Driver) — драйвер, отвечающий за фоновую активность рабочего стола.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dam" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер энергопотребления GPU
:: GpuEnergyDrv (GPU Energy Driver) — драйвер, собирающий данные об энергопотреблении GPU.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить NetBIOS over TCP/IP
:: NetBT (NetBT) — служба поддержки NetBIOS поверх TCP/IP. Может влиять на работу старых сетевых приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу телеметрии Intel
:: Telemetry (Intel(R) Telemetry Service) — служба сбора телеметрии Intel.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Telemetry" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сбора диагностических данных
:: diagnosticshub.standardcollector.service (Microsoft (R) Diagnostics Hub Standard Collector Service) — служба сбора диагностической информации.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу отчетов об ошибках Windows
:: WerSvc (Windows Error Reporting Service) — служба отправки отчетов об ошибках в Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу телеметрии Windows
:: DiagTrack (Unified Telemetry Client) — служба сбора телеметрии и диагностических данных.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу программы предварительной оценки Windows
:: wisvc (Windows Insider Service) — служба, обеспечивающая участие в программе Windows Insider.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу помощника по совместимости программ
:: PcaSvc (Program Compatibility Assistant Service) — служба, проверяющая совместимость приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить хост диагностических служб
:: WdiServiceHost (Diagnostic Service Host) — служба, запускающая диагностические сценарии.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить системный хост диагностики
:: WdiSystemHost (Diagnostic System Host) — системная служба диагностики.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер регистрации TCP/IP
:: tcpipreg (Tcpipreg) — драйвер регистрации TCP/IP (экспериментально).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\tcpipreg" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сбора событий Windows
:: Wecsvc (Windows Event Collector) — служба сбора событий с других компьютеров.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу UCPD velocity
:: UCPD (UCPD velocity) — служба защиты пользовательских ассоциаций (User Choice Protection Driver).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UCPD" /v "Start" /t REG_DWORD /d "4" /f

echo.
echo Готово. Все указанные службы отключены.
pause