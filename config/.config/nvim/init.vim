call plug#begin('~/.vim/plugged')
  " aesthetics
  Plug 'morhetz/gruvbox'
  Plug 'itchyny/lightline.vim'
  " javascript
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'pangloss/vim-javascript'
  " focus
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
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
  " go support
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  " clojure support
  Plug 'Olical/conjure'
  Plug 'tpope/vim-dispatch'
  Plug 'clojure-vim/vim-jack-in'
  Plug 'radenling/vim-dispatch-neovim'
  Plug 'guns/vim-sexp'
  " markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
  " interactive file tree navigation
  Plug 'preservim/nerdtree'
  " much better than marks
  Plug 'nvim-lua/plenary.nvim'
  Plug 'ThePrimeagen/harpoon'
  " telescope
  Plug 'nvim-telescope/telescope.nvim'
  " treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'p00f/nvim-ts-rainbow'
call plug#end()

lua require('aronkof/init')

" LSP autoformat
autocmd FileType clojure autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()
autocmd FileType clojure,scheme,lisp,timl call s:vim_sexp_mappings()

let g:sexp_filetypes = ''

function! s:vim_sexp_mappings()
  nmap <silent><buffer> (               <Plug>(sexp_move_to_prev_bracket)
  xmap <silent><buffer> (               <Plug>(sexp_move_to_prev_bracket)
  omap <silent><buffer> (               <Plug>(sexp_move_to_prev_bracket)
  nmap <silent><buffer> )               <Plug>(sexp_move_to_next_bracket)
  xmap <silent><buffer> )               <Plug>(sexp_move_to_next_bracket)
  omap <silent><buffer> )               <Plug>(sexp_move_to_next_bracket)
  nmap <silent><buffer> <M-b>           <Plug>(sexp_move_to_prev_element_head)
  xmap <silent><buffer> <M-b>           <Plug>(sexp_move_to_prev_element_head)
  omap <silent><buffer> <M-b>           <Plug>(sexp_move_to_prev_element_head)
  nmap <silent><buffer> <M-w>           <Plug>(sexp_move_to_next_element_head)
  xmap <silent><buffer> <M-w>           <Plug>(sexp_move_to_next_element_head)
  omap <silent><buffer> <M-w>           <Plug>(sexp_move_to_next_element_head)
  nmap <silent><buffer> <M-e>           <Plug>(sexp_move_to_next_element_tail)
  xmap <silent><buffer> <M-e>           <Plug>(sexp_move_to_next_element_tail)
  omap <silent><buffer> <M-e>           <Plug>(sexp_move_to_next_element_tail)
  nmap <silent><buffer> <LocalLeader>i  <Plug>(sexp_round_head_wrap_list)
  xmap <silent><buffer> <LocalLeader>i  <Plug>(sexp_round_head_wrap_list)
  nmap <silent><buffer> <LocalLeader>I  <Plug>(sexp_round_tail_wrap_list)
  xmap <silent><buffer> <LocalLeader>I  <Plug>(sexp_round_tail_wrap_list)
  nmap <silent><buffer> <LocalLeader>[  <Plug>(sexp_square_head_wrap_list)
  xmap <silent><buffer> <LocalLeader>[  <Plug>(sexp_square_head_wrap_list)
  nmap <silent><buffer> <LocalLeader>]  <Plug>(sexp_square_tail_wrap_list)
  xmap <silent><buffer> <LocalLeader>]  <Plug>(sexp_square_tail_wrap_list)
  nmap <silent><buffer> <LocalLeader>{  <Plug>(sexp_curly_head_wrap_list)
  xmap <silent><buffer> <LocalLeader>{  <Plug>(sexp_curly_head_wrap_list)
  nmap <silent><buffer> <LocalLeader>}  <Plug>(sexp_curly_tail_wrap_list)
  xmap <silent><buffer> <LocalLeader>}  <Plug>(sexp_curly_tail_wrap_list)
  nmap <silent><buffer> <LocalLeader>w  <Plug>(sexp_round_head_wrap_element)
  xmap <silent><buffer> <LocalLeader>w  <Plug>(sexp_round_head_wrap_element)
  nmap <silent><buffer> <LocalLeader>W  <Plug>(sexp_round_tail_wrap_element)
  xmap <silent><buffer> <LocalLeader>W  <Plug>(sexp_round_tail_wrap_element)
endfunction

" Nubank REPL command
command Repl :Lein with-profile +dev trampoline repl :headless
command REPL :Repl
command REPLA :Lein catalyst-repl

" custom commands
command W w
command Q q
command Wq wq
command WQ wq
command Qa qa
command QA qa

command Vimcfg :e ~/.config/nvim/init.vim

" leader,file and window commands
let mapleader="\<Space>"
let maplocalleader="\<Space>"
nmap = zz

" *EXPERIMENTAL*
imap jj <esc>

nnoremap tj :tabnext<CR>
nnoremap tk :tabprevious<CR>

nnoremap <leader><leader> <C-^>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" focus
nnoremap <leader>= :Goyo<CR>

" surround remap
nmap S ys

" terminal
set splitright
tnoremap jj <c-\><c-n>
tnoremap <leader><leader> :tabprev<CR>
nnoremap <A-t> :tabnew<Bar>:term<CR>:set nonu<Bar>:set nornu<CR>

" file tree - minimal implementation
nnoremap <C-e> :NERDTreeToggle<CR>

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
  
" folding
set foldmethod=syntax
set foldlevelstart=99
set foldopen-=block

" theme (gruvbox)
set background=dark
colorscheme gruvbox
let g:lightline = {
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

" gui and compatibility
if !has('gui_running')
  set t_Co=256
endif

set laststatus=2
set cursorline
set guicursor=
set t_Co=256
hi Normal ctermbg=235
hi LineNr ctermfg=darkgrey ctermbg=NONE
hi ColorColumn ctermbg=238
hi SignColumn ctermbg=NONE
hi EndOfBuffer ctermfg=NONE ctermbg=NONE
hi CursorLineNr ctermbg=NONE
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

" Markdown setup
autocmd FileType markdown set conceallevel=0
autocmd FileType markdown normal zR
let g:vim_markdown_new_list_item_indent = 0
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css='/home/aronk/.config/nvim/github-markdown.css'

" Limelight setup
let g:limelight_conceal_ctermfg=240
nnoremap <leader>- :Limelight!!<CR>

" gq settings
set textwidth=120
set formatoptions-=t

" interacitve shell sessions - to enable userspace aliases and functions
set shellcmdflag=-ic

" toggle relative number 'style'
let s:rnu_enabled = 1
function! ToggleRnuStyle()
    if s:rnu_enabled
        set rnu
        let s:rnu_enabled = 0
    else
        set nornu
        let s:rnu_enabled = 1
    endif
endfunction
nnoremap <leader>rn :call ToggleRnuStyle()<CR>

let g:goyo_linenr = 1 
let g:goyo_width = 200

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

lua << EOF
require'telescope'.setup({
    defaults = {
        file_ignore_patterns = { "^./.git/", "./node_modules/*", "./vendor/*" },
    }
})
EOF
