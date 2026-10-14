#!/bin/bash
# Writes the number of days until Christmas (local time) to days-until-christmas.txt.
# Run daily at midnight by the LaunchAgent com.citt.christmas-countdown.
# Testing: pass a date to pretend it's that day, e.g. ./countdown.sh 2026-10-14

DIR="$(cd "$(dirname "$0")" && pwd)"
OUT="$DIR/days-until-christmas.txt"

day="${1:-$(date +%Y-%m-%d)}"
if ! today=$(date -j -f "%Y-%m-%d %H:%M:%S" "$day 00:00:00" +%s 2>/dev/null); then
  echo "Bad date '$day' - use YYYY-MM-DD." >&2
  exit 1
fi
year=${day%%-*}
xmas=$(date -j -f "%Y-%m-%d %H:%M:%S" "$year-12-25 00:00:00" +%s)

# Past Christmas this year? Count to next year's.
if [ "$today" -gt "$xmas" ]; then
  xmas=$(date -j -f "%Y-%m-%d %H:%M:%S" "$((year + 1))-12-25 00:00:00" +%s)
fi

# Round to whole days so a DST shift (23- or 25-hour day) doesn't throw it off.
days=$(( (xmas - today + 43200) / 86400 ))

if [ "$days" -eq 0 ]; then
  msg="Merry Christmas! It's today."
elif [ "$days" -eq 1 ]; then
  msg="1 day until Christmas."
else
  msg="$days days until Christmas."
fi

printf '%s\n' "$msg" > "$OUT"
