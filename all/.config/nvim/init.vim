" ==============================================================================
"               _           _      __      _______ __  __ _____   _____ 
"         /\   | |         ( )     \ \    / /_   _|  \/  |  __ \ / ____|
"        /  \  | | _____  _|/ ___   \ \  / /  | | | \  / | |__) | |
"       / /\ \ | |/ _ \ \/ / / __|   \ \/ /   | | | |\/| |  _  /| |
"      / ____ \| |  __/>  <  \__ \    \  /   _| |_| |  | | | \ \| |____ 
"     /_/    \_\_|\___/_/\_\ |___/     \/   |_____|_|  |_|_|  \_\\_____|
"
" ==============================================================================

" Vundle configuration
set nocompatible
filetype off
set runtimepath+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin("~/.config/nvim/bundle")
Plugin 'VundleVim/Vundle.vim'           " Vundle manages itself
Plugin 'vim-airline/vim-airline'        " A nice buffer line
Plugin 'godlygeek/tabular'              " Align text by given characters
Plugin 'kshenoy/vim-signature'          " Show marks in the gutter
Plugin 'mhinz/vim-signify'              " Git/hg status in the gutter
Plugin 'tpope/vim-fugitive'             " Other git bits e.g. status in airline
Plugin 'sickill/vim-monokai'            " A dark colorscheme
Plugin 'cormacrelf/vim-colors-github'   " A light colorscheme
Plugin 'vim-scripts/sablecc.vim'        " Colour for sablecc (polyglot)
call vundle#end()
filetype plugin indent on

" Indentation Options
set tabstop=4               " Set tab width to 4
set expandtab               " Always use spaces instead of tabs
set softtabstop=4           " Insert 4 spaces when tab is pressed
set shiftwidth=4            " An indent is always 4 spaces
set smarttab                " Indent instead of tab at the start of a line
set shiftround              " Round spaces to the nearest shiftwidth multiple
set nojoinspaces            " Don't convert spaces to tabs
set breakindent             " Indent soft-wrapped lines
set breakindentopt=shift:0  " Amount to indent soft-wrapped lines
set showbreak=....          " Show this text on indented soft-wrapped lines

" General settings
syntax on               " Enable syntax highlighting.
set guioptions=a        " Disable menu bar & toolbar in gvim
set number              " Show line numbers at launch
colorscheme monokai     " github theme also installed for when light is required
set virtualedit=block   " Allow movement past the EOL in visual block mode
set wrapmargin=0        " Do not hard-wrap automatically
set hidden              " Allow hiding of unsaved modified buffers
set showmatch           " Breifly highlight the matching brackets on insertion
set mouse=n             " Preffered mouse settings
set pastetoggle=<F2>    " Toggle paste mode with F2
set visualbell t_vb=    " Disable bells
set laststatus=2        " Status bar always
set updatetime=100      " Required by signify (git/hg gutter status)
set colorcolumn=80      " Ruler at 80 characters
set hidden              " Allow hiding of unsaved modified buffers
set ignorecase          " Ignore case in search...
set smartcase           " unless search contains uppercase or \C escape sequence
set display=lastline    " Don't hide any wrapped lines

" Airline stuff
let g:airline#extensions#tabline#enabled = 1               " Enable buffer line
let g:airline#extensions#tabline#left_alt_sep = ' '        " No trailing | char
let g:airline#extensions#tabline#formatter = 'unique_tail' " Tab title style

" Highlight hard tabs
highlight SpecialKey ctermfg=1
set list
set listchars=tab:\>\ 

" WildMenu Options
set wildmenu
set wildmode=longest,list
set wildignore+=*.o,*.hi,*.swp,*.pyc,*.class,*.aux,*.dvi,*.bbl,*.blg,*.pdf

" KEYBINDINGS
" Cycle buffers
nnoremap <silent> <tab> :bnext<CR>
nnoremap <silent> <S-tab> :bprevious<CR>
" Disable ex-mode bindings
nnoremap Q <nop>
nnoremap q: <nop>
" Show buffers
nnoremap <C-K> :buffers<CR>:b<Space>
cnoremap <C-K> <C-U><Esc><CR>

" Command to toggle spell-check
command! SpellToggle setlocal spell! spelllang=en_gb

" Put swap-files in a convenient location
set directory^=$HOME/.config/nvim/swapfiles//

" Jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
\ | exe "normal! g'\"" | endif

" Use SableCC highlighting for polyglot-related files
autocmd BufRead,BufNewFile *.polyglot    set filetype=sablecc
autocmd BufRead,BufNewFile *.productions set filetype=sablecc
autocmd BufRead,BufNewFile *.tokens      set filetype=sablecc
autocmd BufRead,BufNewFile *.helpers     set filetype=sablecc

" Enable spell checking by default in tex, md, txt, adoc
autocmd Filetype tex  setlocal spell spelllang=en_gb
autocmd Filetype md   setlocal spell spelllang=en_gb
autocmd Filetype txt  setlocal spell spelllang=en_gb
autocmd Filetype adoc setlocal spell spelllang=en_gb

" Source a local config file if it exists
if filereadable(expand("~/.init.vim.local"))
  exe 'source' "~/.init.vim.local"
endif
