#!/bin/zsh

# oh-my-zsh JSYoo5B theme

###############################################################################
# Customize
## Change this associative array to modify theme in runtime
declare -A ZSH_THEME_CONF
## Visual effects for each parts
ZSH_THEME_CONF[TIME_EFFECT]="%F{green}"           # Time: Green text
ZSH_THEME_CONF[PWD_EFFECT]="%F{blue}%B"           # PWD: Blue text, Bolded
ZSH_THEME_CONF[USER_EFFECT]="%F{magenta}"         # Username: Magenta text
ZSH_THEME_CONF[HOST_EFFECT]="%F{yellow}"          # Hostname: Yellow text
ZSH_THEME_CONF[PROMPT_ROOT_EFFECT]="%F{red}"      # Root user: Red text
ZSH_THEME_CONF[PROMPT_GENERAL_EFFECT]="%F{cyan}"  # General users: Cyan text
## Texts for customizing theme in runtime
## (Add your visual effects inside each variable)
## (Visual effects will be reset after showing each variable)
ZSH_THEME_CONF[USER_PREFIX]=''          # Default: blank
ZSH_THEME_CONF[USER_SUFFIX]=''          # Default: blank
ZSH_THEME_CONF[HOST_PREFIX]=''          # Default: blank
ZSH_THEME_CONF[HOST_SUFFIX]=''          # Default: blank
ZSH_THEME_CONF[SHELL_NAME]="zsh"        # Default: "zsh"
ZSH_THEME_CONF[RPROMPT_PREFIX]=''       # Default: blank
ZSH_THEME_CONF[RPROMPT_SUFFIX]=''       # Default: blank
###############################################################################\


# configure modules for zsh
setopt PROMPT_SUBST
autoload colors
colors

# Define constants
_CLR="%f%k%b%u"     # Reset all visual effects


###############################################################################
# Main prompt (first line)
## Show current time (hour, minute, second)
_theme_func_timestamp() {
  local time_str="%D{%H:%M:%S}"         # HH:MM:SS

  echo "\${ZSH_THEME_CONF[TIME_EFFECT]}${time_str}${_CLR}"
}

## Show pwd in absolute path format
## When the path expects line wrap, it will truncate to fit console width
_theme_func_pwd() {
  local width="\$(( \${COLUMNS:-80} - 10 ))"      # 10 == "┌HH:MM:SS "
  local pwd_str="%${width}<...<%/%<<"             # ...h-my-zsh/custom/themes

  echo "\${ZSH_THEME_CONF[PWD_EFFECT]}${pwd_str}${_CLR}"
}
###############################################################################


###############################################################################
# Main prompt (second line)
## Show username_at_hostname
_theme_func_user_at_host() {
  local user host

  user="\${ZSH_THEME_CONF[USER_PREFIX]}${_CLR}"
  user="${user}\${ZSH_THEME_CONF[USER_EFFECT]}%n${_CLR}"
  user="${user}\${ZSH_THEME_CONF[USER_SUFFIX]}${_CLR}"

  host="\${ZSH_THEME_CONF[HOST_PREFIX]}${_CLR}"
  host="${host}\${ZSH_THEME_CONF[HOST_EFFECT]}%m${_CLR}"
  host="${host}\${ZSH_THEME_CONF[HOST_SUFFIX]}${_CLR}"

  echo "${user}@${host}"
}

## Show current shell name and prompt character
_theme_func_shell_and_prompt() {
  local shell_name
  local prompt eff
  local last_status

  shell_name="\${ZSH_THEME_CONF[SHELL_NAME]}${_CLR}"

  if [ $UID -eq 0 ]; then
    prompt="#"
    eff="\${ZSH_THEME_CONF[PROMPT_ROOT_EFFECT]}"
  else
    prompt="$"
    eff="\${ZSH_THEME_CONF[PROMPT_GENERAL_EFFECT]}"
  fi

  last="%(?,,%F{red}<%?>)"

  echo "${shell_name}${last}${_CLR}${eff}${prompt}${_CLR}"
}
###############################################################################


# Evaluate PROMPT (ZSH_THEME_CONF & runtime vars are not evaluated)
PROMPT="
┌$(_theme_func_timestamp) $(_theme_func_pwd)
└$(_theme_func_user_at_host):$(_theme_func_shell_and_prompt) "


###############################################################################
# Sub prompt (right of main prompt second line)
## Show right prompt prefix
_theme_func_rpr_pre() {
  echo "\${ZSH_THEME_CONF[RPROMPT_PREFIX]}${_CLR}"
}

## Show right prompt suffix
_theme_func_rpr_suf() {
  echo "\${ZSH_THEME_CONF[RPROMPT_SUFFIX]}${_CLR}"
}

git_prompt_detail() {
  local info
  local stat_mark

  info="$(git_prompt_info)"
  if [[ $info != "" ]]; then
    stat_mark="$(parse_git_dirty)"
  fi

  if [[ $stat_mark = $ZSH_THEME_GIT_PROMPT_DIRTY ]]; then
    stat_mark="${_CLR}($(git_prompt_status)${_CLR})"
  else
    stat_mark=""
  fi

  echo "${info}${stat_mark}"
}

## Right prompt shows git information as default
ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${_CLR}"
ZSH_THEME_GIT_PROMPT_DIRTY="${_CLR} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNKNOWN="%F{yellow}?"
ZSH_THEME_GIT_PROMPT_ADDED="%F{cyan}+${_CLR}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{yellow}*${_CLR}"
ZSH_THEME_GIT_PROMPT_DELETED="%F{red}-${_CLR}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{magenta}?${_CLR}"
###############################################################################


# Evaluate RPROMPT (Ext. func. call & ZSH_THEME_CONT are not evaluated)
RPROMPT="$(_theme_func_rpr_pre)\$(git_prompt_detail)$(_theme_func_rpr_suf)"


# Unset internal variables and functions
unset _CLR
unset -f -m "_theme_func_*"
