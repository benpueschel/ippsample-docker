#!/bin/sh
set -e

# Start dbus system-wide message bus
if [ ! -e /var/run/dbus ]; then
	mkdir -p /var/run/dbus
	chown messagebus:messagebus /var/run/dbus
fi
if [ ! -e /var/run/dbus/system_bus_socket ]; then
	echo "Starting dbus-daemon..."
	dbus-daemon --system
fi

echo "Starting avahi daemon..."
echo "Logs available at /logs/avahi.log"
mkdir -p /logs
# Start avahi-daemon using the flungo/avahi entrypoint script
# And force dbus
SERVER_ENABLE_DBUS=yes /opt/entrypoint.sh > /logs/avahi.log 2>/logs/avahi.log &

echo "Waiting 2 seconds for avahi-daemon to start..."
sleep 2

printf "\n\n"

# exec user command
# ippsample apps don't listen to ^C so we'll just kill them when we get SIGTERM or SIGINT
"$@" &
APP_PID=$!

KILL_MSG="Killing command '$@' with PID $APP_PID"
trap 'echo "$KILL_MSG"; kill -9 "$APP_PID"' SIGTERM SIGINT

wait "$APP_PID"
