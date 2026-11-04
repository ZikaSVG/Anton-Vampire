@echo off
chcp 65001 >nul
echo Отключение ограничения фонового ввода...
reg add "HKCU\Control Panel\Mouse" /v RawMouseThrottleEnabled /t REG_DWORD /d 0 /f
echo Готово.
pause