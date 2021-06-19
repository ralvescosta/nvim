call plug#begin()
Plug 'scrooloose/nerdtree' " File Explorer
Plug 'dracula/vim' " Theme
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " busca
Plug 'junegunn/fzf.vim' " busca
call plug#end()

syntax enable
set number
set relativenumber
set background=dark
colorscheme dracula
color dracula
set mouse=a


let mapleader="\<space>"

nnoremap <leader>cf :vsplit ~/.config/nvim/init.vim<CR>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>

nnoremap <leader>n :NERDTreeFocus<CR>

nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-p> :Files<CR>
" This command depends Ag daemo
nnoremap <C-f> :Ag<CR>
nnoremap <C-w> :q<CR>
