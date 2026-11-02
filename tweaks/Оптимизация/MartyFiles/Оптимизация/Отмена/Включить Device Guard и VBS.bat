@echo off
for %%p in (EnableVirtualizationBasedSecurity HVCIMATRequired) do reg delete "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "%%p" /f >nul 2>&1
for %%p in (Enabled HVCIMATRequired Locked) do reg delete "HKLM\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "%%p" /f >nul 2>&1
for %%p in (EnableVirtualizationBasedSecurity RequirePlatformSecurityFeatures Locked) do reg delete "HKLM\System\CurrentControlSet\Control\DeviceGuard" /v "%%p" /f >nul 2>&1
for %%p in (Enabled AuditModeEnabled WasEnabledBy) do reg delete "HKLM\System\CurrentControlSet\Control\DeviceGuard\Scenarios\KernelShadowStacks" /v "%%p" /f >nul 2>&1
