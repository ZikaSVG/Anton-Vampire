@echo off
:: Изменение параметров служб согласно services.yml
:: Start: 2 = Automatic, 3 = Manual, 4 = Disabled
:: Запускать от имени администратора.

:: ============================================================
:: Отключение служб (Start = 4 / Disabled)
:: ============================================================

:: Отключить драйвер модератора активности рабочего стола
:: dam (Desktop Activity Moderator Driver) — драйвер фоновой активности рабочего стола.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dam" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер энергопотребления GPU
:: GpuEnergyDrv (GPU Energy Driver) — драйвер сбора данных об энергопотреблении GPU.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить NetBIOS over TCP/IP
:: NetBT (NetBT) — поддержка NetBIOS поверх TCP/IP. Может влиять на старые сетевые приложения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу телеметрии Intel
:: Telemetry (Intel(R) Telemetry Service) — служба телеметрии Intel.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Telemetry" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сбора диагностических данных
:: diagnosticshub.standardcollector.service — Microsoft Diagnostics Hub Standard Collector Service.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу отчетов об ошибках Windows
:: WerSvc (Windows Error Reporting Service) — отправка отчетов об ошибках в Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу телеметрии Windows
:: DiagTrack (Unified Telemetry Client) — сбор телеметрии и диагностических данных.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу программы предварительной оценки Windows
:: wisvc (Windows Insider Service) — участие в программе Windows Insider.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу помощника по совместимости программ
:: PcaSvc (Program Compatibility Assistant Service) — проверка совместимости приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить хост диагностических служб
:: WdiServiceHost (Diagnostic Service Host) — запуск диагностических сценариев.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить системный хост диагностики
:: WdiSystemHost (Diagnostic System Host) — системная диагностика.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер регистрации TCP/IP
:: tcpipreg (Tcpipreg) — драйвер регистрации TCP/IP (экспериментально).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\tcpipreg" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сбора событий Windows
:: Wecsvc (Windows Event Collector) — сбор событий с других компьютеров.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу UCPD velocity
:: UCPD (UCPD velocity) — User Choice Protection Driver.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UCPD" /v "Start" /t REG_DWORD /d "4" /f

:: ============================================================
:: Ручной запуск (Start = 3 / Manual)
:: ============================================================

:: Перевести службу обновления Edge в ручной режим
:: edgeupdate (Microsoft Edge Update) — обновление Edge/WebView2.
:: Manual: не запускается сама, запускается по требованию. Отключение ломает установку WebView2 через Visual Studio.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdate" /v "Start" /t REG_DWORD /d "3" /f

:: ============================================================
:: Автоматический запуск (Start = 2 / Automatic)
:: ============================================================

:: Перевести condrv в автоматический режим
:: condrv (Console Driver) — драйвер консоли.
:: Automatic: запускается при старте Windows. В файле это сделано для исправления ошибки 0xd000003a.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\condrv" /v "Start" /t REG_DWORD /d "2" /f
