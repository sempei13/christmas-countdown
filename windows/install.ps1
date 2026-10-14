# Registers the "Christmas Countdown" scheduled task for the current user:
# runs countdown.ps1 every day at 12:00 AM local time. If the PC was off or
# asleep at midnight, it runs as soon as it can. Also runs once right now.
# Remove with: Unregister-ScheduledTask -TaskName 'Christmas Countdown' -Confirm:$false

$script = Join-Path $PSScriptRoot 'countdown.ps1'

$action = New-ScheduledTaskAction -Execute 'powershell.exe' `
    -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$script`""
$trigger = New-ScheduledTaskTrigger -Daily -At '12:00 AM'
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

Register-ScheduledTask -TaskName 'Christmas Countdown' -Action $action -Trigger $trigger `
    -Settings $settings -Description 'Updates days-until-christmas.txt every day at midnight.' -Force | Out-Null

Start-ScheduledTask -TaskName 'Christmas Countdown'
Start-Sleep -Seconds 3
Get-Content (Join-Path $PSScriptRoot 'days-until-christmas.txt')
