@echo off
title Анонимный SMB
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v RestrictNullSessAccess /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v AllowInsecureGuestAuth /t REG_DWORD /d 0 /f
echo [+] Анонимный SMB запрещён.
