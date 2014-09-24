#!/bin/sh

### BEGIN INIT INFO
# Provides:          <%= @service_name %>
# Required-Start:    $syslog $remote_fs
# Required-Stop:     $syslog $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: New Relic <%= @plugin_name %> Plugin
# Description:       Controls the New Relic <%= @plugin_name %> Plugin
### END INIT INFO

DESC="New Relic <%= @plugin_name %> Plugin Daemon"
NAME=<%= @service_name %>
VERSION=<%= @version %>
DAEMON=<%= @daemon %>
DAEMONDIR=<%= @daemon_dir %>
PIDFILE=/var/run/$NAME.pid

get_pid() {
  cat "$PIDFILE"
}

is_running() {
  [ -f "$PIDFILE" ] && ps `get_pid` > /dev/null 2>&1
}

start() {
  if is_running; then
    echo "Already Started $NAME"
  else
    echo "Starting $NAME"
    cd $DAEMONDIR
    touch $PIDFILE ; chown <%= @user %> $PIDFILE
    su <%= @user %> -c "<%= @run_command %> $DAEMON >> $DAEMONDIR/plugin_daemon.log 2>&1 & echo \$! > $PIDFILE"
  fi
}

status() {
  if is_running; then
    echo "$NAME $VERSION is running"
  else
    echo "$NAME $VERSION is stopped"
    exit 1
  fi
}

stop() {
  if is_running; then
    echo "Stopping $NAME"
    kill `get_pid`
  else
    echo "$NAME is not running"
  fi
}

restart() {
  stop
  sleep 1
  start
}

case "${1}" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status
    ;;
  restart)
    restart
    ;;
  *)
    echo "Usage: ${0} {start|stop|restart|status}"
    exit 1
    ;;
esac

exit 0