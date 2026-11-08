@echo off
for %%k in (Directory.Audio Directory.Image Directory.Video) do (for %%c in (Enqueue Play) do (reg add "HKCR\SystemFileAssociations\%%k\shell\%%c" /v "LegacyDisable" /t REG_SZ /d "" /f >nul)) >nul 2>&1
