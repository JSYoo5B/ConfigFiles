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

# Language environment
export LANG=en_US.UTF-8

# Import alias configuration files 
if [ -f ~/.zsh_aliases ]; then
	source ~/.zsh_aliases
fi

# Import development envirnment configuration file
if [ -f ~/.zsh_devconfig ]; then
	source ~/.zsh_devconfig
fi
