# Christmas Countdown

Writes the number of days until Christmas to `days-until-christmas.txt` every day at midnight, local time.

```
73 days until Christmas.
```

On Christmas Eve it says `1 day until Christmas.`, on Christmas Day `Merry Christmas! It's today.`, and on the 26th it rolls over to next year.

## Mac

```bash
chmod +x install.sh countdown.sh
./install.sh
```

This installs a LaunchAgent that runs `countdown.sh` at 12:00 AM and at login (so a Mac that was off at midnight catches up). The text file is written next to the script.

To remove it:

```bash
launchctl bootout gui/$(id -u)/com.citt.christmas-countdown
rm ~/Library/LaunchAgents/com.citt.christmas-countdown.plist
```

## Windows

Open PowerShell in the `windows` folder and run:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

This registers a scheduled task named "Christmas Countdown" that runs `countdown.ps1` at 12:00 AM. If the PC was off or asleep at midnight, it runs as soon as it can. The text file is written to the `windows` folder.

To remove it:

```powershell
Unregister-ScheduledTask -TaskName 'Christmas Countdown' -Confirm:$false
```

## Testing

Both scripts take an optional date to pretend it's that day:

```bash
./countdown.sh 2026-12-24            # Mac
```

```powershell
.\countdown.ps1 2026-12-24           # Windows
```

Run it again with no date to go back to the real count.
