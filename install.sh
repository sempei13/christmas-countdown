#!/bin/bash
# Installs the LaunchAgent com.citt.christmas-countdown for the current user:
# runs countdown.sh every day at 12:00 AM local time and at login. Also runs once right now.
# Remove with: launchctl bootout gui/$(id -u)/com.citt.christmas-countdown
#              rm ~/Library/LaunchAgents/com.citt.christmas-countdown.plist

DIR="$(cd "$(dirname "$0")" && pwd)"
LABEL="com.citt.christmas-countdown"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"

chmod +x "$DIR/countdown.sh"
mkdir -p "$HOME/Library/LaunchAgents"

cat > "$PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>$LABEL</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>$DIR/countdown.sh</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key>
    <integer>0</integer>
    <key>Minute</key>
    <integer>0</integer>
  </dict>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
PLIST

# Reload if it's already installed.
launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null
launchctl bootstrap "gui/$(id -u)" "$PLIST"

sleep 2
cat "$DIR/days-until-christmas.txt"
