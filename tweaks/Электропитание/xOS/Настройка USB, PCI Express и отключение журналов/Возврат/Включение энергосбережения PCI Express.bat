@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ВКЛЮЧЕНИЕ ЭНЕРГОСБЕРЕЖЕНИЯ
echo                         PCI EXPRESS (LINK STATE)
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Включает энергосбережение PCI Express (ASPM - Active State Power Management).
echo PCI устройства могут переходить в энергосберегающие состояния L0s/L1.
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] Экономит энергию PCIe устройств в простое
echo [+] На ноутбуках увеличивает время автономной работы
echo [+] Уменьшает нагрев PCIe устройств
echo [+] Это стандартная настройка Windows
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] Могут быть микро-задержки при выходе из энергосбережения
echo [-] Незначительное снижение производительности в некоторых сценариях
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] На ноутбуках - рекомендуется включить
echo [2] На десктопах с проблемами задержек - можно отключить
echo [3] Это стандартная настройка Windows
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

echo [1/5] Включение ASPM для PCI Express...

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\f7277c87-9043-4248-9e8d-db20e412c751" /v "Attributes" /t REG_DWORD /d 1 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 f7277c87-9043-4248-9e8d-db20e412c751 1
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 f7277c87-9043-4248-9e8d-db20e412c751 1

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\df142941-20f1-4cc0-928d-fde8c3378dce" /v "Attributes" /t REG_DWORD /d 1 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 df142941-20f1-4cc0-928d-fde8c3378dce 1
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 df142941-20f1-4cc0-928d-fde8c3378dce 1

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\a55612aa-f624-42c6-a443-7397d064c04f" /v "Attributes" /t REG_DWORD /d 1 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 a55612aa-f624-42c6-a443-7397d064c04f 1
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 a55612aa-f624-42c6-a443-7397d064c04f 1

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\2430ab6f-a520-44a2-9601-f7f23b5134b1" /v "Attributes" /t REG_DWORD /d 1 /f >nul 2>&1
powercfg -SETACVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 2430ab6f-a520-44a2-9601-f7f23b5134b1 1
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 2430ab6f-a520-44a2-9601-f7f23b5134b1 1

echo [2/2] Применение текущей схемы...
powercfg -setactive SCHEME_CURRENT

echo.
echo ================================================================================
echo               ГОТОВО! ЭНЕРГОСБЕРЕЖЕНИЕ PCI EXPRESS ВКЛЮЧЕНО
echo ================================================================================

echo.