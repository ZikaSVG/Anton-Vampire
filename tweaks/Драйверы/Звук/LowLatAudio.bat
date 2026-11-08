mkdir %SYSTEMDRIVE%\LowLat\Resources
cd %SYSTEMDRIVE%\LowLat\Resources
curl -g -L -# -o "%SYSTEMDRIVE%\LowLat\Resources\nssm.exe" "https://github.com/kirumipat/skripts/releases/download/0.0.1/nssm.exe"
curl -g -L -# -o "%SYSTEMDRIVE%\LowLat\Resources\REAL.exe" "https://github.com/kirumipat/skripts/releases/download/0.0.1/REAL.exe"
nssm install LowLatAudio "%SYSTEMDRIVE%\LowLat\Resources\REAL.exe"
nssm set LowLatAudio DisplayName LowLat Audio Latency Reducer Service
nssm set LowLatAudio Description Reduces Audio Latency
nssm set LowLatAudio Start SERVICE_AUTO_START
nssm set LowLatAudio AppAffinity 1
nssm set LowLatAudio start SERVICE_AUTO_START
nssm start LowLatAudio