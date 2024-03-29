" My options {{
let g:my_vimrc_file = expand('<sfile>:p')
let g:my_vim_dir = expand(fnamemodify(g:my_vimrc_file, ':h'))
let g:my_session_dir = expand(g:my_vim_dir.'/session')
let g:my_plug_dir = expand(g:my_vim_dir.'/plugged')
let g:my_plug_init = !isdirectory(g:my_plug_dir)
let g:my_undodir = expand(g:my_vim_dir.'/undodir')
let g:my_shell = empty($MY_SHELL) ? &shell : $MY_SHELL

if !empty($MY_SECRETS) && isdirectory($MY_SECRETS)
    let g:my_secrets_dir = expand($MY_SECRETS)
    if filereadable(expand(g:my_secrets_dir.'/secrets.json'))
        let g:my_secrets = json_decode(join(readfile(expand(g:my_secrets_dir.'/secrets.json')), "\n"))
    endif
endif

if !empty($MY_BASE) && isdirectory($MY_BASE)
    let g:my_base = expand($MY_BASE)
elseif !empty($BASE) && isdirectory($BASE)
    let g:my_base = expand($BASE)
else
    let g:my_base = g:my_vim_dir
endif

let g:my_todosdir = expand(g:my_base.'/todos')
call mkdir(g:my_todosdir, 'p')

let g:my_notesdir = expand(g:my_base.'/notes')
call mkdir(g:my_notesdir, 'p')

let g:my_bookmarks = expand(g:my_notesdir.'/bookmarks.csv')

let g:my_journal = expand(g:my_base.'/journal')
call mkdir(g:my_journal, 'p')

let g:my_minai = expand(g:my_base.'/minai')
call mkdir(g:my_minai, 'p')

if !empty(&pythonthreedll) && filereadable(expand(g:my_vim_dir.'/pythonthreehome/'.&pythonthreedll))
    let &pythonthreehome = expand(g:my_vim_dir.'/pythonthreehome')
    let &pythonthreedll = expand(&pythonthreehome.'/'.&pythonthreedll)
endif
if !isdirectory(g:my_undodir)
    call mkdir(g:my_undodir, 'p')
endif
if has('termguicolors')
    set termguicolors
    let g:my_colorscheme = 'onedark'
    let g:my_statuscolor = 'Tomorrow_Night_Blue'
else
    let g:my_colorscheme = 'catppuccin'
    let g:my_statuscolor = 'Tomorrow_Night_Blue'
endif
" }}
" Vim options {{
let mapleader = "\<space>"
let maplocalleader = "\<space>"

set equalalways splitbelow splitright
set nobackup nowritebackup noswapfile history=1000
set undofile
if exists('g:my_undodir') && isdirectory(g:my_undodir)
    let &undodir=g:my_undodir.'//,.'
endif
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
set nofoldenable nojoinspaces formatoptions+=j
set backspace=indent,eol,start  " Don't ever stop my backspace
set visualbell display=lastline virtualedit=block
set autoread  " Auto-read file changes outside of vim
set hidden  " Hide buffers on leave, allow leaving changed buffers
set nowrap nowrapscan
set nolinebreak   "do not wrap long lines at a character in 'breakat'
set whichwrap=b,s,<,>,[,]  "more freedom to move between lines in normal mode
if exists('&previewpopup')
    set previewpopup=height:15,width:80
endif
set suffixes+=.pyc  " De-prioritize some file extensions
set path-=/usr/include  " Don't search for C header files
set path+=.;  " Search upwards from current directory
set completeopt=menu,preview  " How to complete in insert mode
set complete-=kspell  " Don't complete from spell files
set complete-=k  " Don't complete from dictionaries
set wildmenu wildchar=<Tab>
set wildignore+=*.class,**/classes/**  " Java, maven
set wildignore+=.hg,.git,.svn  " Version Controls
set wildignore+=*.aux,*.out,*.toc  " Latex Indermediate files
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest  " Compiled Object files
set wildignore+=*.spl  " Compiled splelling world list
set wildignore+=*.sw?  " Vim swap files
set wildignore+=*.DS_Store  " OSX stuff
set wildignore+=*.luac  " Lua byte code
set wildignore+=*.pyc,*/__pycache__/*  " Python Object codes
set wildignore+=*.orig,*.rej  " Merge resolution files
set noshowmode
set shortmess+=I shortmess+=c shortmess+=t
set signcolumn=auto  "Show sign column if there is a sign to display
if has('mouse')
    set mouse=a
endif
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif
set timeout timeoutlen=1000 ttimeoutlen=100
set updatetime=1000
set encoding=utf-8
set fileencoding=utf-8 fileencodings=utf-8

" Don't use forward slashes when expanding filenames.
" Have to turn this off for vim-plug to work correctly with cmd.exe terminal.
set noshellslash

set list  " show some hidden chars in listchars
set number relativenumber  "Line numbers
set nocursorline  " don't highlight current line
set incsearch nohlsearch ignorecase smartcase
set scrolloff=8
set laststatus=2 showtabline=2
set showcmd
set cmdheight=1
set sessionoptions-=options  "don't save options and mappings
set sessionoptions-=blank    "don't save emtpy windows
set sessionoptions+=help     "save help windows
set viewoptions-=options
" }}
" Plugins  {{
call plug#begin(g:my_plug_dir)
" Utilities
Plug 'mhinz/vim-startify'  " dashboard: recent files, sessions, commands
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-speeddating'
Plug 'jszakmeister/vim-togglecursor'
Plug 'christoomey/vim-system-copy'  " use `cp` operator for copy, `cv` operator for paste
Plug 'wesQ3/vim-windowswap'  " swap window buffers
Plug 'tmhedberg/matchit'
Plug 'mbbill/undotree'  " shows undo history as tree structure
Plug 'skywind3000/vim-preview'  " improve preview file
Plug 'tyru/open-browser.vim'  " launch browsers
Plug 'stefandtw/quickfix-reflector.vim'  " reflect quickfix changes in files

" Plain texts
Plug 'easymotion/vim-easymotion'  " enhance movements
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rsi'
Plug 'chrisbra/NrrwRgn'  " call :NR to focus on a selected region
Plug 'tommcdo/vim-exchange'
Plug 'wellle/targets.vim'  " text objects: file, line, function, arguments,...
Plug 'kana/vim-textobj-user'  " text object common for kana plugins
Plug 'kana/vim-textobj-entire'  " text object entire buffer
Plug 'godlygeek/tabular'  " align texts with Tabularize command
Plug 'junegunn/vim-easy-align'  " align texts with command :EasyAlign
Plug 'junegunn/goyo.vim'  " focus zen mode
Plug 'junegunn/limelight.vim'  " focus paragraph

" Search tools
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'  " fzf-vim integration
Plug 'mhinz/vim-grepper'  " use multiple grep tools
Plug 'tpope/vim-dispatch'  " run compiler plugin asynchronously

" Programming
Plug 'scrooloose/nerdtree'  " file explorer
Plug 'mcchrish/nnn.vim'  " integrate with nnn file manager
Plug 'qpkorr/vim-renamer'  " batch file renamer
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'  " git integration
Plug 'whiteinge/diffconflicts'  " merge git conflicts
Plug 'airblade/vim-gitgutter'  " git status on gutter
Plug 'junegunn/gv.vim'  " git graph view
Plug 'editorconfig/editorconfig-vim'
Plug 's3rvac/AutoFenc'
Plug 'FooSoft/vim-argwrap'  " format long argument list arg1,arg2,arg3,...
Plug 'thinca/vim-quickrun'  " run script files
Plug 'skywind3000/asyncrun.vim'  " run commands asynchronously
Plug 'jpalardy/vim-slime'  " send texts from vim to a REPL
Plug 'itchyny/lightline.vim'  " configurable status line
Plug 'dense-analysis/ale'  " linters
Plug 'ap/vim-css-color'  " live preview css colors

" Language syntax
Plug 'sheerun/vim-polyglot'  " language packs, include optimized `vim-sleuth` for auto-detect indentation
Plug 'tmhedberg/SimpylFold'  " python code folding
Plug 'kevinoid/vim-jsonc'
Plug 'PProvost/vim-ps1'
Plug 'leafgarland/typescript-vim'
Plug 'Scuilion/markdown-drawer'
Plug 'chrisbra/csv.vim'
Plug 'NoahTheDuke/vim-just'

" Colorschemes
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'sainnhe/everforest'  " green-based color scheme
Plug 'junegunn/seoul256.vim'
Plug 'lifepillar/vim-gruvbox8'  " a better gruvbox
Plug 'joshdick/onedark.vim'
call plug#end()

" Install plugins if they are not available
if exists('g:my_plug_init') && g:my_plug_init
    :PlugInstall
endif
" }}
" vim:fdm=marker:fmr={{,}}:et:ts=4:sts=4:sw=4
