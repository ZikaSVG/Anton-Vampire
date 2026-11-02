@echo off
PowerShell "$key = 'HKLM:\SYSTEM\CurrentControlSet\Control'; if (Get-ItemProperty -Path $key -Name 'SvcHostSplitThresholdInKB_orig' -ErrorAction SilentlyContinue) { Remove-ItemProperty -Path $key -Name 'SvcHostSplitThresholdInKB' -ErrorAction SilentlyContinue; Rename-ItemProperty -Path $key -Name 'SvcHostSplitThresholdInKB_orig' -NewName 'SvcHostSplitThresholdInKB' }"
