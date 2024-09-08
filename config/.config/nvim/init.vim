call plug#begin('~/.vim/plugged')
  " aesthetics
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
  Plug 'itchyny/lightline.vim'
  Plug 'folke/noice.nvim'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'rcarriga/nvim-notify'
  " javascript
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'pangloss/vim-javascript'
  " focus
  Plug 'junegunn/goyo.vim'
  " git support 
  Plug 'tpope/vim-fugitive'
  " edit helper tools
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  " lsp
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
  Plug 'williamboman/nvim-lsp-installer'
  " go support
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  " java/kt support
  Plug 'mfussenegger/nvim-jdtls'
  Plug 'williamboman/mason.nvim'
  " interactive file tree navigation
  Plug 'preservim/nerdtree'
  " much better than marks
  Plug 'nvim-lua/plenary.nvim'
  Plug 'ThePrimeagen/harpoon'
  " telescope
  Plug 'nvim-telescope/telescope.nvim'
  " treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " markdown
  " Plug 'godlygeek/tabular'
  " Plug 'preservim/vim-markdown'
  " Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
  " obsidian
  Plug 'epwalsh/obsidian.nvim'
call plug#end()

lua require('aronkof/init')

" custom commands
command W w
command Q q
command Wq wq
command WQ wq
command Qa qa
command QA qa

command Vimcfg :e ~/.config/nvim/init.vim
command Rvim :source ~/.config/nvim/init.vim

" leader,file and window commands
let mapleader="\<Space>"
let maplocalleader="\<Space>"
imap <M-j> <esc>
vmap <M-j> <esc>

nmap <M-s> <nop>
nmap - zz
nnoremap <leader><leader> zz
nmap { {k
nmap } }j
nmap <M-[> [{
nmap <M-]> ]}
nmap <C-[> za
nmap <C-]> zo

vmap <M-s> <esc>
vmap $ g_
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" focus
nnoremap <leader>= :Goyo 80%+10%x100%<CR>
nnoremap <leader>- :Goyo!<CR>

" surround remap
nmap S ys

" file tree - minimal implementation
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <M-e> :NERDTreeFind<CR>
autocmd FileType nerdtree nnoremap <buffer> e <nop>
autocmd FileType nerdtree nnoremap <buffer> <M-e> <nop>
autocmd FileType nerdtree nnoremap <buffer> <leader>ff :wincmd l<CR>
autocmd FileType nerdtree nnoremap <buffer> <leader><leader> :wincmd l<CR>

let g:NERDTreeWinSize=40

" common sets
syntax on
set ignorecase
set smartcase
filetype plugin on
set nocompatible
set encoding=utf-8
set nowrap
set formatoptions-=t
set noerrorbells
set smartindent
set nu
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set nohlsearch
set splitbelow
set rnu
  
" folding
set nofoldenable
set foldmethod=manual
nmap <esc> <nop>

" theme
colorscheme catppuccin
let g:lightline = {
    \ 'colorscheme': 'catppuccin',
    \ 'active': {
    \   'left': [ [ 'mode' ],
    \             [ 'gitbranch', 'filename' ] ],
    \   'right':  [ [ 'lineinfo' ],
    \            [ 'filetype' ] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'LLgitbranch',
    \   'mode': 'LLmode',
    \   'filename': 'LLfilename',
    \   'filetype': 'LLfiletype'
    \ },
    \ 'inactive': {
    \   'right': []
    \ }
    \ }

function! LLgitbranch()
  return &filetype ==# 'netrw' ? '' : FugitiveHead()
endfunction

function! LLmode()
  return &filetype ==# 'netrw' ? '' : lightline#mode()
endfunction

function! LLfilename()
  return &filetype ==# 'netrw' ? 'netrw' : expand('%:t')
endfunction

function! LLfiletype()
  return &filetype ==# 'netrw' ? '' : &filetype
endfunction

" relative line numbering
nnoremap <Bslash> :setlocal relativenumber!<CR>

set t_Co=256
set laststatus=2
set cursorline
set guicursor=
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

" copy and paste
set clipboard=unnamedplus

" avoid messing the clipboard with these commands
nnoremap _d d
vnoremap _d d
nnoremap d "xd
vnoremap d "xd
nnoremap D "xD
vnoremap D "xD
nnoremap x "xx
vnoremap x "xx
nnoremap s "xs
vnoremap s "xs
nnoremap c "xc
vnoremap c "xc
nnoremap C "xC
vnoremap C "xC

" mapping to enable moving lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

" temp scratch pad markdown
nnoremap <leader>T :split /tmp/scratchpad.md <bar> resize 15<CR>

" Go
let g:go_textobj_enabled=0
nnoremap <leader>e :!go run /tmp/main.go<CR>
nnoremap <leader>t :e /tmp/main.go<CR>


" Markdown setup
autocmd FileType markdown set conceallevel=2
autocmd FileType markdown normal zR
let g:markdown_recommended_style = 0
let g:markdown_folding = 1

" gq settings
set textwidth=120
set formatoptions-=t

" interacitve shell sessions - to enable userspace aliases and functions
set shellcmdflag=-c

let g:goyo_linenr = 1 
let g:goyo_width = 120
let g:goyo_height = 100

" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>

" harpoon
nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>o :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>4 :lua require("harpoon.ui").nav_file(4)<CR>

nnoremap <leader>9 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>0 :lua require("harpoon.ui").nav_file(4)<CR>

" lsp diag toggler
nmap <leader>tld  <Plug>(toggle-lsp-diag)
