@echo off
chcp 65001 >nul
title Фикс Valorant (CFG)
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)

echo Включение CFG для системы...
:: Set-ProcessMitigation -System требует контекст SYSTEM (не просто админ).
:: Проверяем, получилось ли, и не прячем ошибку.
powershell -NoProfile -Command "try { Set-ProcessMitigation -System -Enable CFG; exit 0 } catch { Write-Host $_.Exception.Message; exit 1 }"
if errorlevel 1 (
    echo.
    echo [!] Не удалось применить CFG через PowerShell.
    echo     Требуется запуск от SYSTEM (например: psexec -s -i cmd).
    echo     Альтернатива: включить CFG вручную в "Изоляция ядра" / "Защита от эксплойтов".
) else (
    echo CFG успешно включён.
)

:: Дублирующая страховка через реестр
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d 1 /f >nul 2>&1

echo Готово. Требуется перезагрузка.