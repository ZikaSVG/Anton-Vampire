@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul

rem ============================================================
rem  Резервный вариант: включает ВСЕ службы из списка (Start=3 = Manual).
rem  Используется, когда бэкапа нет — старое поведение отката.
rem  ВНИМАНИЕ: включит и те службы, что были отключены ДО Game Mode.
rem ============================================================

net session >nul 2>&1 || (echo [!] Запустите от администратора. & pause & exit /b 1)

set "LIST_FILE=%~dp0services.txt"
if not exist "%LIST_FILE%" (echo [ОШИБКА] Не найден "%LIST_FILE%" & pause & exit /b 1)

echo Включение служб (Start=3)...
set "COUNT=0"
for /f "usebackq eol=# delims=" %%S in ("%LIST_FILE%") do (
    if not "%%S"=="" (
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
        if not errorlevel 1 set /a COUNT+=1
    )
)
echo.
echo [OK] Обработано служб: %COUNT%
echo [ВНИМАНИЕ] Службы, которые вы отключали сами до Game Mode, тоже включены.
endlocal