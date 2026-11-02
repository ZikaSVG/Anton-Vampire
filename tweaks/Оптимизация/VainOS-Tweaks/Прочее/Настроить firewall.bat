@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить firewall

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить firewall
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg delete "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /f >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v "Block SearchApp" /t REG_SZ /d "v2.32|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%SystemRoot%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe|Name=Block SearchApp|Desc=Block Cortana Outbound UDP/TCP Traffic|" /f >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v "Block SearchHost" /t REG_SZ /d "v2.32|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%SystemRoot%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe|Name=Block SearchHost|Desc=Block Cortana Outbound UDP/TCP Traffic|" /f >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v "Block StartMenuExperienceHost" /t REG_SZ /d "v2.32|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%SystemRoot%\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe|Name=Block StartMenuExperienceHost|Desc=Block Cortana Outbound UDP/TCP Traffic|" /f >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v "Block SystemSettings" /t REG_SZ /d "v2.32|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%SystemRoot%\ImmersiveControlPanel\SystemSettings.exe|Name=Block SystemSettings|Desc=Block Windows Settings Outbound UDP/TCP Traffic|" /f >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v "Block Explorer" /t REG_SZ /d "v2.32|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%SystemRoot%\explorer.exe|Name=Block Explorer|Desc=Block Explorer Outbound UDP/TCP Traffic|" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить firewall
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
