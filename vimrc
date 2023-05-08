" My options {{
let g:my_vimrc_file = expand('<sfile>:p')
let g:my_vim_dir = fnamemodify(g:my_vimrc_file, ':h')
let g:my_plug_dir = expand(g:my_vim_dir.'/plugged')
let g:my_undodir = expand(g:my_vim_dir.'/undodir')
if !isdirectory(g:my_undodir)
    call mkdir(g:my_undodir, 'p')
endif
let g:my_coc_enabled = executable('node')
if has('termguicolors')
    set termguicolors
    let g:my_colorscheme = 'tokyonight'
    let g:my_statuscolor = 'Tomorrow_Night_Blue'
else
    let g:my_colorscheme = 'gruvbox'
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
set backspace=indent,eol,start  "more freedom over backspacing in insert mode
set visualbell display=lastline virtualedit=block
set autoread  "auto-read file changes outside of vim
set hidden  "hide buffers on leave, allow leaving changed buffers
set nowrap nowrapscan
set nolinebreak   "do not wrap long lines at a character in 'breakat'
set whichwrap=b,s,<,>,[,]  "more freedom to move between lines in normal mode
set suffixes+=.pyc
set tags=./tags;/
set tags+=./tags2;/
set tags+=./tags3;/
set tags+=./tags4;/
set tags+=./tags5;/
if exists('&previewpopup')
    set previewpopup=height:15,width:80
endif
set wildmenu wildchar=<Tab>
set path+=.;  "Look upwards from current directory to find files
set wildignore+=*.class,**/classes/**  "Java, maven
set wildignore+=.hg,.git,.svn  "Version Controls
set wildignore+=*.aux,*.out,*.toc  "Latex Indermediate files
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest  "Compiled Object files
set wildignore+=*.spl  "Compiled splelling world list
set wildignore+=*.sw?  "Vim swap files
set wildignore+=*.DS_Store  "OSX stuff
set wildignore+=*.luac  "Lua byte code
set wildignore+=*.pyc,*/__pycache__/*  "Python Object codes
set wildignore+=*.orig,*.rej  "Merge resolution files
" set completeopt=menuone,longest,preview
set completeopt=menu,preview  "Use vim default completeopt
set complete-=kspell
set complete-=k
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

set list  "Show some hidden chars in listchars
set number relativenumber  "Line numbers
set cursorline  "highlight current line
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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-projectionist'  " project configurations
Plug 'tpope/vim-dispatch'  " run compiler plugin asynchronously
Plug 'godlygeek/tabular'  " align texts with Tabularize command
Plug 'junegunn/vim-easy-align'  " align texts with command :EasyAlign
Plug 'jszakmeister/vim-togglecursor'
Plug 'chrisbra/NrrwRgn'  " call :NR to focus on a selected region
Plug 'christoomey/vim-system-copy'  " use `cp` operator for copy, `cv` operator for paste
Plug 'wesQ3/vim-windowswap'  " swap window buffers
Plug 'tmhedberg/matchit'
Plug 'junegunn/goyo.vim'  " focus zen mode
Plug 'junegunn/limelight.vim'  " focus paragraph
Plug 'easymotion/vim-easymotion'  " enhance movements
Plug 'mbbill/undotree'  " shows undo history as tree structure
Plug 'skywind3000/vim-preview'  " improve preview file
Plug 'tyru/open-browser.vim'  " launch browsers
Plug 'wellle/targets.vim'  " text objects: file, line, function, arguments,...
Plug 'stefandtw/quickfix-reflector.vim'  " reflect quickfix changes in files

" Search tools
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'  " fzf-vim integration
Plug 'mhinz/vim-grepper'  " use multiple grep tools

" Programming
Plug 'scrooloose/nerdtree'  " file explorer
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'  " git integration
Plug 'airblade/vim-gitgutter'  " git status on gutter
Plug 'junegunn/gv.vim'  " git graph view
Plug 'editorconfig/editorconfig-vim'
Plug 's3rvac/AutoFenc'
Plug 'FooSoft/vim-argwrap'  " format long argument list arg1,arg2,arg3,...
Plug 'thinca/vim-quickrun'  " run script files
Plug 'skywind3000/asyncrun.vim'  " run commands asynchronously
Plug 'jpalardy/vim-slime'  " send texts from vim to a REPL
Plug 'itchyny/lightline.vim'  " configurable status line
Plug 'mtth/scratch.vim'  " open scratch buffers with `gs`
Plug 'preservim/tagbar'  " show outline using universal ctags
Plug 'dense-analysis/ale'  " linters
" Language server LSP
if exists('g:my_coc_enabled') && g:my_coc_enabled
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
endif

" Language syntax
Plug 'sheerun/vim-polyglot'  " language packs, include optimized `vim-sleuth` for auto-detect indentation
Plug 'tmhedberg/SimpylFold'  " python code folding
Plug 'kevinoid/vim-jsonc'
Plug 'PProvost/vim-ps1'
Plug 'leafgarland/typescript-vim'

" Colorschemes
Plug 'joshdick/onedark.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
call plug#end()
" }}
" vim:fdm=marker:fmr={{,}}:et:ts=4:sts=4:sw=4
