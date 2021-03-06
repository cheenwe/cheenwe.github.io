---
layout: post
title: ubuntu 下常用 alias
tags:    shell sh
category:   shell
---

将该内容替换掉 

> ~/.bashrc

文件 即可


```
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=10000000
export HISTFILESIZE=20000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ============= start additional  our part =============
# export PYTHONPATH=$PYTHONPATH:$HOME/local/lib/python2.6/site-packages/
# export SVN_EDITOR=emacs
export PATH=/usr/local/bin:$PATH
umask 002
PS1='[\h]$ '
BASE=$(dirname $BASH_SOURCE)
#echo "----.basrc: BASE="$BASE
# set up a smarter shell prompt
if [ $TERM = 'dumb' ]; then
    PS1="--\u@\h-------------------------------------------\t--\n[\w]\$ "
else
    if [ $TERM = 'screen' ]; then
        bright=';1'
        titlesc='\033k\033\\'
    else
        bright=''
        titlesc=''
    fi


    # choose a colour from the ps1colors file based on the hostname
    hostcolor=$(
    if [ -f $BASE/.ps1colors ]; then
        cat $BASE/.ps1colors | while read usergrep color; do
        if (echo $USER --short | grep -q $usergrep); then
            echo $color
            break
        fi
        done
    # else
        # echo "32"
    fi
    )
    if [ -z $hostcolor ]; then hostcolor=32; fi


    PS1="\[\e[${hostcolor}${bright}m\]--\u@\h-------------------------------------------\t--\[\e[0m\]\n\[\e[${hostcolor}${bright}m${titlesc}\][\w]\$\[\e[0m\] "
fi
export PS1



# ============================ alias
# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias lm='ls -m'

alias ip="ifconfig"

alias c="clear"
alias p="pwd"


alias mkdir="mkdir -pv"
alias tf='tail -f'  #动态查看文件变化
alias af="awk -F '\t' '{print NF}'"   #查看文件列数，用\t分隔，最常用，其实也可以搞个通用的，接收参数
alias wl='wc -l'    #统计行数

# editor
alias vi="vim"
alias edit="vim"


# Git shortcuts
alias ga='git add '
alias gb='git branch'
alias gba='git branch -a'
alias gbru='git remote prune origin'
alias gbd='git branch -D'
alias gc='git commit -m'
alias gcl='git clone'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gclean='git fetch --prune'
alias gd='git diff'
alias gdi='git di'
alias gr='git rm'
alias gs='git status'
alias gss='git status -s'
alias gl='git log'
alias gll='git lg'
alias gull='git pull origin'
alias gush='git push origin'
alias gt='git checkout'
alias gtd='git checkout develop'
alias gm='git merge --no-ff'
alias grv='git remote -v'
alias gp='git push'
alias gts='git tag -s'


# Rails aliases
alias rc='rails console'
alias rcs='rails console --sandbox'
alias rd='rails destroy'
alias rdb='rails dbconsole'
alias rg='rails generate'
alias rgm='rails generate migration'
alias rp='rails plugin'
alias ru='rails runner'
alias rs='rails server'
alias rsd='rails server --debugger'
alias rsp='rails server --port'

# Rake aliases
alias rdm='rails db:migrate'
alias rdms='rails db:migrate:status'
alias rdr='rails db:rollback'
alias rdc='rails db:create'
alias rds='rails db:seed'
alias rdd='rails db:drop'
alias rdrs='rails db:reset'
alias rdtc='rails db:test:clone'
alias rdtp='rails db:test:prepare'
alias rdmtc='rails db:migrate db:test:clone'
alias rdsl='rails db:schema:load'
alias rlc='rails log:clear'
alias rn='rails notes'
alias rr='rails routes'
alias rrg='rails routes | grep'
alias rt='rails test'
alias rmd='rails middleware'
alias rsts='rails stats'


# file operate
cpv() {
    rsync -pogbr -hhh  -e /dev/null --progress "$@"
    # rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress "$@"
}

# compdef _files cpv


#临时文件
mvtmp(){
  mv $1 ~/tmp/
}

function cptmp(){
  cp -r $1 ~/tmp/
}


#最常用，复制一个路径过来时，不用修改，可以到达路径的最深一层目录
#if dir,cd into it. if file ,cd into where the file is
goto(){ [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }


#查看自己常用命令top n
# View most commonly used commands. depends on your history output format
used(){
if [ $1 ]
then
    history | awk '{print $4}' | sort | uniq -c | sort -nr | head -n $1
else
    history | awk '{print $4}' | sort | uniq -c | sort -nr | head -n 10
fi
}

#根据文件类型解压
#extract(){
ext(){
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1        ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xf $1        ;;
            *.tbz2)      tar xjvf $1      ;;
            *.tgz)       tar xzvf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

#压缩
mktar(){ tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz(){ tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz(){ tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }


#分屏同时打开多个文件
#vim -oN filea fileb filec
vo(){
   vim -o$# $*
}

#创建一个目录并跳转到
#make a dir and cd into it
mcd(){
    mkdir -pv "$@"
    cd "$@"
}


# chdir
alias ..="cd .."
alias cdd="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias -- -='cd -'
alias cds='echo "`pwd`" > ~/.cdsave'  #cd save : save where i am
alias cdb='cd "`cat ~/.cdsave`"'  # cd back

#磁盘
alias df="df -h"
alias du="du -h"
alias dus="du -s"
alias du0="du --max-depth=0"
alias du1="du --max-depth=1"


alias fd="sudo fdisk -l"

# net
alias pong='ping -c 5 '   #ping，限制
alias ports='netstat -tulanp'
alias myip='curl ifconfig.me'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


```
