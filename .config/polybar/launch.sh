#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u "$(id -ru)" -x polybar >/dev/null; do sleep 1; done

# Launch bar
. /home/jp/.colors
polybar --config=/home/jp/.config/polybar/config -r barBottom &

echo "Bars launched..."
