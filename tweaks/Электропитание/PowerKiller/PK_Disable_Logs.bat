@echo off
chcp 65001 >nul
title PK: Журналы
echo [!] Отключение журналов SleepStudy / Kernel-Processor-Power / UserModePowerService...
wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:false >nul 2>&1
echo [OK] Журналы отключены.
pause
