@echo off
for %%p in (Documents Downloads FileExplorer HomeGroup Music Network PersonalFolder Pictures Settings Videos) do (
    reg delete "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v "AllowPinnedFolder%%p" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v "AllowPinnedFolder%%p_ProviderSet" /f >nul 2>&1
)
