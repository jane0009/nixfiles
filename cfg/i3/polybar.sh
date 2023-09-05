#!/usr/bin/env sh
#sleep 2
killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

# polybar dummy &
polybar top &
