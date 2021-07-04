if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')

  call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('preservim/nerdtree')
  call dein#add('itchyny/lightline.vim')
  call dein#add('junegunn/fzf.vim')
  call dein#add('elixir-editors/vim-elixir')
  call dein#add('mhinz/vim-mix-format')
  call dein#add('preservim/nerdtree')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

" END DEIN SCRIPTS

let mapleader = ","

set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nowrap
set noswapfile
set nobackup
set incsearch

" File types
autocmd FileType java,kotlin,xml setlocal softtabstop=4 shiftwidth=4 tabstop=4

" Searching
set ignorecase
set smartcase

" Better split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" NERD Tree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" FZF
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>h :History<CR>

let g:loaded_matchparen=1

" Use =j to format the whole buffer as JSON
nmap =j :%!python -m json.tool<CR>:set syntax=json<CR>

" And =x to format as JSON
nmap =x :%!python -c 'import sys;import xml.dom.minidom;s=sys.stdin.read();print(xml.dom.minidom.parseString(s).toprettyxml())'<CR>:set syntax=xml<CR>

set number
set relativenumber

let g:mix_format_on_save = 1

inoremap jj <esc>

" Save files a bunch
:au FocusLost * silent! wa
:set autowrite

