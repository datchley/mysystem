set mouse=a
set number                          " always show line numbers
set clipboard=unnamed				" alias unnamed register to the '+' register, which is the clipboard

set nowrap                          " don't wrap long lines
set backspace=indent,eol,start      " backspace over everything in insert mode

" Tab/Indention
 set tabstop=4                       " a tab is 4 spaces
 set autoindent                      " turn auto indent on
 set copyindent                      " copy previous indentation on autoindent
 set shiftwidth=4                    " number of spaces to use for autoindenting
 set shiftround                      " use multiple of shiftwidth for indenting with '>' and '<'
 set smarttab                        " insert tabs on start of new line according to shiftwidth, not tabstop

 " Searching
 set showmatch                       " set show matching parens
 set ignorecase                      " ignore case on search
 set smartcase                       " ignore case if searchpattern is all lower case, cas-sensitive otherwise
 set hlsearch                        " highlight search hits
 set incsearch                       " search as you type
 nmap <silent> ,/ :nohlsearch<CR>

 " Easier window navigation
 map <C-h>	<C-w>h
 map <C-j>	<C-w>j
 map <C-k>	<C-w>k
 map <C-l>	<C-w>l

" Forgot to do 'sudo vim ...', use this while in the file !
cmap w!! w !sudo tee % >/dev/null

" Vim Backups (NO) - use git or svn for this
set nobackup                        " don't make a backup
set noswapfile                      " don't make a .swp/o file

" A useful status line
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" Toggle for pasting code, don't autoindent
set pastetoggle=<F2>

" color scheme and highlighting
set t_Co=256
if &t_Co >= 256 || has("gui_running")
    " colorscheme desert256
    colorscheme mustang
endif
if &t_Co > 2 || has("gui_running")
    syntax on
endif

" netrw explorer settings (overridden by NERDTree)
" let g:netrw_liststyle=3		" use tree-mode as default view
" let g:netrw_browse_split=4	" open file in previous buffer
" let g:netrw_preview=1			" preview window in vert split
" let g:netrw_winsize=20		" 20% width of explorer, 80% preview

" Ack Integration for fuzzy find within file search
let g:ackprg="/opt/local/bin/ack-5.12 -H -s --column "

" NerdTREE configuration
" map <C-n> :NERDTreeToggle<CR>	" Ctrl-n to open/close file explorer
let g:nerdtree_tabs_open_on_console_startup = 1	" open nerdtreetabs on console vim startup
let g:nerdtree_tabs_autoclose = 1				" close current tab if only one and it's nerdtree
" Ctrl-n to open/close file explorer
map <C-n> :NERDTreeTabsToggle<CR>				

" CtrlP configuration
set runtimepath^=~/.vim/bundle/ctrlp.vim			" set runtime path
let g:ctrlp_map = '<C-p>'								" map to Ctrl-P
let g:ctrlp_use_caching=0							" file listings up to date (no reload)
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'	" ignore files for CtrlP
let g:ctrlp_show_hidden = 1							" also fine dot files

" To disable a plugin, put it's name here
" let g:pathogen_disabled = ['syntastic']
set nocp
execute pathogen#infect()
