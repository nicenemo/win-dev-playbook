"" This disables compatibility with VI and older behaviour on VIM.
set nocompatible

set autoindent                                    " Maintain indent of current line.
set backspace=indent,start,eol                    " Allow unrestricted backspacing in insert mode.

if exists('$SUDO_USER')
  set nobackup                                    " Don't create root-owned files.
  set nowritebackup                               " Don't create root-owned files.
else
"set nobackup                            " This is recommended by coc
"set nowritebackup                       " This is recommended by coc
  set backupdir=~/.local/share/nvim/tmp/backup    " Keep backup files out of the way.
  set backupdir+=.
endif

if has('wildignore')
    set backupskip+=*.re,*.rei                      " Revent bsb's watch mode from getting confused.
endif

if exists('$SUDO_USER')
  set noswapfile                                    " Don't create root-owned files.
else
  set directory=~/.local/share/nvim/tmp/swap//     " Keep swap files out of the way.
  set directory+=.
endif

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                                  " Don't create root-owned files.
  else
    set undodir=~/.local/share/nvim/tmp/undo        " Keep undo files out of the way.
    set undodir+=.
    set undofile                                    " Actually use undo files.
  endif
endif

if has('viminfo') " ie. Vim.
  let s:viminfo='viminfo'
elseif has('shada') " ie. Neovim.
  let s:viminfo='shada'
endif

if exists('s:viminfo')
  if exists('$SUDO_USER')
    " Don't create root-owned files.
    execute 'set ' . s:viminfo . '='
  else
    " Defaults:
    "   Neovim: !,'100,<50,s10,h
    "   Vim:    '100,<50,s10,h
    "
    " - ! save/restore global variables (only all-uppercase variables)
    " - '100 save/restore marks from last 100 files
    " - <50 save/restore 50 lines from each register
    " - s10 max item size 10KB
    " - h do not save/restore 'hlsearch' setting
    "
    " Our overrides:
    " - '0 store marks for 0 files
    " - <0 don't save registers
    " - f0 don't store file marks
    " - n: store in ~/.vim/tmp
    "
    execute 'set ' . s:viminfo . "='100,n$HOME/.local/share/nvim/files/" . s:viminfo

    if !empty(glob('~/.local/share/nvim/files/' . s:viminfo))
      if !filereadable(expand('~/.local/share/nvim/files/' . s:viminfo))
        echoerr 'warning: ~/.local/share/vim/files/' . s:viminfo . ' exists but is not readable'
      endif
    endif
  endif
endif

if has('mksession')
  set viewdir=~/.local/share/nvim/tmp/view        " override ~/.vim/view default
  set viewoptions=cursor,folds                    " save/restore just these (with `:{mk,load}view`)
endif

set updatecount=80                                " Update swapfiles every 80 typed chars.
set updatetime=2000                               " CursorHold interval

if has('virtualedit')
  set virtualedit=block                           " Allow cursor to move where there is no text in visual 
                                                  " block mode.
endif

set visualbell t_vb=                              " Stop annoying beeping for non-error errors.
set whichwrap=b,h,l,s,<,>,[,],~                   " Allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line 
                                                  " boundaries.
set wildcharm=<C-z>                               " Substitute for 'wildchar' (<Tab>) in macros.
if has('wildignore')
  set wildignore+=*.o,*.rej                       " Patterns to ignore during file-navigation.
endif
if has('wildmenu')
    set wildmenu                                  " show options as list when switching buffers etc.
endif
set wildmode=longest:full,full                    " Shell-like autocomplete to unambiguousortion.

if exists('&belloff')
  set belloff=all                                 " Never ring a bell.
endif

if has('linebreak')
  set breakindent                                 " Indent wrapped lines to match start.
  if exists('&breakindentopt')
    set breakindentopt=shift:2                    " Emphasize broken lines by indenting them.
  endif
endif

if has('folding')
  if has('window')
    set fillchars=diff:∙                          " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    set fillchars+=fold:·                         " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    set fillchars+=vert:┃                         " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
  set foldmethod=indent                           " Faster than using syntax.
  set foldlevel=99                                " Start unfolded.
endif

" By default use spaces instead of tabs.
" Use an indent of 2.
set shiftwidth=2
set tabstop=2
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set showtabline=2                       " Always show tabs

set cursorline                          " Enable highlighting of the current line
set noemoji                                       " Do not assume all emoji are double width.
set diffopt+=foldcolumn:0                         " Don't show fold column in diff view.

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j                            " Remove comment leader when joining comment lines.
endif

set formatoptions+=n                  " smart auto-indenting inside numbered lists
set guioptions-=T                     " don't show toolbar
set hidden                            " allows you to hide buffers with unsaved changes without being prompted

if !has('nvim')
  " Sync with corresponding nvim :highlight commands in ~/.vim/plugin/autocmds.vim:
  set highlight+=@:Conceal            " ~/@ at end of window, 'showbreak'
  set highlight+=D:Conceal            " override DiffDelete
  set highlight+=N:FoldColumn         " make current line number stand out a little
  set highlight+=c:LineNr             " blend vertical separators with line numbers
endif

if exists('&inccommand')
  set inccommand=split                " livereview of :s results
endif

set laststatus=2                      " always show status line
set lazyredraw                        " don't bother updating screen during macrolayback

if has('linebreak')
  set linebreak                       " wrap long lines at characters in 'breakat'
endif

set list                              " show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set modelines=5                       " scan this many lines looking for modeline
set nojoinspaces                      " don't autoinsert two spaces after '.', '?', '!' for join command
set number                            " show line numbers 

if exists('+relativenumber')
  set relativenumber                  " show relative numbers in gutter
endif

set scrolloff=5                       " start scrolling 3 lines before edge of viewport
set shell=zsh                         " shell to use for `!`, `:!`, `system()` etc.
set noshiftround                      " don't always indent by multiple of shiftwidth
set shiftwidth=2                      " spaceser tab (when shifting)
set shortmess+=A                      " ignore annoying swapfile messages
set shortmess+=I                      " no splash screen
set shortmess+=O                      " file-read message overwritesrevious
set shortmess+=T                      " truncate non-file messages in middle
set shortmess+=W                      " don't echo "[w]"/"[written]" when writing
set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
if has('patch-7.4.314')
  set shortmess+=c                    " completion messages
endif
set shortmess+=o                      " overwrite file-written messages
set shortmess+=t                      " truncate file messages at start

if has('linebreak')
  let &showbreak='↳ '                 " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif

if has('showcmd')
  set noshowcmd                       " don't show extra info at end of command line
endif

set sidescrolloff=5                   " same as scrolloff, but for columns
set smarttab                          " <tab>/<BS> indent/dedent in leading whitespace

if v:progname !=# 'vi'
  set softtabstop=-1                  " use 'shiftwidth' for tab/bs at end of line
endif

if has('syntax')
  syntax enable                           " Enables syntax highlighing
  set spellcapcheck=                  " don't check for capital letters at start of sentence
endif

if has('windows')
  set splitbelow                      " open horizontal splits below current window
endif

if has('vertsplit')
  set splitright                      " open vertical splits to the right of the current window
endif

if exists('&swapsync')
  set swapsync=                       " let OS sync swapfiles lazily
endif
set switchbuf=usetab                  " try to reuse windows/tabs when switching buffers

if has('syntax')
  set synmaxcol=200                   " don't bother syntax highlighting long lines
endif

set tabstop=2                         " spaceser tab
set textwidth=80                      " automatically hard wrap at 80 columns

"" Load syntax highlighting, indentation and a filetype specific plugin if
"" available.
filetype indent plugin on

" Show the mode that is currently active.
set showmode

" Integrate with OS clipboard, if possible.
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Set scrollofset to 5
" This makes zt/zb not go all the way to top or bottom but 5 lines from it.
set scrolloff=5

if filereadable('/usr/local/bin/python3')
  " Avoid search, speeding up start-up.
  let g:python3_host_prog='/usr/local/bin/python3'
endif

set spelllang=en_gb,nl
set spellfile=~/.config/nvim/spell/en.utf-8.add
set complete+=kspell
autocmd BufRead,BufNewFile *.md setlocal spell

set laststatus=2
" set leader keys
let g:mapleader = "\<Space>"
let g:localleader = "\\"

"set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			" Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
"set t_Co=256                           " Support 256 colors
set termguicolors                       " Use more color
set conceallevel=0                      " So that I can see `` in markdown files
set background=dark                     " tell vim what the background color looks like
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
" set formatoptions-=cro                " Stop newline continution of comments
"set autochdir                           " Your working directory will always be the same as your working directory

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vim alternatively you can run :source $MYVIMRC
