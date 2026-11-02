@echo off
chcp 65001 >nul

echo ================================================================================
echo              xOS PLAYBOOK - ОТКЛЮЧЕНИЕ PCI EXPRESS LINK STATE
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Отключает энергосбережение PCI Express (ASPM - Active State Power Management).
echo Видеокарта и другие PCIe устройства всегда работают на полной скорости.
echo Отключает холодное состояние D3 для PCI устройств.
echo PCI устройства не будут полностью отключаться.
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] Видеокарта не снижает скорость шины в простое
echo [+] Убирает микро-задержки в играх
echo [+] Полезно для NVMe SSD (меньше задержек)
echo [+] PCI устройства всегда готовы к работе
echo [+] Видеокарта просыпается мгновенно
echo [+] Убирает задержки при обращении к PCI устройствам
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Увеличивается энергопотребление PCIe устройств
echo [-] Увеличивает энергопотребление в простое
echo [-] На ноутбуках быстрее садится батарея
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] Десктопы - рекомендуется для максимальной производительности
echo [2] Ноутбуки - только при игре от сети
echo [3] Если проблемы с пробуждением видеокарты - обязательно
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\f7277c87-9043-4248-9e8d-db20e412c751" /v "Attributes" /t REG_DWORD /d 2 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 f7277c87-9043-4248-9e8d-db20e412c751 0
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 f7277c87-9043-4248-9e8d-db20e412c751 0

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\df142941-20f1-4cc0-928d-fde8c3378dce" /v "Attributes" /t REG_DWORD /d 2 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 df142941-20f1-4cc0-928d-fde8c3378dce 0
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 df142941-20f1-4cc0-928d-fde8c3378dce 0

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\a55612aa-f624-42c6-a443-7397d064c04f" /v "Attributes" /t REG_DWORD /d 2 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 a55612aa-f624-42c6-a443-7397d064c04f 0
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 a55612aa-f624-42c6-a443-7397d064c04f 0

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\2430ab6f-a520-44a2-9601-f7f23b5134b1" /v "Attributes" /t REG_DWORD /d 2 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 2430ab6f-a520-44a2-9601-f7f23b5134b1 0
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 2430ab6f-a520-44a2-9601-f7f23b5134b1 0

powercfg -setactive SCHEME_CURRENT

echo.
echo ================================================================================
echo              ГОТОВО! ЭНЕРГОСБЕРЕЖЕНИЕ PCI EXPRESS ОТКЛЮЧЕНО
echo ================================================================================

echo.