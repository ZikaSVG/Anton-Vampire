@echo off
@echo.
@echo made by FrazE- for Reborn PC Optimization - https://discord.gg/hgBQRsrDRu
@echo.
rem Включение и запуск Центра обновления Windows
sc config wuauserv start= auto
sc start wuauserv
rem Включение и запуск Центра обеспечения безопасности
sc config wscsvc start= auto
sc start wscsvc
rem Включение и запуск Службы Безопасность Windows
sc config WinDefend start= auto
sc start WinDefend
rem Включение и запуск Службы Оркестратора обновлений (Update Orchestrator Service)
sc config UsoSvc start= auto
sc start UsoSvc
@echo.
@echo Completed
@echo.