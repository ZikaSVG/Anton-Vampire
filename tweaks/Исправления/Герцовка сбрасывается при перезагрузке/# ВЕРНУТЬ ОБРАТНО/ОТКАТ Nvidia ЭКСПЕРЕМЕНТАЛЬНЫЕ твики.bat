@echo off
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu

rem ## Восстановление настроек HDCP ##
rem Восстановление значений, связанных с HDCP (если они были удалены)
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /f

rem ## Восстановление TDR (Timeout Detection and Recovery) ##
rem Восстановление всех значений TDR в реестре (удаление тех, что были изменены)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d "3" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d "2" /f
rem Удаляем все параметры, которые могли быть изменены в TDR
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDebugMode" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLimitCount" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLimitTime" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrTestMode" /f

rem ## Восстановление настроек Low Latency ##
rem Удаляем нестандартные значения, которые могли быть добавлены для Low Latency
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "LOWLATENCY" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "Node3DLowLatency" /f

rem ## Восстановление PowerMizer ##
rem Восстанавливаем стандартные настройки PowerMizer
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "PowerMizerEnable" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "PowerMizerLevel" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "PowerMizerLevelAC" /t REG_DWORD /d "1" /f

rem ## Отключение модификаций таймингов ##
rem Удаление параметров, связанных с таймингами
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "PciLatencyTimerControl" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "D3PCLatency" /f

rem ## Восстановление стандартных задач NVIDIA Telemetry ##
rem Проверка и включение необходимых задач, если они были отключены
schtasks /change /enable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /enable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /enable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /enable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /enable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /enable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /enable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"

rem ## Восстановление иконки в трее NVIDIA ##
rem Восстановление значений для запуска иконки в трее
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\NVIDIA Corporation\NvTray" /v StartOnLogin /t REG_DWORD /d 1 /f

rem ## Восстановление параметров реестра для драйвера NVIDIA ##
rem Удаляем нестандартные записи, которые могут быть изменены для оптимизации
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RmGpsPsEnablePerCpuCoreDpc" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\NVAPI" /v "RmGpsPsEnablePerCpuCoreDpc" /f

rem ## Включение NVIDIA Compute Preemption ##
rem Включаем функцию Compute Preemption
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "ComputePreemption" /t REG_DWORD /d "1" /f

rem ## Восстановление настроек "Advanced 3D Settings" ##
rem Удаляем все нестандартные параметры для графики
REG DELETE "HKEY_CURRENT_USER\Software\NVIDIA Corporation\Global\NVTweak" /v Gestalt /f

rem ## Удаление нестандартных параметров драйвера NVIDIA ##
rem Удаляем все нестандартные параметры, добавленные для драйвера
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /f

@echo Completed.
@pause
