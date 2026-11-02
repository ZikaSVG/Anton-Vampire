@echo off
title Защита SMB
powershell -NoProfile -Command "Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force"
powershell -NoProfile -Command "Set-SmbServerConfiguration -RequireSecuritySignature $true -Force"
powershell -NoProfile -Command "Set-SmbClientConfiguration -RequireSecuritySignature $true -Force"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v RestrictNullSessAccess /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v AllowInsecureGuestAuth /t REG_DWORD /d 0 /f
echo [+] SMB защищён.