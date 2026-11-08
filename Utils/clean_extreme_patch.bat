@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистка осиротевших _extreme_patch_* файлов

rem ============================================================================
rem  Удаляет рекурсивно все файлы, начинающиеся на _extreme_patch_,
rem  из папок src, tweaks (рядом с батником) и %TEMP% (fallback в tweak-runner).
rem
rem  ВАЖНО:
rem   1) Рекурсию делает "dir /b /s /a-d", а НЕ "for /r" — for /r не всегда
rem      видит кириллические подпапки (например tweaks\Службы\).
rem   2) Пропускаем %~f0 — если TweakRunner запустил патченную копию
rem      (_extreme_patch_clean_extreme_patch_*.bat), не удаляем её сами:
rem      это сделает _scheduleTempCleanup() после завершения процесса.
rem ============================================================================

rem dir /b /s "%CD%\_extreme_patch_*"

set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"

set "TARGET_PREFIX=_extreme_patch_"
set "TOTAL=0"
set "FAILED=0"
set "SKIPPED=0"
set "SELF=%~f0"

echo [*] Корень: %ROOT%
echo [*] Ищу файлы "%TARGET_PREFIX%*" ...
echo.

for %%D in ("%ROOT%\src" "%ROOT%\tweaks" "%TEMP%") do (
    if exist "%%~D" (
        echo  ── сканирую: %%~D
        for /f "delims=" %%F in ('dir /b /s /a-d "%%~D\%TARGET_PREFIX%*" 2^>nul') do (
            call :process_file "%%F"
        )
    )
)

echo.
if !FAILED! GTR 0 (
    echo [WARN] Удалено: !TOTAL!, не удалось: !FAILED!, пропущено: !SKIPPED!
    exit /b 2
)
if !TOTAL! EQU 0 (
    echo [OK] Осиротевших файлов не найдено — чисто.
) else (
    echo [OK] Удалено файлов: !TOTAL!
)
exit /b 0

:process_file
setlocal DisableDelayedExpansion
set "FILE=%~1"
if /i "%FILE%"=="%SELF%" (
    echo    [SKIP] текущий запущенный файл: %FILE%
    endlocal
    exit /b 0
)
attrib -h -s -r "%FILE%" >nul 2>&1
del /f /q "%FILE%" >nul 2>&1
if not exist "%FILE%" (
    echo    [OK] %FILE%
    endlocal & set /a TOTAL+=1
) else (
    echo    [!] не удалось: %FILE%
    endlocal & set /a FAILED+=1
)
exit /b 0