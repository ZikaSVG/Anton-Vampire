@echo off
chcp 65001 >nul
title Журнал BSOD
echo ============================================================
echo   BSOD / КРИТИЧЕСКИЕ ОШИБКИ ЯДРА
echo ============================================================
echo.

echo --- Дампы памяти (Minidump) ---
if exist "%systemroot%\Minidump\*.dmp" (
    dir /b /o-d "%systemroot%\Minidump\*.dmp"
) else (
    echo Minidump пуст или отсутствует.
)
echo.

echo --- Kernel-Power (Event ID 41, неожиданные перезагрузки) ---
wevtutil qe System /c:5 /f:text /q:"*[System[Provider[@Name='Microsoft-Windows-Kernel-Power'] and (EventID=41)]]" 2>nul
echo.

echo --- WER-SystemErrorReporting (BugCheck) ---
wevtutil qe System /c:5 /f:text /q:"*[System[Provider[@Name='Microsoft-Windows-WER-SystemErrorReporting']]]" 2>nul
echo.

echo --- Последние 5 критических событий (Level 1-2) ---
wevtutil qe System /c:5 /f:text /q:"*[System[(Level=1 or Level=2)]]" 2>nul
echo ------------------------------------------------------------