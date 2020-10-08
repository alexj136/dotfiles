" =========================================
" ALEX'S VIMRC
" =========================================

" Vundle configuration
set nocompatible
filetype off
set runtimepath+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin("~/.config/nvim/bundle")
Plugin 'VundleVim/Vundle.vim'           " Vundle manages itself
Plugin 'godlygeek/tabular'              " Align text by given characters
Plugin 'kshenoy/vim-signature'          " Show marks in the gutter
Plugin 'airblade/vim-gitgutter'         " Git status in the gutter
Plugin 'tpope/vim-fugitive'             " Other git bits
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
colorscheme github      " monokai theme also installed for when dark is required
set virtualedit=block   " Allow movement past the EOL in visual block mode
set wrapmargin=0        " Do not hard-wrap automatically
set hidden              " Allow hiding of unsaved modified buffers
set showmatch           " Breifly highlight the matching brackets on insertion
set mouse=n             " Preffered mouse settings
set pastetoggle=<F2>    " Toggle paste mode with F2
set visualbell t_vb=    " Disable bells
set laststatus=2        " Status bar always
set updatetime=100      " Required by gitgutter
set colorcolumn=80      " Ruler at 80 characters
set hidden              " Allow hiding of unsaved modified buffers
set ignorecase          " Ignore case in search...
set smartcase           " unless search contains uppercase or \C escape sequence
set display=lastline    " Don't hide any wrapped lines

" status: file modified git ___ [line/total:column] bufno
set statusline=\ %f\ %m\ %{FugitiveStatusline()}%=%l/%L:%c\ %8p%%\ 

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

" Use SableCC highlighting for files with .polyglot or .productions extensions
autocmd BufRead,BufNewFile *.polyglot    set filetype=sablecc
autocmd BufRead,BufNewFile *.productions set filetype=sablecc

" Enable spell checking by default in tex, md, txt, adoc
autocmd Filetype tex  setlocal spell spelllang=en_gb
autocmd Filetype md   setlocal spell spelllang=en_gb
autocmd Filetype txt  setlocal spell spelllang=en_gb
autocmd Filetype adoc setlocal spell spelllang=en_gb
