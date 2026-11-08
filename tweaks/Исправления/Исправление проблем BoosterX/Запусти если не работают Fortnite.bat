:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: Начиная с этой секции, компиляция данных - закомментированные строки, которые служат для 
:: информирования о неверных данных в реестре для настройки параметров мыши.
:: Эти строки не будут выполняться, поскольку они начинаются с ::, 
:: но служат для понимания того, какие значения могут быть неправильными.
:: Значения SmoothMouseXCurve и SmoothMouseYCurve в реестре, которые могут указывать на настройки движения мыши.
:: Например, SmoothMouseXCurve - это кривая для сглаживания перемещения мыши по оси X.
:: Включают набор hex значений, которые могут представлять чувствительность мыши и другие параметры.
:: Пример в комментарии:
:: HKEY_CURRENT_USER\Control Panel\Mouse --> SmoothMouseXCurve"=hex:\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,00,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> C0,CC,0C,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 80,99,19,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 40,66,26,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,33,33,00,00,00,00,00
:: HKEY_CURRENT_USER\Control Panel\Mouse --> SmoothMouseYCurve"=hex:\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,00,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,38,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,70,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,A8,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,E0,00,00,00,00,00
:: и так далее
:: ------------------------------------------------------------------------------------------------------------------------------------------------
:: Здесь начинается цикл для обработки элементов, обозначенных в списке.
for %%i in (FortniteClient-Win64) do (
    :: Удаляем настройки QoS (Quality of Service) для клиента Fortnite из реестра Windows.
    :: Строка реестра, которую мы удаляем, содержит параметры, связанные с QoS для самой Fortnite.
    Reg.exe delete "HKLM\Software\Policies\Microsoft\Windows\QoS\%%i" /f
)
:: Удаляем параметры производительности для Fortnite, указывающие Windows использовать опции производительности для Fortnite.
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe\PerfOptions" /f
:: Удаляем значение "UseLargePages" для Fortnite.
:: Это значение отвечает за использование больших страниц памяти, что может влиять на производительность.
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe" /v "UseLargePages" /f
:: Полностью удаляем все параметры выполнения для Fortnite, чтобы сбросить любые нестандартные настройки, которые были сделаны.
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe" /f
:: Удаляем параметры выполнения для игры VALORANT, аналогично тому, как мы удалили их для Fortnite.
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\VALORANT-Win64-Shipping.exe" /f
REM ; Windows_10+8.x_MouseFix_ItemsSize=100%_Scale=1-to-1_@6-of-11
REM Здесь начинается фактический код для изменения настроек мыши в реестре.
REM Добавляет или изменяет значение "MouseSensitivity" в реестре для текущего пользователя (HKCU).
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f
REM Эта команда устанавливает чувствительность мыши на 10. 
REM /t REG_SZ указывает, что тип значения - строка.
REM /f принудительно перезаписывает существующее значение без запроса на подтверждение.
REM Добавляет или изменяет значение "MouseSpeed" для пользователя по умолчанию (HKU\.DEFAULT).
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
REM Устанавливает скорость мыши для пользователя по умолчанию на 0.
REM Добавляет или изменяет значение "MouseThreshold1" для пользователя по умолчанию (HKU\.DEFAULT).
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
REM Устанавливает порог 1 для обработки движения мыши по умолчанию на 0.
REM Добавляет или изменяет значение "MouseThreshold2" для пользователя по умолчанию (HKU\.DEFAULT).
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f
REM Устанавливает порог 2 для обработки движения мыши по умолчанию на 0.
pushd "%~dp0"
REM Команда pushd сохраняет текущую директорию и переходит в директорию, 
REM указанную переменной %~dp0, которая представляет собой путь к текущему скрипту, 
REM что позволяет работать с относительными путями.
copy /V /Y "%~dp0NTX86\1kHz\hidusbf.sys" "%~dp0NTX86\"
REM Копирует файл hidusbf.sys из подкаталога NTX86 текущей директории в тот же подкаталог.
REM /V проверяет, что файл был скопирован правильно.
REM /Y позволяет перезаписывать существующие файлы без запроса.
copy /V /Y "%~dp0AMD64\1kHz\hidusbf.sys" "%~dp0AMD64\"
REM Копирует файл hidusbf.sys из подкаталога AMD64 текущей директории в тот же подкаталог.
REM Как и в предыдущей команде, используется /V и /Y для проверки и перезаписи.
popd
REM Команда popd возвращает в предыдущую директорию, сохраненную командой pushd.
REM Это помогает поддерживать структуру работы в скрипте, возвращаясь обратно после копирования файлов.