colors ir_black

set nocompatible
set backspace=indent,eol,start
set history=64
set ruler
set noeol

set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

if has("autocmd")
  augroup fedora
  autocmd!
"       <!-- In text files, always limit the width of text to 78 characters -->
  autocmd BufRead *.txt set tw=78
"       <!-- When editing a file, always jump to the last cursor position -->
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
  autocmd FileType scheme :let is_gauche=1
  if filereadable('~/.gosh_completions')
    autocmd FileType scheme set complete+=k~/.gosh_completions
  endif
  autocmd BufNewFile,BufRead *.clj set filetype=lisp
endif

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


filetype plugin on

