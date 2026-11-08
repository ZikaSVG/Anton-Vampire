@echo off
chcp 65001 >nul
echo Очистка журналов событий Windows...
for /F "tokens=*" %%G in ('wevtutil.exe el') do (
    wevtutil.exe cl "%%G" >nul 2>&1
)
echo Готово.
