@echo off
chcp 65001 >nul
echo Очистка Temp драйверов...
del /f /s /q "%windir%\System32\DriverStore\Temp\*.*" >nul 2>&1
del /f /s /q "%windir%\SysWOW64\DriverStore\Temp\*.*" >nul 2>&1
del /f /s /q "%windir%\System32\Macromed\Temp\*.*"    >nul 2>&1
del /f /s /q "%windir%\SysWOW64\Macromed\Temp\*.*"    >nul 2>&1
echo Готово.
