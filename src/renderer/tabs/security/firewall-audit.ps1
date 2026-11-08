[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = 'SilentlyContinue'

function New-Check {
    param([string]$Name, [string]$Result, [string]$Expected, [string]$Severity)
    Write-Output "ITEM|$Name|$Result|$Expected|$Severity"
}

$checks = @()

# Проверка состояния профилей брандмауэра
try {
    $profiles = Get-NetFirewallProfile -ErrorAction Stop
    
    foreach ($profile in $profiles) {
        $status = if ($profile.Enabled) { "Включён" } else { "Выключен" }
        $expected = "Включён"
        $severity = if ($profile.Enabled) { "Passed" } else { "Medium" }
        $checks += (New-Check "Брандмауэр - $($profile.Name)" $status $expected $severity)
    }
} catch {
    $checks += (New-Check "Брандмауэр - получение статуса" "Ошибка: $_" "Успешно" "High")
}

# Проверка правил для входящих подключений
try {
    $inboundRules = Get-NetFirewallRule -Direction Inbound -Enabled True -ErrorAction SilentlyContinue | Measure-Object
    $checks += (New-Check "Активные правила (входящие)" "$($inboundRules.Count)" "> 0" "Passed")
} catch {
    $checks += (New-Check "Активные правила (входящие)" "Ошибка" "> 0" "Low")
}

# Проверка правил для исходящих подключений
try {
    $outboundRules = Get-NetFirewallRule -Direction Outbound -Enabled True -ErrorAction SilentlyContinue | Measure-Object
    $checks += (New-Check "Активные правила (исходящие)" "$($outboundRules.Count)" "> 0" "Passed")
} catch {
    $checks += (New-Check "Активные правила (исходящие)" "Ошибка" "> 0" "Low")
}

# Проверка блокировки входящих по умолчанию
try {
    $domainProfile = Get-NetFirewallProfile -Name Domain -ErrorAction Stop
    $defaultInbound = $domainProfile.DefaultInboundAction
    $expected = "Block"
    $severity = if ($defaultInbound -eq "Block") { "Passed" } else { "Medium" }
    $checks += (New-Check "Блокировка входящих (Domain)" $defaultInbound $expected $severity)
} catch {
    $checks += (New-Check "Блокировка входящих (Domain)" "Ошибка" "Block" "Low")
}

# Вывод результатов
Write-Output "BEGIN|FIREWALL_AUDIT"
foreach ($check in $checks) {
    Write-Output $check
}
Write-Output "END|FIREWALL_AUDIT"