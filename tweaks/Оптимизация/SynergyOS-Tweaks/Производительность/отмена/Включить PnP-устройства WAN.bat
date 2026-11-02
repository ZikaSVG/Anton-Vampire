@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить PnP-устройства WAN

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить PnP-устройства WAN
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$devices=@('WAN Miniport (IKEv2)','WAN Miniport (IP)','WAN Miniport (IPv6)','WAN Miniport (L2TP)','WAN Miniport (Network Monitor)','WAN Miniport (PPPOE)','WAN Miniport (PPTP)','WAN Miniport (SSTP)','Composite Bus Enumerator','NDIS Virtual Network Adapter Enumerator','Microsoft GS Wavetable Synth','Microsoft Virtual Drive Enumerato');" ^
  "Get-PnpDevice -FriendlyName $devices -ErrorAction Ignore | Enable-PnpDevice -Confirm:$false -ErrorAction Ignore" >nul 2>&1

echo.
echo [OK] Отменено: Включить PnP-устройства WAN
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
