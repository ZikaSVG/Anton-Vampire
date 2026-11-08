# W10STARTMENU.ps1
# Очистка плиток Start Menu (Windows 10)
$ErrorActionPreference = 'SilentlyContinue'

$build = [int](Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuildNumber
if ($build -gt 19045) {
    Write-Host 'SKIP: not Windows 10'
    exit 0
}

# Очистить TileDataLayer
Get-ChildItem 'C:\Users\*\AppData\Local\TileDataLayer\Database' -Force -EA 0 | Remove-Item -Recurse -Force -EA 0

# Сбросить layout через default
Get-ChildItem 'C:\Users\*\AppData\Local\Microsoft\Windows\Shell' -Force -EA 0 |
    Where-Object { $_.Name -like 'DefaultLayouts.xml' -or $_.Name -like 'LayoutModification.xml' } |
    Remove-Item -Force -EA 0

# Отключить Suggested Apps в Start
Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SystemPaneSuggestionsEnabled' -Value 0 -Type DWord -Force -EA 0
Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SilentInstalledAppsEnabled' -Value 0 -Type DWord -Force -EA 0

Write-Host 'W10 STARTMENU cleanup done'
