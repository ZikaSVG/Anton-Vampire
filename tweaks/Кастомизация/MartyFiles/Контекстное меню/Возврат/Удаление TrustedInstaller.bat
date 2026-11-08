@echo off
chcp 65001 >nul
title xOS PLAYBOOK - Удаление RunAs TrustedInstaller из контекстного меню
color 0E

echo ================================================================================
echo              xOS PLAYBOOK - УДАЛЕНИЕ RUN AS TRUSTEDINSTALLER
echo                        ИЗ КОНТЕКСТНОГО МЕНЮ WINDOWS
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт УДАЛЯЕТ пункт "Run as TrustedInstaller" из контекстного меню
echo для всех типов файлов:
echo.
echo   - .bat и .cmd (пакетные файлы)
echo   - .exe (исполняемые файлы)
echo   - .msc (консоли управления)
echo   - .ps1 (PowerShell скрипты)
echo   - .reg (файлы реестра)
echo   - Папки (Folders)
echo.
echo Также удаляется вспомогательная функция RunAsTI из реестра.
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] Возвращает контекстное меню к стандартному виду
echo [+] Устраняет риск случайного запуска файлов с максимальными правами
echo [+] Повышает безопасность системы (особенно на чужих ПК)
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Теряется возможность быстрого запуска от TrustedInstaller
echo [-] Придется использовать альтернативные методы (PowerRun, NSudo)
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте если больше не нужен быстрый доступ к TrustedInstaller
echo [2] Рекомендуется для ноутбуков и корпоративных ПК
echo [3] После удаления перезапустите Проводник или перезагрузитесь
echo [4] При желании пункты можно вернуть - импортируйте REG-файл снова
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

:: Удаление для .bat файлов
echo   Удаляю для .bat...
reg delete "HKCR\batfile\shell\setdesktopwallpaper" /f >nul 2>&1

:: Удаление для .cmd файлов
echo   Удаляю для .cmd...
reg delete "HKCR\cmdfile\shell\setdesktopwallpaper" /f >nul 2>&1

:: Удаление для .exe файлов
echo   Удаляю для .exe...
reg delete "HKCR\exefile\shell\setdesktopwallpaper" /f >nul 2>&1

:: Удаление для .msc файлов
echo   Удаляю для .msc...
reg delete "HKCR\mscfile\shell\setdesktopwallpaper" /f >nul 2>&1

:: Удаление для .ps1 файлов
echo   Удаляю для .ps1...
reg delete "HKCR\Microsoft.PowerShellScript.1\shell\setdesktopwallpaper" /f >nul 2>&1

:: Удаление для .reg файлов
echo   Удаляю для .reg...
reg delete "HKCR\regfile\shell\setdesktopwallpaper" /f >nul 2>&1

:: Удаление для папок
echo   Удаляю для папок...
reg delete "HKCR\Folder\shell\setdesktopwallpaper" /f >nul 2>&1

:: Удаление вспомогательной функции RunAsTI
echo   Удаляю вспомогательную функцию RunAsTI...
reg delete "HKCR\RunAsTI" /f >nul 2>&1

echo ================================================================================
echo                  ГОТОВО! ПУНКТЫ TRUSTEDINSTALLER УДАЛЕНЫ
echo ================================================================================
echo.
echo Что удалено из контекстного меню:
echo.
echo   - .bat / .cmd    -> Run as TrustedInstaller (УДАЛЕН)
echo   - .exe           -> Run as TrustedInstaller (УДАЛЕН)
echo   - .msc           -> Run as TrustedInstaller (УДАЛЕН)
echo   - .ps1           -> Run as TrustedInstaller (УДАЛЕН)
echo   - .reg           -> Import as TrustedInstaller (УДАЛЕН)
echo   - Папки          -> Open as TrustedInstaller (УДАЛЕН)
echo.
echo Контекстное меню возвращено к стандартному виду Windows.
echo Для повторного добавления пунктов импортируйте REG-файл снова.
echo.
echo ================================================================================
echo.