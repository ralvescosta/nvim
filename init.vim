call plug#begin()
Plug 'scrooloose/nerdtree' " File Explorer
Plug 'dracula/vim' " Theme
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Search
Plug 'junegunn/fzf.vim' " Search
Plug 'neoclide/coc.nvim', {'branch': 'release'} " auto complite
Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {
Plug 'airblade/vim-gitgutter' " show git changes in file
Plug 'Xuyuanp/nerdtree-git-plugin' " show git changes in NERDETree
Plug 'ryanoasis/vim-devicons'

" Highlighting and Indenting to JSX and TSX files.
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

syntax enable
set number
set relativenumber
set background=dark
colorscheme dracula
color dracula
set mouse=a
set encoding=UTF-8

let mapleader="\<space>"

nnoremap <leader>cf :vsplit ~/.config/nvim/init.vim<CR>
nnoremap <leader>sc :source ~/.config/nvim/init.vim<CR>

nnoremap <leader>n :NERDTreeFocus<CR>

nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-p> :Files<CR>
" This command depends Ag daemo
nnoremap <C-f> :Ag<CR>
" nnoremap <C-w> :q<CR>

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]
