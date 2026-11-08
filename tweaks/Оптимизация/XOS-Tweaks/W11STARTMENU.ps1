# W11STARTMENU.ps1
# Очистка Start Menu Windows 11
$ErrorActionPreference = 'SilentlyContinue'

$build = [int](Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuildNumber
if ($build -lt 22000) {
    Write-Host 'SKIP: not Windows 11'
    exit 0
}

# Очистить Start Menu Experience Host
Get-ChildItem 'C:\Users\*\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy' -EA 0 | ForEach-Object {
    $ts = Join-Path $_.FullName 'TempState'
    $ls = Join-Path $_.FullName 'LocalState'
    if (Test-Path $ts) { Get-ChildItem $ts -Force -EA 0 | Remove-Item -Recurse -Force -EA 0 }
    if (Test-Path $ls) { Get-ChildItem $ls -Filter 'start*.bin' -Force -EA 0 | Remove-Item -Force -EA 0 }
}

# Отключить рекомендуемое в Start
Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_IrisRecommendations' -Value 0 -Type DWord -Force -EA 0
Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowRecommendations' -Value 0 -Type DWord -Force -EA 0

# Отключить "Рекомендуемые" из Start (Win11 24H2+)
$id = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $id -Name 'Start_AccountNotifications' -Value 0 -Type DWord -Force -EA 0

Write-Host 'W11 STARTMENU cleanup done'
