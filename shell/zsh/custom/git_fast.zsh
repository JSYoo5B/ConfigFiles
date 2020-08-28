function parse_git_dirty() {
  local STATUS
  local -a FLAGS
  FLAGS=('--porcelain')
  if [[ "$(__git_prompt_git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ "${DISABLE_UNTRACKED_FILES_DIRTY:-}" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    case "${GIT_STATUS_IGNORE_SUBMODULES:-}" in
      git)
        # let git decide (this respects per-repo config in .gitmodules)
        ;;
      *)
        # if unset: ignore dirty submodules
        # other values are passed to --ignore-submodules
        FLAGS+="--ignore-submodules=${GIT_STATUS_IGNORE_SUBMODULES:-dirty}"
        ;;
    esac
	STATUS=$(timeout 1 cat <( __git_prompt_git status ${FLAGS} ) | tail -n1 ; echo ${pipestatus[1]})
  fi
  if [[ -n $STATUS ]]; then
    if [[ $STATUS = "124" ]]; then
	  echo "$ZSH_THEME_GIT_PROMPT_UNKNOWN"
    elif [[ $STATUS != "0" ]]; then
	  echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
    fi
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

