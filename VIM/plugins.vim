set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
	" Plugin manager
	Plugin 'gmarik/Vundle.vim'			" Plugin manager
	" Color scheme
	Plugin 'NLKNguyen/papercolor-theme'	" Papercolor theme scheme
	" IDE tools (utils)
	Plugin 'The-NERD-tree'				" File explorer
	Plugin 'vim-airline/vim-airline'	" Enhanced status bar
	" Code visualize enhancement
	Plugin 'Yggdroot/indentLine'		" Indent guideline
	Plugin 'airblade/vim-gitgutter'		" Git change tracker
	" Code suggest, check, and enhancement
	Plugin 'scrooloose/syntastic'		" Syntax checker
	Plugin 'The-NERD-Commenter'			" Comment enhancer
	" Code reading enhancement (tag, jump)
	Plugin 'xolox/vim-misc'				" required for vim-easytags
	Plugin 'xolox/vim-easytags'			" ctags improver
	Plugin 'ronakg/quickr-cscope.vim'	" cscope improver
	Plugin 'majutsushi/tagbar'			" tagbar to overview code
	Plugin 'wesleyche/srcexpl'			" Source code explorer
call vundle#end()

filetype plugin indent on

"===============================================================================
"= NERD Tree configuration
"===============================================================================
let NERDTreeWinPos="left"
let g:NERDTreeDirArrows=0
map <F2> :NERDTreeToggle<CR>

"===============================================================================
"= Vim-airline configuration
"===============================================================================
let g:airline#extensions#whitespace#enabled=0

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
"= easytags configuration
"===============================================================================
let g:easytags_async = 1			" load tags async (better responsive)
let g:easytags_auto_highlight = 0	" disable highlight (better responsive)
let g:easytags_include_members = 1	" track member of structs
let g:easytags_dynamic_files = 1	" load tags on demand
let g:easytags_suppress_ctags_warning = 1	" universal ctags version problem

"==============================================================================
"= tagbar configuration
"==============================================================================
map <F8> :TagbarToggle<CR>

"===============================================================================
"= quickr-cscope configuration
"===============================================================================
function! LoadCscope()
	let db = findfile("cscope.out", ".;")
	if (!empty(db))
		let path = strpart(db, 0, match(db, "/cscope.out$"))
		set nocscopeverbose " suppress 'duplicate connection' error
		exe "cs add " . db . " " . path 
		set cscopeverbose 
	" else add the database pointed to by environment variable
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
endfunction

set tags=./tags
au BufEnter /* call LoadCscope()

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
