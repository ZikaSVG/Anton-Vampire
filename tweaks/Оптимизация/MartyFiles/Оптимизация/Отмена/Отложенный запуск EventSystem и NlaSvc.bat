@echo off
for %%p in (EventSystem NlaSvc) do reg add "HKLM\System\CurrentControlSet\Services\%%p" /v "DelayedAutostart" /t reg_dword /d 0 /f >nul 2>&1
