############################################################################
## Basic z-shell usage configuration (with oh-my-zsh)					   #
############################################################################
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# zsh and Oh-my-zsh config aliases
alias zshconfig="vi ~/.zshrc"
alias omzconfig="vi ~/.oh-my-zsh"

# ZSH Theme and plugins
ZSH_THEME="jsyoo5b"
plugins=(
  git sudo command-not-found
#  zsh-completions
  fast-syntax-highlighting
  autojump
)

COMPLETION_WAITING_DOTS="true"

# History setting 
HIST_STAMPS="dd.mm.yyyy"

# zsh-completion setting
#autoload -U compinit && compinit


# Load oh-my-zsh with given configuration
source $ZSH/oh-my-zsh.sh

############################################################################
## User configuration (General shell setting)							   #
############################################################################

# manual path
export MANPATH="/usr/local/man:$MANPATH"

# Set default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Language environment
export LANG=en_US.UTF-8

# X-Window configuration
export DISPLAY=:0

# Import alias and shell config file
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# Import development envirnment config file
[ -f ~/.zsh_devconfig ] && source ~/.zsh_devconfig

# Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
