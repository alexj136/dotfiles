" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Load Pathogen (package manager).
execute pathogen#infect()
call pathogen#helptags()

" Enable syntax highlighting.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well.
set background=dark

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
  \ | exe "normal! g'\"" | endif
endif

" Load indentation rules and plugins according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Spell-checking for txt, md and tex files
autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_au
autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_au
autocmd BufNewFile,BufRead *.tex setlocal spell spelllang=en_au

" ===================
" Indentation Options
" ===================

set tabstop=4     " Set tab width to 4
set expandtab     " Always use spaces instead of tabs
set softtabstop=4 " Insert 4 spaces when tab is pressed
set shiftwidth=4  " An indent is always 4 spaces
set smarttab      " Indent instead of tab at the start of a line
set shiftround    " Round spaces to the nearest shiftwidth multiple
set nojoinspaces  " Don't convert spaces to tabs

" ===================
" Appearence Settings
" ===================

" Enable ruler.
set colorcolumn=81

" Disable menu bar & toolbar in gvim
set guioptions=a

" Font for gvim
set guifont=Inconsolata\ 11

" Show line numbers at launch
set nu

" Wrap long lines only between separate words, do not wrap within a word
set wrap lbr

" Color schemes - if we're in gvim, or a terminal that supports 256 colors,
" use molokai. Otherwise, use the default color scheme.
if has ("gui_running")
  colorscheme solarized
elseif match ($TERM, "xterm-256color")  != -1 ||
     \ match ($TERM, "xterm")           != -1 ||
     \ match ($TERM, "screen-256color") != -1
  set t_Co=256
  colorscheme solarized
else
  colorscheme default
endif

" ================
" WildMenu Options
" ================

if has ("wildmenu")
    set wildmenu
    set wildmode=longest,full
    set wildignore+=*.o,*.hi,*.swp,*.pyc,*.class,*.aux,*.log,*.dvi
endif

" ============
" Key Bindings
" ============

" Move cursor with display lines
map j gj
map k gk

" Scroll through tabs with Ctrl + n/p, and scroll buffers with Ctrl N/P.
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

" ==================
" bufferline options
" ==================

" Enable the status line
set laststatus=2

" Put buffer info in the status line
let g:bufferline_echo = 0
autocmd VimEnter * let &statusline='%{bufferline#refresh_status()}'
    \ .bufferline#get_status_string()

let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_show_bufnr = 0
