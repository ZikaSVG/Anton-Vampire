@echo off
for %%a in (EnableLUA PromptOnSecureDesktop EnableVirtualization ConsentPromptBehaviorAdmin) do reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "%%a" /t REG_DWORD /d 0 /f >nul
