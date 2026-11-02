@echo off
chcp 65001 >nul
title Сброс BCD таймеров
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
bcdedit /deletevalue useplatformclock   >nul 2>&1
bcdedit /deletevalue tscsyncpolicy      >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
bcdedit /deletevalue useplatformtick    >nul 2>&1
echo Готово. Синтетические таймеры удалены.
echo Требуется перезагрузка.