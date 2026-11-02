@echo off
for %%k in (Directory.Audio Directory.Image Directory.Video) do (for %%c in (Enqueue Play) do (reg delete "HKCR\SystemFileAssociations\%%k\shell\%%c" /v "LegacyDisable" /f >nul)) >nul 2>&1
