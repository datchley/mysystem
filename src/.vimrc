set mouse=a
set number                          " always show line numbers
set clipboard=unnamed				" alias unnamed register to the '+' register, which is the clipboard
set encoding=utf-8					" set character encoding
set termencoding=utf-8
" set fillchars+=stl:\ ,stlnc:\ 

set nowrap                          " don't wrap long lines
set backspace=indent,eol,start      " backspace over everything in insert mode

" Tab/Indention
 set tabstop=4                       " a tab is 4 spaces
 set autoindent                      " turn auto indent on
 set copyindent                      " copy previous indentation on autoindent
 set shiftwidth=4                    " number of spaces to use for autoindenting
 set shiftround                      " use multiple of shiftwidth for indenting with '>' and '<'
 set smarttab                        " insert tabs on start of new line according to shiftwidth, not tabstop
 set expandtab

 " Searching
 set showmatch                       " set show matching parens
 set ignorecase                      " ignore case on search
 set smartcase                       " ignore case if searchpattern is all lower case, cas-sensitive otherwise
 set hlsearch                        " highlight search hits
 set incsearch                       " search as you type


" change the mapleader from \ to ,
 let mapleader=","					 			

 nmap <silent> <leader>/ :nohlsearch<CR>	 	" get rid of prev search highlights
 nmap <silent> <leader>ev	:e $MYVIMRC<CR>		" e .vimrc
 nmap <silent> <leader>sv	:so $MYVIMRC<CR>	" re-source .vimrc

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
set backupskip=/tmp/*,/private/tmp/*

" A useful status line (using airline now)
" set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Toggle for pasting code, don't autoindent
set pastetoggle=<F2>

" color scheme and highlighting
set t_Co=256
if &t_Co >= 256 || has("gui_running")
    " colorscheme desert256
    " colorscheme mustang
    " colorscheme distinguished

    syntax enable
    set background=dark
    " let g:solarized_termcolors=16
    " let g:solarized_termtrans=1
    let g:solarized_visibility = "low"
    colorscheme solarized
    let solarized_usetimer=0
endif
if &t_Co > 2 || has("gui_running")
    syntax on
endif

" Change the Solarized background to dark or light depending upon the time of 
" day (5 refers to 5AM and 17 to 5PM). Change the background only if it is not 
" already set to the value we want.
function! SetSolarizedBackground()
    if strftime("%H") >= 5 && strftime("%H") < 17 
        if &background != 'light'
            set background=light
        endif
    else
        if &background != 'dark'
            set background=dark
        endif
    endif
endfunction

" Call at launch ?
" call SetSolarizedBackground()

" Every time you save a file, call the function to check the time and change 
" the background (if necessary).
" if has("autocmd")
"     autocmd bufwritepost * call SetSolarizedBackground()
" endif

" netrw explorer settings (overridden by NERDTree)
" let g:netrw_liststyle=3		" use tree-mode as default view
" let g:netrw_browse_split=4	" open file in previous buffer
" let g:netrw_preview=1			" preview window in vert split
" let g:netrw_winsize=20		" 20% width of explorer, 80% preview

" IndentLine integration
" let g:indentLine_color_term = 239
" let g:indentLine_color_gui = '#A4E57E'
let g:indentLine_char = '┆'
let g:indentLine_faster = 1
let g:indentLine_enabled = 0
nmap <leader>i :IndentLinesToggle<CR>

" Ack Integration for fuzzy find within file search
let g:ackprg="/opt/local/bin/ack-5.12 -H -s --column "
map <C-S-f>	:Ack<space>

" Airline status line configuration
" let g:airline_theme='dark'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_symbols = 'fancy'
" unicode symbols
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
" let g:airline_section_b = '%{fugitive#head()}'
" let g:airline_section_b = '%{fugitive#statusline()}'
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" NerdTREE configuration
" map <C-n> :NERDTreeToggle<CR>	" Ctrl-n to open/close file explorer
let g:nerdtree_tabs_open_on_console_startup = 1	" open nerdtreetabs on console vim startup
let g:nerdtree_tabs_autoclose = 1				" close current tab if only one and it's nerdtree
" Ctrl-n to open/close file explorer
map <C-n> :NERDTreeTabsToggle<CR>				
nmap <leader>n :NerdTreeFind<CR>

" Tagbar configuration
nmap <leader>t	:TagbarToggle<CR>

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
