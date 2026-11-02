@echo off
netsh int ip reset >nul
netsh interface ipv4 reset >nul
netsh interface ipv6 reset >nul
netsh interface tcp reset >nul
netsh winsock reset >nul
powershell -NonI -NoP -C "foreach ($dev in Get-PnpDevice -Class Net -Status 'OK') { pnputil /remove-device $dev.InstanceId }" >nul
pnputil /scan-devices >nul
