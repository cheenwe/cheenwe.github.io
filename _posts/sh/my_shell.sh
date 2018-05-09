#!/bin/bash

### BEGIN INIT INFO
# Provides:          cheenwe(my_shell)
# RequiRED-Start:    $all
# RequiRED-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: cheenwe(my_shell)
# Description:       https://github.com/cheenwe/my_shell
### END INIT INFO

ROOT="/usr/local/my_shell"
APP="./objs/my_shell"
CONFIG="./conf/my_shell.conf"
DEFAULT_PID_FILE='./objs/my_shell.pid'
DEFAULT_LOG_FILE='./objs/my_shell.log'

########################################################################
# utility functions
########################################################################
RED="\\033[31m"
GREEN="\\033[32m"
YELLOW="\\033[33m"
BLACK="\\033[0m"
POS="\\033[60G"

ok_msg() {
    echo -e "${1}${POS}${BLACK}[${GREEN}  OK  ${BLACK}]"
}


warn_msg(){
    echo -e "${1}${POS}${BLACK}[ ${YELLOW}WARN${BLACK} ]"
}

failed_msg() {
    echo -e "${1}${POS}${BLACK}[${RED}FAILED${BLACK}]"
}

# load process info of my_shell
# @set variable $my_shell_pid to the process id in my_shell.pid file.
# @return 0, if process exists; otherwise:
#       1, for pid file not exists.
#       2, for get proecess info by pid failed.
# @set variable $error_msg if error.
# @set variable $pid_file to pid file.
load_process_info() {
    # get pid file
    pid_file=`cd ${ROOT} && cat ${CONFIG} |grep ^pid|awk '{print $2}'|awk -F ';' '{print $1}'`
    if [[ -z $pid_file ]]; then pid_file=${DEFAULT_PID_FILE}; fi
    # get abs path
    pid_dir=`dirname $pid_file`
    pid_file=`(cd ${ROOT}; cd $pid_dir; pwd)`/`basename $pid_file`

    my_shell_pid=`cat $pid_file 2>/dev/null`
    ret=$?; if [[ 0 -ne $ret ]]; then error_msg="file $pid_file does not exists"; return 1; fi

    ps -p ${my_shell_pid} >/dev/null 2>/dev/null
    ret=$?; if [[ 0 -ne $ret ]]; then error_msg="process $my_shell_pid does not exists"; return 2; fi

    return 0;
}

start() {
    # if exists, exit.
    load_process_info
    if [[ 0 -eq $? ]]; then failed_msg "Myapp started(pid ${my_shell_pid}), should not start it again."; return 0; fi

    # not exists, start server
    ok_msg "Starting Myapp..."

    # get log file
    log_file=`cd ${ROOT} && cat ${CONFIG} |grep '^log_file'| awk '{print $2}'| awk -F ';' '{print $1}'`
    if [[ -z $log_file ]]; then log_file=${DEFAULT_LOG_FILE}; fi

    # get abs path
    log_dir=`dirname $log_file`
    log_file=`(cd ${ROOT} && cd $log_dir && pwd)`/`basename $log_file`

    # TODO: FIXME: set limit by, for instance, "ulimit -HSn 10000"
    if [[ -z $log_file ]]; then
        (ulimit -c unlimited && cd ${ROOT}; ${APP} -c ${CONFIG} >/dev/null 2>&1)
    else
        (ulimit -c unlimited && cd ${ROOT}; ${APP} -c ${CONFIG} >> $log_file 2>&1)
    fi

    # check again after start server
    for ((i = 0; i < 5; i++)); do
        # sleep a little while, for my_shell may start then crash.
        sleep 0.1
        load_process_info
        ret=$?; if [[ 0 -ne $ret ]]; then
            failed_msg "Myapp start failed";
            failed_msg "see $log_file";
            return $ret;
        fi
    done

    # check whether started.
    load_process_info
    ret=$?; if [[ 0 -eq $? ]]; then ok_msg "Myapp started(pid ${my_shell_pid})"; return 0; fi

    failed_msg "Myapp not started"
    return $ret
}

stop() {
    # not start, exit
    load_process_info
    if [[ 0 -ne $? ]]; then failed_msg "Myapp not start."; return 0; fi

    ok_msg "Stopping Myapp(pid ${my_shell_pid})..."

    # process exists, try to kill to stop normally
    for((i=0;i<100;i++)); do
        load_process_info
        if [[ 0 -eq $? ]]; then
            kill -s SIGTERM ${my_shell_pid} 2>/dev/null
            ret=$?; if [[ 0 -ne $ret ]]; then failed_msg "send signal SIGTERM failed ret=$ret"; return $ret; fi
            sleep 0.3
        else
            ok_msg "Myapp stopped by SIGTERM"
            # delete the pid file when stop success.
            rm -f ${pid_file}
            break;
        fi
    done

    # process exists, use kill -9 to force to exit
    load_process_info
    if [[ 0 -eq $? ]]; then
        kill -s SIGKILL ${my_shell_pid} 2>/dev/null
        ret=$?; if [[ 0 -ne $ret ]]; then failed_msg "send signal SIGKILL failed ret=$ret"; return $ret; fi
        ok_msg "Myapp stopped by SIGKILL"
    else
        # delete the pid file when stop success.
        rm -f ${pid_file}
    fi

    sleep 0.1
    return 0
}

# get the status of my_shell process
# @return 0 if my_shell is running; otherwise, 1 for stopped.
status() {
    load_process_info
    ret=$?; if [[ 0 -eq $ret ]]; then echo "Myapp(pid ${my_shell_pid}) is running."; return 0; fi

    echo "Myapp is stopped, $error_msg"
    return 1
}

reload() {
    # not start, exit
    load_process_info
    if [[ 0 -ne $? ]]; then failed_msg "Myapp not start."; return 0; fi

    ok_msg "Reload Myapp(pid ${my_shell_pid})..."

    # process exists, reload it
    kill -s SIGHUP ${my_shell_pid} 2>/dev/null
    ret=$?; if [[ 0 -ne $ret ]]; then failed_msg "Reload Myapp failed ret=$ret"; return $ret; fi

    load_process_info
    if [[ 0 -ne $? ]]; then failed_msg "Myapp reload failed."; return $ret; fi

    ok_msg "Myapp reloaded"
    return 0
}

menu() {
    case "$1" in
        start)
            start
            ;;
        stop)
            stop
            ;;
        restart)
            stop
            start
            ;;
        status)
            status
            ;;
        reload)
            reload
            ;;
        *)
            echo "Usage: $0 {start|stop|status|restart|reload}"
            return 1
            ;;
    esac
}

menu $1

code=$?
exit ${code}
