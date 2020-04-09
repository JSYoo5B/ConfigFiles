
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function last_run() {
    echo "%(?,%{$fg[green]%}%*,%{$fg[red]%}%* [%?])"
}

function pwd_width_success() {
    echo "$(( ${COLUMNS:-80} - 11 ))"
}

function pwd_width_fail() {
	echo "$(( ${COLUMNS:-80} - 17 ))"
}

function pwd_string() {
	echo "%{$fg_bold[blue]%}%(?,%$(pwd_width_success)<...<%/%<<,%$(pwd_width_fail)<...<%/%<<)%{$reset_color%}"
}

function ps1_string() {
	echo "%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}"
}

function prompt_char {
	if [ $UID -eq 0 ]; then 
		echo "%{$fg[red]%}#%{$reset_color%}"
	else 
		echo $
	fi
}

function get_shell_name {
	ps -p $$ -ocomm=
}
[ -z "$PROMPT_RUNNING_SH" ] && export PROMPT_RUNNING_SH=$(get_shell_name)

PROMPT='┌$(last_run) $(pwd_string)
└$(ps1_string):$PROMPT_RUNNING_SH $(prompt_char) '

RPROMPT='$(git_prompt_info)'
