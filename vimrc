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

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
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

" Settings for pathogen
execute pathogen#infect()
call pathogen#helptags() " Generate helptags for everything in 'runtimepath'

" ===================
" Indentation Options
" ===================

:set tabstop=4     " Set tab width to 4
:set expandtab     " Always use spaces instead of tabs
:set softtabstop=4 " Insert 4 spaces when tab is pressed
:set shiftwidth=4  " An indent is always 4 spaces
:set smarttab      " Indent instead of tab at the start of a line
:set shiftround    " Round spaces to the nearest shiftwidth multiple
:set nojoinspaces  " Don't convert spaces to tabs

" ===================
" Appearence Settings
" ===================

" Disable menu bar & toolbar in gvim
:set guioptions=a

" Font for gvim
":set guifont=Droid\ Sans\ Mono\ 10
:set guifont=Inconsolata\ 11

" Show line numbers at launch
:set nu

" Wrap long lines only between separate words, do not wrap within a word
:set wrap lbr

" Color schemes (separate vim/gvim)
if has ("gui_running")
  colorscheme molokai
elseif match ($TERM, "xterm-256color")  != -1 ||
     \ match ($TERM, "xterm")           != -1 ||
     \ match ($TERM, "screen-256color") != -1
  set t_Co=256
  colorscheme molokai
else
  colorscheme default
endif

" ============
" Key Bindings
" ============

" English spellchecking - toggle with F6
:nnoremap <F6> :call ToggleSpellCheck()<CR>

let s:spellCheckActive = 0 

function! ToggleSpellCheck()
  if s:spellCheckActive == 0
    echo "Spell-Checking ON"
    let s:spellCheckActive = 1 
  else
    echo "Spell-Checking OFF"
    let s:spellCheckActive = 0 
  endif
  setlocal spell! spelllang=en_gb
endfunction

" Enable toggling of NERDTree with F4
:map <F4> :NERDTreeToggle<CR>

" Run make with F11, make clean with F12
:nnoremap <F11> :!make<CR>
:nnoremap <F12> :!make clean<CR>

" Highlight characters past column 80. Toggle with F5
:nnoremap <F5> :call ToggleHighlightLongLines()<CR>

:match Search '\%>80v.\+'
let s:highlightActive = 1 

function! ToggleHighlightLongLines()
  if s:highlightActive == 0
    echo "Highlight Long Lines ON"
    let s:highlightActive = 1 
    match Search '\%>80v.\+'
  else
    echo "Highlight Long Lines OFF"
    let s:highlightActive = 0 
    match none
  endif
endfunction

" Scroll through tabs with Ctrl + n/p, and scroll buffers with Ctrl N/P.
:nnoremap <C-A-n> :bnext<CR>
:nnoremap <C-A-p> :bprevious<CR>
:nnoremap <C-n> :tabnext<CR>
:nnoremap <C-p> :tabprevious<CR>
