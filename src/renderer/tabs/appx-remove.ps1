# appx-remove.ps1
# Удаляет один Appx по PackageFullName.

param(
    [Parameter(Mandatory=$true)][string]$PackageFullName,
    [string]$DisplayName = ''
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = 'SilentlyContinue'

try {
    Remove-AppxPackage -Package $PackageFullName -AllUsers -ErrorAction SilentlyContinue
    Remove-AppxPackage -Package $PackageFullName -ErrorAction SilentlyContinue
    [Console]::Out.Write('OK')
} catch {
    [Console]::Out.Write('ERR:' + $_.Exception.Message)
}