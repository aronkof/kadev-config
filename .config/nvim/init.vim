call plug#begin('~/.vim/plugged')
  Plug 'morhetz/gruvbox'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
call plug#end()

" custom command behavior
  cmap W w
  cmap Q q
  
" leader,file and window commands
  let mapleader="\<Space>"
  imap jj <esc>
  nnoremap <leader>] :tabnext<CR>
  nnoremap <leader>[ :tabprevious<CR>
  nnoremap <leader><leader> <C-^>
  nnoremap <leader>h :wincmd h<CR>
  nnoremap <leader>j :wincmd j<CR>
  nnoremap <leader>k :wincmd k<CR>
  nnoremap <leader>l :wincmd l<CR>

  " close every buffer except the current one (will discard all unsaved
  " changes)
  nnoremap <leader>ca :w<bar>%bd!<bar>e#<bar>bd#<CR>

" terminal
  set splitright
  tnoremap jj <c-\><c-n>
  nnoremap <A-t> :vsp terminal<CR>:term<CR>:set nonu<bar>set nornu<bar>vertical resize 80<CR>

" file tree - minimal implementation
  nnoremap <C-e> :Lex <Bar> vertical resize 40<CR>
  nnoremap <leader>re :let @/=expand("%:t") <Bar> execute ':Lex' expand("%:h") <CR>
  let g:netrw_keepdir=0
  let g:netrw_liststyle=3
  let g:netrw_banner=0
  let g:netrw_winsize=20

" file create/rename
  function! RenameFile()
      let old_name = expand('%')
      let new_name = input('New file name: ', expand('%'), 'file')
      if new_name != '' && new_name != old_name
          exec ':saveas ' . new_name
          exec ':silent !rm ' . old_name
          redraw!
      endif
  endfunction
  map <leader>rf :call RenameFile()<cr>


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
  set colorcolumn=122
  set expandtab
  set smarttab
  set shiftwidth=2
  set softtabstop=2
  set tabstop=2
  set nohlsearch
  
" folding
  set foldmethod=syntax
  set foldlevelstart=99


" theme (gruvbox)
  set noshowmode
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
  set cursorline
  set guicursor=
  set t_Co=256
  hi Normal ctermbg=235
  hi LineNr ctermfg=darkgrey ctermbg=NONE
  hi ColorColumn ctermbg=238
  hi SignColumn ctermbg=NONE
  hi EndOfBuffer ctermfg=NONE ctermbg=NONE
  hi CursorLineNr ctermbg=NONE
  hi CocErrorSign ctermbg=NONE ctermfg=167
  hi CocWarningSign ctermbg=NONE ctermfg=214
  hi CocInfoSign ctermbg=NONE ctermfg=214
  hi CocHintSign ctermbg=NONE
  set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

" copy and paste
  set clipboard+=unnamedplus
  nnoremap _d d
  vnoremap _d d
  nnoremap d "xd
  vnoremap d "xd
  nnoremap <A-j> :m .+1<CR>==
  nnoremap <A-k> :m .-2<CR>==

" ### PLUGIN/DEPENDENCIES SETUP ### "
" coc binds
  nmap <leader>gd <Plug>(coc-definition)
  nmap <leader>gr <Plug>(coc-references)
  nmap <leader>gt <Plug>(coc-type-definition)
  nmap <leader>gi <Plug>(coc-implementation)
  nmap <leader>rn <Plug>(coc-rename)

" coc setup
  set cmdheight=2
  let g:coc_global_extensions = [ 'coc-go', 'coc-json', 'coc-tsserver', 'coc-eslint', 'coc-prettier' ]
  set hidden
  set updatetime=300

" file and text wide project search
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --glob "!.git/*" --glob "!node_modules/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
  nnoremap <leader>ps :Find<SPACE>
  nnoremap <C-p> :Files<CR>
  if executable('rg')
    let g:rg_derive_root='true'
  endif


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
nnoremap <leader>gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Markdown setup
autocmd FileType markdown set conceallevel=0
autocmd FileType markdown normal zR
let g:vim_markdown_new_list_item_indent = 0
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css='/home/aronk/.config/nvim/github-markdown.css'

" Limelight setup
let g:limelight_conceal_ctermfg=240

" gq settings
set textwidth=120
set formatoptions-=t
