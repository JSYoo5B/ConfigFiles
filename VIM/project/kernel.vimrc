"====================================================
"= Trick to read assambly files as C source code
"====================================================
au BufRead,BufNewFile *.S		set ft=c

"==========================================================================
"= autocmd for each file types
"==========================================================================
autocmd BufEnter *.c	  setlocal ts=8 sw=8 sts=8 noexpandtab
autocmd BufEnter *.h	  setlocal ts=8 sw=8 sts=8 noexpandtab
autocmd BufEnter *.S	  setlocal ts=8 sw=8 sts=8 noexpandtab
autocmd BufEnter *.py	  setlocal ts=8 sw=8 sts=8 noexpandtab
autocmd BufEnter Makefile setlocal ts=8 sw=8 sts=8 noexpandtab
autocmd BufEnter *.sh	  setlocal ts=8 sw=8 sts=8 noexpandtab nocindent
autocmd BufEnter .*	  setlocal ts=8 sw=8 sts=8 noexpandtab nocindent
autocmd BufEnter *.md	  setlocal ts=8 sw=8 sts=8 noexpandtab nocindent
autocmd FileType python	  set nowrap

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"==========================================================================
"= linux kernel coding style
"==========================================================================
" Set column width to 80
set colorcolumn=81
execute "set colorcolumn=" . join(range(81,335), ',')
highlight ColorColumn ctermbg=Black ctermfg=DarkRed
" No trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
