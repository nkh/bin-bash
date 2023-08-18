#!/bin/bash

pid=$1

if mini_git=$(cat ~/.tmux/plugins/tmuxake/pids/$pid/MINI_GIT 2> /dev/null) ; then
	export MINI_GIT=$mini_git
fi

"/home/nadim/nadim/bin/bash/get_git_prompt"
