@echo off
title LSA Protection
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RunAsPPL /t REG_DWORD /d 1 /f
echo [+] LSA Protection включён. Требуется перезагрузка.