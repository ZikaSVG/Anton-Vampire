@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - УДАЛЕНИЕ ВСЕХ ПУНКТОВ ПИТАНИЯ
echo                  ИЗ КОНТЕКСТНОГО МЕНЮ РАБОЧЕГО СТОЛА
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Удаляет из контекстного меню рабочего стола все пункты управления питанием:
echo.
echo   - Power Saver (Экономия энергии)
echo   - Balanced (Сбалансированная)
echo   - High Performance (Высокая производительность)
echo   - XOS Power Plan
echo   - Disable Idle
echo   - Enable Idle
echo   - Power Options
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] Контекстное меню становится чище
echo [+] Убирает лишние пункты для тех, кто не использует их
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Теряется возможность быстрого переключения схем питания
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Запускайте от имени Администратора
echo [2] Запускайте если пункты не нужны или мешают
echo [3] Для возврата используйте скрипт "Добавление всех пунктов питания в контекстное меню.bat"
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ОШИБКА] Запустите от имени Администратора!
    echo.
    exit /b 1
)

echo [1/2] Удаление всех пунктов питания (01menu - 07menu)...
Reg.exe delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\01menu" /f >nul 2>&1
Reg.exe delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\02menu" /f >nul 2>&1
Reg.exe delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\03menu" /f >nul 2>&1
Reg.exe delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\04menu" /f >nul 2>&1
Reg.exe delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /f >nul 2>&1
Reg.exe delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /f >nul 2>&1
Reg.exe delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\07menu" /f >nul 2>&1
echo [OK] Пункты питания удалены
echo.

echo [2/2] Удаление основного меню PowerPlan...
Reg.exe delete "HKCR\DesktopBackground\Shell\PowerPlan" /f >nul 2>&1
echo [OK] Меню PowerPlan удалено
echo.

echo ================================================================================
echo               ГОТОВО! ВСЕ ПУНКТЫ ПИТАНИЯ УДАЛЕНЫ ИЗ КОНТЕКСТНОГО МЕНЮ
echo ================================================================================
echo.
echo Что удалено:
echo   - Power Saver
echo   - Balanced
echo   - High Performance
echo   - XOS Power Plan
echo   - Disable Idle
echo   - Enable Idle
echo   - Power Options
echo.
echo Результат:
echo   - Контекстное меню очищено
echo   - Эффекты от предыдущих настроек сохраняются
echo.
echo Для повторного добавления используйте скрипт "Добавление всех пунктов питания в контекстное меню.bat"
echo.

echo.