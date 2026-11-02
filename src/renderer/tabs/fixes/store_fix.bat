@echo off
chcp 65001 >nul
title Сброс Microsoft Store
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
echo Перезапуск служб Store...
sc config AppXSvc       start= demand >nul 2>&1
sc config ClipSVC       start= demand >nul 2>&1
sc config wlidsvc       start= demand >nul 2>&1
sc config LicenseManager start= demand >nul 2>&1

echo Очистка кэша Store...
:: wsreset -i работает только в интерактивной сессии пользователя.
:: Если запущено из-под админа — может не сработать; тогда используйте wsreset.exe без параметров.
wsreset.exe -i >nul 2>&1
if errorlevel 1 (
    echo [!] wsreset -i не сработал (нужна активная сессия пользователя).
    echo     Запустите wsreset.exe вручную из меню Пуск.
)

echo Готово.