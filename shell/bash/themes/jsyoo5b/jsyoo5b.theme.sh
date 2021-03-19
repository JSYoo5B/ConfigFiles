#!/usr/bin/env bash

# oh-my-bash JSYoo5B theme

###############################################################################
# Customize
## Change this associative array to modify theme in runtime
declare -A BASH_THEME_CONF
## Visual effects for each parts
BASH_THEME_CONF+=([TIME_EFFECT]=$green)				# Time: Green text
BASH_THEME_CONF+=([PWD_EFFECT]=$bold_blue)			# PWD: Blue text, Bolded
BASH_THEME_CONF+=([USER_EFFECT]=$purple)			# Username: Magenta text
BASH_THEME_CONF+=([HOST_EFFECT]=$yellow)			# Hostname: Yellow text
BASH_THEME_CONF+=([PROMPT_ROOT_EFFECT]=$red)		# Root user: Red text
BASH_THEME_CONF+=([PROMPT_GENERAL_EFFECT]=$cyan)	# General users: Cyan text
## Texts for customizing theme in runtime
## (Add your visual effects inside each variable)
## (Visual effects will be reset after showing each variable)
BASH_THEME_CONF+=([USER_PREFIX]='')			# Default: blank
BASH_THEME_CONF+=([USER_SUFFIX]='')			# Default: blank
BASH_THEME_CONF+=([HOST_PREFIX]='')			# Default: blank
BASH_THEME_CONF+=([HOST_SUFFIX]='')			# Default: blank
BASH_THEME_CONF+=([SHELL_NAME]="bash")		# Default: "bash"
BASH_THEME_CONF+=([RPROMPT_PREFIX]='')		# Default: blank
BASH_THEME_CONF+=([RPROMPT_SUFFIX]='')		# Default: blank
###############################################################################


###############################################################################
# Main prompt (first line)
## Show current time (hour, minute, second)
_theme_func_timestamp() {
	local time_str=`date +%T`                 # HH:MM:SS

    echo "${BASH_THEME_CONF[TIME_EFFECT]}${time_str}$normal"
}

## Show pwd in absolute path format
## When the path expects line wrap, it will truncate to fit console width
_theme_func_pwd() {
	local pwd_str="$(pwd)"
	local max_width pwd_width

	max_width=$(tput cols)
	max_width=$[max_width-10]
	pwd_width=${#pwd_str}

	if [ $pwd_width -gt $max_width ]; then
		local offset=$[pwd_width-max_width]
		offset=$[offset+3]
		max_width=$[max_width-3]

		pwd_str="...${pwd_str:offset:max_width}"
	fi

    echo "${BASH_THEME_CONF[PWD_EFFECT]}${pwd_str}$normal"
}
###############################################################################


###############################################################################
# Main prompt (second line)
## Show username_at_hostname
_theme_func_user_at_host() {
    local user host

    user="${BASH_THEME_CONF[USER_PREFIX]}$normal"
    user="${user}${BASH_THEME_CONF[USER_EFFECT]}\u$normal"
    user="${user}${BASH_THEME_CONF[USER_SUFFIX]}$normal"

    host="${BASH_THEME_CONF[HOST_PREFIX]}$normal"
    host="${host}${BASH_THEME_CONF[HOST_EFFECT]}\h$normal"
    host="${host}${BASH_THEME_CONF[HOST_SUFFIX]}$normal"

    echo "${user}@${host}"
}

## Show current shell name and prompt character
_theme_func_shell_and_prompt() {
    local shell_name
    local prompt eff
    local last

    shell_name="${BASH_THEME_CONF[SHELL_NAME]}$normal"

    if [ $UID -eq 0 ]; then
        prompt="#"
        eff="${BASH_THEME_CONF[PROMPT_ROOT_EFFECT]}"
    else
        prompt="$"
        eff="${BASH_THEME_CONF[PROMPT_GENERAL_EFFECT]}"
    fi

    [[ $RETVAL -ne 0 ]] && last="\e[31m<$RETVAL>"

    echo "${shell_name}${last}$normal${eff}${prompt}$normal"
}
###############################################################################


# Evaluate PROMPT (BASH_THEME_CONF & runtime vars are not evaluated)
set_bash_prompt() {
	RETVAL=$?
	PR=""
	PS1="
┌$(_theme_func_timestamp) $(_theme_func_pwd)
└$(_theme_func_user_at_host):$(_theme_func_shell_and_prompt) "
	PS2='> '
	PS4='+ '
}

safe_append_prompt_command set_bash_prompt

