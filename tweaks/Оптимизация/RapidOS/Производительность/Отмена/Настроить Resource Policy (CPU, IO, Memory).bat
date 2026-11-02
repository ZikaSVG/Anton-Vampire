@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\HardCap0" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\Paused" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapFull" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapLow" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\IO\NoCap" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Memory\NoCap" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
