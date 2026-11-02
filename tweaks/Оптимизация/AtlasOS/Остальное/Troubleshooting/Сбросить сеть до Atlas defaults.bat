@echo off
powershell -NonI -NoP -C "foreach ($dev in Get-PnpDevice -Class Net -Status 'OK') { pnputil /remove-device $dev.InstanceId }" >nul
pnputil /scan-devices >nul
