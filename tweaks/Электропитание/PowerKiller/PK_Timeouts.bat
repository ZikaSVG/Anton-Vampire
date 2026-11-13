@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title VampireOS — PK: Timeouts (AC/DC)
cd /d "%~dp0"

net session >nul 2>&1 || ( echo [!] Запустите от администратора. & pause & exit /b 1 )

echo ============================================================
echo  VampireOS — PK: Timeouts (AC/DC)
echo ============================================================
echo.
rem --- Таймауты «никогда» (AC + DC) ---
echo [*] Таймауты: monitor/disk/standby/hibernate = 0...
powercfg /x monitor-timeout-ac 0 >nul 2>&1
powercfg /x monitor-timeout-dc 0 >nul 2>&1
powercfg /x disk-timeout-ac 0    >nul 2>&1
powercfg /x disk-timeout-dc 0    >nul 2>&1
powercfg /x standby-timeout-ac 0 >nul 2>&1
powercfg /x standby-timeout-dc 0 >nul 2>&1
powercfg /x hibernate-timeout-ac 0 >nul 2>&1
powercfg /x hibernate-timeout-dc 0 >nul 2>&1

rem --- Гибернация off + Fast Startup off ---
echo [*] Гибернация и Fast Startup off...
powercfg /h off >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f >nul 2>&1

rem --- WaitToKillServiceTimeout ---
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 1500 /f >nul 2>&1

echo.
echo ============================================================
echo  Готово: Таймауты отключены, гибернация и Fast Startup выключены.
echo ============================================================
echo.
