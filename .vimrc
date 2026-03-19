filetype plugin indent on   " Ask Vim to load file-specific parameters

syntax on

set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab

noremap <Leader>] :vertical split<CR>:exec("tag ".expand("<cword>"))<CR>

set number
set relativenumber
set hlsearch
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
