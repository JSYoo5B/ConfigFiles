set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
	" Vundle, the plugin manager
	Plugin 'gmarik/Vundle.vim'
	" Fuzzy finder, for better search
	Plugin 'junegunn/fzf'
	" NERDtree, file explorer
	Plugin 'scrooloose/nerdtree'
call vundle#end()

filetype plugin indent on
