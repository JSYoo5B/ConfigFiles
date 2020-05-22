# oh-my-zsh JSYoo5B theme

# configure modules for zsh
setopt PROMPT_SUBST
autoload colors
colors

_RESET="%f%k%b%u"

time_stamp() {
	local _TIMESTR

	_TIMESTR="%D{%H:%M:%S}"
	echo "%F{green}${_TIMESTR}${_RESET}"
}

pwd_in_width() {
	local _WIDTH _PWD

    _WIDTH=$(( ${COLUMNS:-80} - 10 ))
	_PWD="%${_WIDTH}<...<%/%<<"
	echo "%F{blue}%B${_PWD}${_RESET}"
}

ps1_string() {
	local _USER _HOST

	_USER="%F{magenta}"
	_HOST="%F{yellow}"
	echo "${_USER}%n${_RESET}@${_HOST}%m${_RESET}"
}

shell_prompt_char() {
	local _SHELL _PROMPT
	local _DECO

	_SHELL="zsh"
	if [ $UID -eq 0 ]; then
		_PROMPT="#"
		_DECO="%F{red}"
	else
		_PROMPT="$"
	fi
	echo "${_SHELL} ${_DECO}${_PROMPT}${_RESET}"
}

PROMPT='┌$(time_stamp) $(pwd_in_width)
└$(ps1_string):$(shell_prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${_RESET}"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT='$(git_prompt_info)'
