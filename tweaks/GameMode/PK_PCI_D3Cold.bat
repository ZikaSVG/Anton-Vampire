@echo off
chcp 65001 >nul
echo [PK] Отключение PCI D3Cold...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupport /t REG_DWORD /d 0 /f >nul 2>&1
echo [OK] PCI D3Cold отключен.
