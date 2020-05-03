" Set runtimepath {{
function! s:VimVarDir(name) abort
    if !exists('g:my_vim_vardir')
        return ''
    endif
    if empty(a:name)
        return g:my_vim_vardir
    endif
    let path = expand(g:my_vim_vardir.'/'.a:name)
    if !isdirectory(path)
        call mkdir(path, 'p')
    endif
    return path
endfunction

function! s:VimVarFile(name) abort
    if !exists('g:my_vim_vardir')
        return ''
    endif
    if empty(a:name)
        throw 'Empty file name'
    endif
    let path = expand(g:my_vim_vardir.'/'.a:name)
    let dir = fnamemodify(path, ':p:h')
    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif
    return path
endfunction

let s:this_dir = expand('<sfile>:p:h')
let g:my_vim_vardir = expand(simplify(s:this_dir.'/var'))
if !isdirectory(g:my_vim_vardir)
    call mkdir(g:my_vim_vardir)
endif
let g:my_netrw_home = s:VimVarDir('')
let g:my_viminfofile = s:VimVarFile('viminfo')
let g:my_undodir = s:VimVarDir('undodir')
let g:my_backupdir = s:VimVarDir('backupdir')
let g:my_swapfiles = s:VimVarDir('swapfiles')
let g:my_session_dir = s:VimVarDir('sessions')
let g:my_nerdtree_bookmarksfile = s:VimVarFile('NERDTreeBookMarks')
let g:my_fzf_history_dir = s:VimVarDir('fzf-history')
let g:my_scratch_file = s:VimVarFile('scratch.txt')
let g:my_command_template = s:VimVarFile('command_template.vim')
let g:my_calendar_dir = s:VimVarDir('calendar')
" }}
" Initial options {{

" For a paranoia.
" Normally ':set nocp' is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
    " ':set nocp' has many side effects. Therefore this should be done
    " only when 'compatible' is set.
    set nocompatible
endif

" Turn on filetype detection (trigger FileType event)
filetype on
" Load ftplugin for the filetype detected (e.g. fortran.vim)
filetype plugin on
" Load indent.vim in 'runtimepath' for filetype indent
filetype indent on

" Turn on syntax highlighting, see syntax-enable
syntax enable

" Neet to set leader keys before any mappings.
let mapleader = "\<space>"
let maplocalleader = "\\"

" }}
" My options {{

" Hint at completion plugins being used.
" Options: jedi | lsp
let g:my_completion_plugin = ''

" Enable/disable auto-completion at startup
let g:my_auto_completion_on = 1

" Delay in miliseconds during typing before completion kicks in
let g:my_auto_completion_delay = 2000

" Enable autosave at startup
let g:my_auto_save_enable = 1

" Snippets directory
if isdirectory(expand('~/mydoc/snippets'))
    let g:my_snippets = expand('~/mydoc/snippets')
endif

" Dictionary for completion with <C-x><C-k>
if filereadable(expand('~/assets/dict/words'))
    let g:my_dictionary = expand('~/assets/dict/words')
endif

" }}
" Autocmd {{
augroup my_autocmd
    autocmd!
    autocmd InsertEnter * norm zz
augroup end
" }}
" Common options {{

" Split windows
set equalalways
set splitbelow splitright

" Save viminfo on exit
" '100  :  save marks for up to 100 files
" f1    :  save global marks (0, 1, 2,...)
" :100  :  save up to 100 lines of command-line history
" "500  :  save up to 500 lines for each register
set viminfo='100,f1,:100,"500
if exists('g:my_viminfofile')
    let &viminfofile=g:my_viminfofile
endif

" Maximum number of commands and search patterns to keep, see viminfo
set history=1000

" Whether or not to persist undo history
set undofile
if exists('g:my_undodir') && isdirectory(g:my_undodir)
    exec "set undodir=".g:my_undodir.'//,.'
endif

" Whether or not to make backup before overwriting files
set nobackup nowritebackup
if exists('g:my_backupdir') && isdirectory(g:my_backupdir)
    exec "set backupdir=".g:my_backupdir.'//,.'
endif

" Whether or not to create swap files
set noswapfile
if exists('g:my_swapfiles') && isdirectory(g:my_swapfiles)
    exec "set directory=".g:my_swapfiles.'//,.'
endif

" number of spaces shown for a tab
set tabstop=4
" number of spaces inserted/removed for a tab
set softtabstop=4
" number of spaces inserted/removed for a single indentation
set shiftwidth=4
" Do smart autoindenting when starting a new line
set smartindent
" insert spaces for tab
set expandtab
" <tab> at start of line is based on 'shiftwidth', not 'tabstop'
set smarttab
" round indent to multiple of 'shiftwidth'
set shiftround

" j: remove comment headers when joining comment lines
set formatoptions+=j

" Whether to insert two spaces instead of one space
" after joining lines that end with a '.', '?', or '!'
set nojoinspaces

" Don't start with fold
set nofoldenable

" prefer visual bell over beeping
set visualbell

" let backspace delete autoindent, line breaks, start of insert
set backspace=2

" show as much as possible the last-line in the window
set display=lastline

" In Visual block mode, allow to select a rectangle that covers places without characters
set virtualedit=block

" Leave buffer without saving, this is needed in some useful plugins
set hidden

" Reload buffer on file change detection
set autoread

" Searches do not wrap around buffers
set nowrapscan

" Where to look for files with :find, gf, etc.
set path+=.,,

" Files with these suffixes get a lower priority when multiple files
" match a wildcard.
set suffixes+=.pyc

" Look in the current directory for "tags",
" if not found keep waling up directory tree
set tags=./tags;/

" Character to trigger autocompletion
set wildchar=<Tab>

" Show a menu for auto-completion
set wildmenu

" Enable autocompletion in command mode
" longest: complete till longest common string
" list: show all matches
" full: complete the next full match
set wildmode=longest,list,full

" Ignore these in some file completion scenarios
set wildignore+=*.class,**/classes/** "Java, maven"
set wildignore+=.hg,.git,.svn " Version Controls"
set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.spl "Compiled splelling world list"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.DS_Store "OSX SHIT"
set wildignore+=*.luac "Lua byte code"
set wildignore+=*.pyc "Python Object codes"
set wildignore+=*.orig,*.rej "Merge resolution files"

" Set up completion
"
" Complete line: <C-x><C-l>
" Complete with dictionary: <C-x><C-k>
" Complete file names: <C-x><C-f>
" Omni-comletion: <C-x><C-o>
" User-defined completion: <C-x><C-u>
" Complete tag: <C-x><C-]>
" Context-aware word completion: <C-x><C-p> and <C-x><C-n>

" How to do completion with <C-n> or <C-p>
set completeopt=menu,menuone,preview,noinsert

" Completion from tags is slow
set complete-=t
" Completion from spell files is not useful
set complete-=kspell
" Completion from dictionary is not useful
set complete-=k

" Dictionary words completed with <C-x><C-k>
if exists('g:my_dictionary') && isdirectory(g:my_dictionary)
    exec 'set dictionary+='.fnameescape(g:my_dictionary)
endif

" Whether to show current mode
set noshowmode

" Don't show the introductory message
set shortmess+=I
" Don't pass messages to |ins-completion-menu|
set shortmess+=c
" Truncate file message if it is too long to fit on the command-line
set shortmess+=t

" Always show the signcolumn to preserve space for diagnostics
set signcolumn=yes

" Enable mouse
if has('mouse')
    set mouse=a
endif

if has('unnamedplus')
    set clipboard=autoselectplus,unnamedplus
else
    set clipboard=autoselect,unnamed
endif

" Do not change working directory automatically.
set noautochdir

" Logically break long lines at characters in breakat
set linebreak

" timeout: enable timeout on :mappings and key codes
" timeoutlen: timeout on :mappings
" ttimeoutlen: timeout on key codes
set timeout timeoutlen=1000 ttimeoutlen=100

" How often swap files and CursorHold occur
set updatetime=1000

" Don't flash on matching parentheses
set noshowmatch

" Time to show matching parans in tenths of second.
" Only neded if 'showmatch' is on.
" The default is 5 which feels a bit long.
set matchtime=3

" Encoding used inside vim
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" See differences between tabs and spaces
set list

" What characters to show for tabs, trailing spaces, ect.
" (source: tpope dot files)
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
    let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
    let &fillchars = "vert:\u259a,fold:\u00b7"
else
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<
endif

" Don't hightlight current line
set nocursorline
" No line numbers
set nonumber norelativenumber

" For performance, do not redraw screen too often.
" Force redraw with :redraw.
set lazyredraw

" Search options for /, ?, *, #,...
set incsearch nohlsearch
set ignorecase smartcase
" set noignorecase nosmartcase

" Always show status line even if there is only one window
set laststatus=2
" Always show tab line even if there is only one window
set showtabline=2

" Show partial command (size of selection) at bottom-right corner
set showcmd

" Set number of screen lines for the command-line
set cmdheight=1

" Don't save options, mappings
set sessionoptions-=options
" Don't save empty buffers
set sessionoptions-=blank
" Save position of the whole Vim window
set sessionoptions+=winpos
" Save help buffers
set sessionoptions+=help

set viewoptions-=options

" Custom function to resolve file name under cursor.
set includeexpr=myfun#includeexpr(v:fname)

" Set python home and dll
let python = mypy#pythonthree()
if !empty(python.home)
    let &pythonthreehome = python.home
endif
if !empty(python.dll)
    let &pythonthreedll = python.dll
endif

" }}
" Plugins {{

" Load plugins using vim-plug
" Requires: ./plug.vim
" See: https://github.com/junegunn/vim-plug

" By default, plugins go to '~/vimfiles/plugged' for Windows and
" '~/.vim/plugged' for Linux
call plug#begin()

" Essentials
Plug 'https://github.com/junegunn/fzf.git'
Plug 'https://github.com/junegunn/fzf.vim.git'
Plug 'https://github.com/907th/vim-auto-save.git'
Plug 'https://github.com/tpope/vim-vinegar.git'
Plug 'https://github.com/airblade/vim-rooter.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/mtth/scratch.vim.git'
Plug 'https://github.com/terryma/vim-expand-region.git'
Plug 'https://github.com/tmhedberg/matchit.git'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/tpope/vim-repeat.git'
" Plug 'https://github.com/mhinz/vim-startify.git'
Plug 'https://github.com/skywind3000/vim-preview.git'
Plug 'https://github.com/easymotion/vim-easymotion.git'
Plug 'https://github.com/mbbill/undotree.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-abolish.git'
Plug 'https://github.com/tpope/vim-endwise.git'
Plug 'https://github.com/tpope/vim-eunuch.git'
Plug 'https://github.com/s3rvac/AutoFenc.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/jistr/vim-nerdtree-tabs.git'
" vim-misc is required for other plugins
Plug 'https://github.com/xolox/vim-misc.git'
" Text objects
Plug 'https://github.com/kana/vim-textobj-entire.git'
Plug 'https://github.com/kana/vim-textobj-line.git'
Plug 'https://github.com/kana/vim-textobj-user.git'
Plug 'https://github.com/michaeljsmith/vim-indent-object.git'
Plug 'https://github.com/bps/vim-textobj-python.git'

" Additional
Plug 'https://github.com/jszakmeister/vim-togglecursor.git'
Plug 'https://github.com/wesQ3/vim-windowswap.git'

" Office Utilities
" Plug 'https://github.com/itchyny/calendar.vim.git'
Plug 'https://github.com/freitass/todo.txt-vim.git'
" Distraction-free writing (markdown, texts, ...)
Plug 'https://github.com/junegunn/goyo.vim.git'
Plug 'https://github.com/amix/vim-zenroom2.git'

" Status bar
Plug 'https://github.com/itchyny/lightline.vim.git'

" Sessions
" Plug 'https://github.com/xolox/vim-session.git'

" Tags
if executable('ctags')
    Plug 'https://github.com/vim-scripts/taglist.vim.git'
endif
Plug 'https://github.com/majutsushi/tagbar.git'

" Vimscript
Plug 'https://github.com/tpope/vim-scriptease.git'
Plug 'https://github.com/mhinz/vim-lookup.git'

" Collection of language packs (syntax, indent, completion, compiler,...)
" => use this as a reference
" Plug 'https://github.com/sheerun/vim-polyglot.git'

" Powershell
Plug 'https://github.com/PProvost/vim-ps1.git'

" Javascript
Plug 'https://github.com/othree/yajs.vim.git'
Plug 'https://github.com/HerringtonDarkholme/yats.vim.git'
Plug 'https://github.com/othree/javascript-libraries-syntax.vim.git'
" Plug 'https://github.com/pangloss/vim-javascript.git'
" Plug 'https://github.com/leafgarland/typescript-vim.git'
" Plug 'https://github.com/Quramy/tsuquyomi.git'

" Html
Plug 'https://github.com/othree/html5.vim.git'

" Improved json syntax highlight
Plug 'https://github.com/elzr/vim-json.git'
" Support comments in json
Plug 'https://github.com/kevinoid/vim-jsonc.git'

" Markdown
" Plug 'https://github.com/tpope/vim-markdown.git'
" Plug 'https://github.com/nelstrom/vim-markdown-folding.git'

" Python
" jedi-vim requires python dll on path;
" look at :version to see what dll version is required.
" Plug 'https://github.com/davidhalter/jedi-vim.git'

" Integration
Plug 'https://github.com/sgur/vim-editorconfig.git'
Plug 'https://github.com/tyru/open-browser.vim.git'
Plug 'https://github.com/keith/investigate.vim.git'
Plug 'https://github.com/mhinz/vim-grepper.git'
Plug 'https://github.com/thinca/vim-quickrun.git'
Plug 'https://github.com/skywind3000/asyncrun.vim.git'
Plug 'https://github.com/tpope/vim-dispatch.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
" NOTE: ale conflicts with fugitive when doing Gdiff.
" Currently ale is disabled in buffer used for &diff.
Plug 'https://github.com/w0rp/ale.git'
Plug 'https://github.com/jpalardy/vim-slime.git'
" Copy/paste system clipboard using external commands.
" Use `cp` operator for copy, `cv` operator for paste.
Plug 'https://github.com/christoomey/vim-system-copy.git'

" Tabnine auto-completion (using ML/Deep-learning)
if has('python3_compiled') && (has('python3_dynamic') || has('python3'))
    Plug 'https://github.com/codota/tabnine-vim.git'
endif

" Colors/themes
Plug 'https://github.com/xolox/vim-colorscheme-switcher.git'
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'https://github.com/NLKNguyen/papercolor-theme.git'
Plug 'https://github.com/junegunn/seoul256.vim.git'
Plug 'https://github.com/romainl/flattened.git'
Plug 'https://github.com/nightsense/carbonized.git'
Plug 'https://github.com/arcticicestudio/nord-vim.git'
Plug 'https://github.com/jeffkreeftmeijer/vim-dim.git'
Plug 'https://github.com/mhartington/oceanic-next.git'

call plug#end()
" }}
" vim:foldmethod=marker:foldmarker={{,}}
