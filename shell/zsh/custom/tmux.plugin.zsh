# Wrapper function for tmux.
function _zsh_tmux_plugin_run() {
  if [[ -n "$@" ]]; then
    command tmux -2 "$@"
    return $?
  fi

  local -a tmux_cmd
  tmux_cmd=(command tmux)
  tmux_cmd+=(-2)
  [[ "$ZSH_TMUX_ITERM2" == "true" ]] && tmux_cmd+=(-CC)
  [[ "$ZSH_TMUX_UNICODE" == "true" ]] && tmux_cmd+=(-u)

  # Try to connect to an existing session.
  [[ "$ZSH_TMUX_AUTOCONNECT" == "true" ]] && $tmux_cmd attach

  # If failed, just run tmux, fixing the TERM variable if requested.
  if [[ $? -ne 0 ]]; then
    if [[ "$ZSH_TMUX_FIXTERM" == "true" ]]; then
      tmux_cmd+=(-f "$_ZSH_TMUX_FIXED_CONFIG")
    elif [[ -e "$ZSH_TMUX_CONFIG" ]]; then
      tmux_cmd+=(-f "$ZSH_TMUX_CONFIG")
    fi
    $tmux_cmd new-session
  fi

  if [[ "$ZSH_TMUX_AUTOQUIT" == "true" ]]; then
    exit
  fi
}

