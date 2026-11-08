@echo off
for %%p in (HypervisorEnforcedCodeIntegrity LsaCfgFlags RequirePlatformSecurityFeatures ConfigureSystemGuardLaunch ConfigureKernelShadowStacksLaunch) do reg delete "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "%%p" /f >nul 2>&1
for %%p in (EnableVirtualizationBasedSecurity HVCIMATRequired) do reg add "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "%%p" /t reg_dword /d 0 /f >nul 2>&1
for %%p in (WasEnabledBy WasEnabledBySysprep) do reg delete "HKLM\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "%%p" /f >nul 2>&1
for %%p in (Enabled HVCIMATRequired Locked) do reg add "HKLM\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "%%p" /t reg_dword /d 0 /f >nul 2>&1
for %%p in (EnableVirtualizationBasedSecurity RequirePlatformSecurityFeatures Locked) do reg add "HKLM\System\CurrentControlSet\Control\DeviceGuard" /v "%%p" /t reg_dword /d 0 /f >nul 2>&1
for %%p in (Enabled AuditModeEnabled WasEnabledBy) do reg add "HKLM\System\CurrentControlSet\Control\DeviceGuard\Scenarios\KernelShadowStacks" /v "%%p" /t reg_dword /d 0 /f >nul 2>&1
