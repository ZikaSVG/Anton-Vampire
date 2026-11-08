@echo off
chcp 65001 >nul
echo Очистка корзины на всех дисках...
rd /s /q "%systemdrive%\$Recycle.bin" >nul 2>&1
for %%D in (D E F G H) do (
    if exist "%%D:\$Recycle.bin" rd /s /q "%%D:\$Recycle.bin" >nul 2>&1
)
echo Готово.
