
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

