let mapleader = " "

filetype plugin indent on   " Ask Vim to load file-specific parameters



syntax on

set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab

noremap <Leader>] :rightbelow vsplit<CR>:execute "tag " . expand("<cword>")<CR>
noremap <Leader>[ :rightbelow vsplit<CR>:execute "tag " . expand("<cword>")<CR><C-w>h

set number
set relativenumber
set hlsearch
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set splitright

" ============================================================================
" НАСТРОЙКА NERDTREE
" ============================================================================

" Установка vim-plug (если ещё не установлен)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Плагины
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'                    " Файловый менеджер
Plug 'Xuyuanp/nerdtree-git-plugin'           " Показывает git-статус в NERDTree
Plug 'ryanoasis/vim-devicons'                " Иконки (опционально, нужен шрифт)

call plug#end()

" ============================================================================
" ОСНОВНЫЕ НАСТРОЙКИ NERDTREE
" ============================================================================

" Горячие клавиши
nnoremap <Leader>e :NERDTreeToggle<CR>        " пробел + e - открыть/закрыть
nnoremap <Leader>f :NERDTreeFind<CR>           " пробел + f - найти текущий файл

" Внешний вид
let NERDTreeShowHidden = 1                     " Показывать скрытые файлы
let NERDTreeMinimalUI = 1                      " Минимальный интерфейс (без инструкций)
let NERDTreeDirArrows = 1                      " Стрелки для директорий
let NERDTreeWinSize = 40                        " Ширина окна (можно изменить)
let NERDTreeAutoDeleteBuffer = 1                " Автоудаление буферов закрытых файлов

" Показывать номера строк в NERDTree
let NERDTreeShowLineNumbers = 1
" Наследовать настройки нумерации из основного Vim
augroup nerdtree_numbering
    autocmd!
    autocmd BufEnter,WinEnter nerdtree* if &number | setlocal relativenumber number | endif
augroup END

" ============================================================================
" ЧТО ИГНОРИРОВАТЬ В NERDTREE (ОЧЕНЬ ВАЖНО ДЛЯ KERNEL)
" ============================================================================

let NERDTreeIgnore = [
    \ '\~$',
    \ '\.o$',
    \ '\.ko$',
    \ '\.cmd$',
    \ '\.d$',
    \ '\.tmp$',
    \ '\.mod$',
    \ '\.mod\.c$',
    \ '\.mod\.o$',
    \ '\.order$', 
    \ '\.symvers$',
    \ 'Module\.symvers$',
    \ 'modules\.builtin$',
    \ '\.git$',
    \ '\.idea$',
    \ '\.vscode$',  
    \ '__pycache__$',
    \ '\.pyc$'
    \ ]

