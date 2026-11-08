@echo off
chcp 65001 >nul
echo Установка ограничения фонового ввода мыши на 50 Гц...
reg add "HKCU\Control Panel\Mouse" /v RawMouseThrottleEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Mouse" /v RawMouseThrottleDuration /t REG_DWORD /d 20 /f
echo Готово. Значение изменено.
pause