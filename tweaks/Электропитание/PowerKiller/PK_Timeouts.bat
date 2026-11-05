@echo off
chcp 65001 >nul
title PK: Таймауты
echo [!] Отключение таймаутов AC и DC...
powercfg /x monitor-timeout-ac 0 >nul 2>&1
powercfg /x disk-timeout-ac 0 >nul 2>&1
powercfg /x standby-timeout-ac 0 >nul 2>&1
powercfg /x hibernate-timeout-ac 0 >nul 2>&1
powercfg /x monitor-timeout-dc 0 >nul 2>&1
powercfg /x disk-timeout-dc 0 >nul 2>&1
powercfg /x standby-timeout-dc 0 >nul 2>&1
powercfg /x hibernate-timeout-dc 0 >nul 2>&1
echo [OK] Таймауты отключены.
pause
