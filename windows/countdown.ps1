# Writes the number of days until Christmas (local time) to days-until-christmas.txt.
# Run daily at midnight by the scheduled task "Christmas Countdown" (see install.ps1).
# Testing: pass a date to pretend it's that day, e.g. .\countdown.ps1 2026-10-14

param([string]$Date)

$out = Join-Path $PSScriptRoot 'days-until-christmas.txt'

if ($Date) {
    try {
        $today = [datetime]::ParseExact($Date, 'yyyy-MM-dd', [Globalization.CultureInfo]::InvariantCulture)
    } catch {
        Write-Error "Bad date '$Date' - use YYYY-MM-DD."
        exit 1
    }
} else {
    $today = [datetime]::Today
}

# Past Christmas this year? Count to next year's.
$xmas = Get-Date -Year $today.Year -Month 12 -Day 25 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
if ($today -gt $xmas) { $xmas = $xmas.AddYears(1) }

$days = ($xmas.Date - $today.Date).Days

if ($days -eq 0) {
    $msg = "Merry Christmas! It's today."
} elseif ($days -eq 1) {
    $msg = '1 day until Christmas.'
} else {
    $msg = "$days days until Christmas."
}

Set-Content -Path $out -Value $msg -Encoding ASCII
