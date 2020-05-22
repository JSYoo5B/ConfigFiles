# oh-my-zsh JSYoo5B theme

# configure modules for zsh
setopt PROMPT_SUBST
autoload colors
colors

# Change this variable in shell
export ZTHEME_PRE_SH=''

readonly RESET="%f%k%b%u"

__time_stamp() {
  local time_str

  time_str="%D{%H:%M:%S}"
  echo "%F{green}${time_str}${RESET}"
}

__pwd_in_width() {
  local width
  local pwd_string

  width=$(( ${COLUMNS:-80} - 10 ))
  pwd_string="%${width}<...<%/%<<"
  echo "%F{blue}%B${pwd_string}${RESET}"
}

__user_at_host() {
  local user_eff host_eff

  user_eff="%F{magenta}"
  host_eff="%F{yellow}"
  echo "${user_eff}%n${RESET}@${host_eff}%m${RESET}"
}

__shell_and_sign() {
  local shell_name sign
  local sign_eff

  shell_name="zsh"
  if [ $UID -eq 0 ]; then
    sign="#"
    sign_eff="%F{red}"
  else
    sign="$"
    sign_eff="%F{cyan}"
  fi
  echo "${shell_name}${sign_eff}${sign}${RESET}"
}

PROMPT='┌$(__time_stamp) $(__pwd_in_width)
└$(__user_at_host):$ZTHEME_PRE_SH$RESET$(__shell_and_sign) '

ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${RESET}"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT='$(git_prompt_info)'
