#! /bin/sh
### BEGIN INIT INFO
# Provides:          jira
# Required-Start:    $remote_fs
# Required-Stop:     $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start or stop the jira.
### END INIT INFO

SOFT_ROOT_PATH=/opt/atlassian/jira
SOFT_NAME=jira
CONFIG_PID=work/catalina.pid

#停止方法
stop(){
    echo "Stoping $SOFT_NAME "
    $SOFT_ROOT_PATH/bin/stop-${SOFT_NAME}.sh
}

case "$1" in
start)
    echo "Starting $SOFT_NAME "
    $SOFT_ROOT_PATH/bin/start-${SOFT_NAME}.sh
  ;;
stop)
  stop
  ;;
restart)
  stop
  start
  ;;
status)
    soft_pid=`cd ${SOFT_ROOT_PATH} && cat ${CONFIG_PID} 2>/dev/null`
    ret=$?; if [[ 0 -eq $ret ]]; then echo "${SOFT_NAME} (pid ${soft_pid}) is running."; return 0; fi
    echo "${SOFT_NAME} is stopped, $error_msg"
    return 1

  ;;
*)
  printf 'Usage: %s {start|stop|restart|status}\n' "$prog"
  exit 1
  ;;
esac

