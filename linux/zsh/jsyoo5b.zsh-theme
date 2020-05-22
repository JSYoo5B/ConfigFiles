# oh-my-zsh JSYoo5B theme

# configure modules for zsh
setopt PROMPT_SUBST
autoload colors
colors

# Change this variable in shell
declare -A ZSH_THEME_CONFIG

# Reset foreground, background, bold, underline
readonly CLR="%f%k%b%u"


## First line, starts with time stamp
__time_stamp() {
  local time_str="%D{%H:%M:%S}"
  local time_eff="%F{green}"

  if [[ -n $ZSH_THEME_CONFIG[TIME_EFFECT] ]]; then
    time_eff=$ZSH_THEME_CONFIG[TIME_EFFECT]
  fi

  echo "${time_eff}${time_str}${CLR}"
}

## First line, current directory
__pwd_in_width() {
  local width=$(( ${COLUMNS:-80} - 10 ))
  local pwd_str="%${width}<...<%/%<<"
  local pwd_eff="%F{blue}%B"

  if [[ -n $ZSH_THEME_CONFIG[PWD_EFFECT] ]]; then
    pwd_eff=$ZSH_THEME_CONFIG[PWD_EFFECT]
  fi

  echo "${pwd_eff}${pwd_str}${CLR}"
}

## Second line, username and hostname
__user_at_host() {
  local user user_eff="%F{magenta}"
  local host host_eff="%F{yellow}"

  if [[ -n $ZSH_THEME_CONFIG[USER_EFFECT] ]]; then
    user_eff=$ZSH_THEME_CONFIG[USER_EFFECT]
  fi
  if [[ -n $ZSH_THEME_CONFIG[PWD_EFFECT] ]]; then
    host_eff=$ZSH_THEME_CONFIG[PWD_EFFECT]
  fi
  user="${ZSH_THEME_CONFIG[USER_PREFIX]}${CLR}"
  user="${user}${user_eff}%n${CLR}${ZSH_THEME_CONFIG[USER_SUFFIX]}${CLR}"
  host="${ZSH_THEME_CONFIG[HOST_PREFIX]}${CLR}"
  host="${host}${host_eff}%m${CLR}${ZSH_THEME_CONFIG[HOST_SUFFIX]}${CLR}"

  echo "${user}@${host}"
}

## Second line, shell and prompt character
__shell_and_prompt() {
  local prompt prompt_eff
  local shell_name

  if [ $UID -eq 0 ]; then
    prompt="#"
    prompt_eff="%F{red}"
  else
    prompt="$"
    prompt_eff="%F{cyan}"
  fi
  shell_name="${ZSH_THEME_CONFIG[SH_PREFIX]}${CLR}"
  shell_name="${shell_name}${ZSH_THEME_CONFIG[SHELL_NAME]-zsh}"
  shell_name="${shell_name}${CLR}${ZSH_THEME_CONFIG[SH_SUFFIX]}"

  echo "${shell_name}${CLR}${prompt_eff}${prompt}${CLR}"
}

PROMPT='┌$(__time_stamp) $(__pwd_in_width)
└$(__user_at_host):$(__shell_and_prompt) '

__right_prefix() {
  echo "${ZSH_THEME_CONFIG[RPROMPT_PREFIX]}${CLR}"
}

__right_suffix() {
  echo "${ZSH_THEME_CONFIG[RPROMPT_SUFFIX]}${CLR}"
}

ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${CLR}"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT='$(__right_prefix)$(git_prompt_info)$(__right_suffix)'
