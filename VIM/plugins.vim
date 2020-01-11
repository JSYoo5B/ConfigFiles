set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
	" Plugin manager
	Plugin 'gmarik/Vundle.vim'			" Plugin manager
	" IDE tools
	Plugin 'The-NERD-tree'				" File explorer
	Plugin 'The-NERD-Commenter'			" Comment enhancer
	Plugin 'vim-airline/vim-airline'	" Enhanced status bar
	Plugin 'snipMate'					" Snippping plugin
	Plugin 'wesleyche/srcexpl'			" Source code explorer
	Plugin 'airblade/vim-gitgutter'		" Git change tracker
	Plugin 'tpope/vim-fugitive'			" Git command in vim
	Plugin 'Yggdroot/indentLine'		" Indent guideline
	Plugin 'scrooloose/syntastic'		" Syntax checker
call vundle#end()

filetype plugin indent on

"===============================================================================
"= Key mapping
"===============================================================================
map <F2> :NERDTreeToggle<CR>
map <F3> :BufExplorer<CR>
map <F4> :SrcExplToggle<CR>
map <F5> :TlistToggle<CR>

"===============================================================================
"= NERD Tree
"===============================================================================
let NERDTreeWinPos="left"
let g:NERDTreeDirArrows=0

"===============================================================================
"= IndentLine configuration
"===============================================================================
let g:indentLine_color_gui = '#385900'
let g:indentLine_color_term = 100
let g:indentLine_char = '¦'
let g:indentLine_first_char = ''
let g:indentLine_showFirstIndentLevel = 0
let g:indentLine_enabled = 0
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'text', 'sh']
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']
let g:indentLine_maxLines = 3000
nnoremap \il :IndentLinesToggle<CR>

"===============================================================================
"= Vim-airline
"===============================================================================
let g:airline#extensions#whitespace#enabled=0

"===============================================================================
"= Source Explorer config
"===============================================================================

" // Set the height of Source Explorer window
let g:SrcExpl_winHeight = 8
" // Set 100 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 100
" // Set "Enter" key to jump into the exact definition context
let g:SrcExpl_jumpKey = "<ENTER>"
" // Set "Space" key for back from the definition context
let g:SrcExpl_gobackKey = "<SPACE>"

" // In order to avoid conflicts, the Source Explorer should know what plugins
" // except itself are using buffers. And you need add their buffer names into
" // below listaccording to the command ":buffers!"
let g:SrcExpl_pluginList = [
				\ "__Tag_List__",
				\ "NERD_tree_1",
				\ "Source_Explorer",
				\ "[BufExplorer]"
				\ ]

" // Enable/Disable the local definition searching, and note that this is not
" // guaranteed to work, the Source Explorer doesn't check the syntax for now.
" // It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 1
" // Do not let the Source Explorer update the tags file when opening
let g:SrcExpl_isUpdateTags = 0
" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
" // create/update the tags file
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."
" // Set "<F12>" key for updating the tags file artificially
let g:SrcExpl_updateTagsKey = "<F12>"

" // Set "<F3>" key for displaying the previous definition in the jump list
let g:SrcExpl_prevDefKey = "<F3>"
" // Set "<F4>" key for displaying the next definition in the jump list
let g:SrcExpl_nextDefKey = "<F4>"
