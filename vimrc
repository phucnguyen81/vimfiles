" Init {{
let g:my_basedir = expand('<sfile>:p:h')

let g:my_plugvim = expand(g:my_basedir.'/autoload/plug.vim')
if !filereadable(g:my_plugvim)
    echoerr 'Missing vim-plug autoload file at '.g:my_plugvim
endif

let g:my_pluggeddir = expand(g:my_basedir.'/plugged')
call mkdir(g:my_pluggeddir, "p")

let g:my_plugconfigsdir = expand(g:my_basedir.'/plugconfigs')
call mkdir(g:my_plugconfigsdir, "p")

let g:my_pluginsdir = expand(g:my_basedir.'/myplugins')
call mkdir(g:my_pluginsdir, "p")

let g:my_configsdir = expand(g:my_basedir.'/myconfigs')
call mkdir(g:my_configsdir, "p")

let g:my_snippets = expand(g:my_basedir.'/snippets')
call mkdir(g:my_snippets, "p")

let g:my_vardir = expand(g:my_basedir.'/var')
call mkdir(g:my_vardir, "p")

let g:my_netrw_home = g:my_vardir
call mkdir(g:my_netrw_home, "p")

let g:my_viminfofile = expand(g:my_vardir.'/viminfo')

let g:my_undodir = expand(g:my_vardir.'/undodir')
call mkdir(g:my_undodir, "p")

let g:my_backupdir = expand(g:my_vardir.'/backupdir')
call mkdir(g:my_backupdir, "p")

let g:my_swapfiles = expand(g:my_vardir.'/swapfiles')
call mkdir(g:my_swapfiles, "p")

let g:my_session_dir = expand(g:my_vardir.'/sessions')
call mkdir(g:my_session_dir, "p")

let g:my_nerdtree_bookmarksfile = expand(g:my_vardir.'/NERDTreeBookMarks')

let g:my_fzf_history_dir = expand(g:my_vardir.'/fzf-history')
call mkdir(g:my_fzf_history_dir, "p")

let g:my_scratch_file = expand(g:my_vardir.'/scratch.txt')

let g:my_command_template = expand(g:my_vardir.'/command_template.vim')

let g:my_calendar_dir = expand(g:my_vardir.'/calendar')
call mkdir(g:my_calendar_dir, "p")

let g:my_dict_dir = expand(g:my_basedir.'/dict')
call mkdir(g:my_dict_dir, "p")

let g:my_dict_eng = expand(g:my_dict_dir.'/eng')

" Hint at completion plugins being used, jedi | lsp
let g:my_completion_plugin = ''

" Enable/disable auto-completion at startup
let g:my_auto_completion_on = 1

" Delay in miliseconds during typing before completion kicks in
let g:my_auto_completion_delay = 2000

" Enable autosave at startup
let g:my_auto_save_enable = 1

" }}
" Options {{
let mapleader = "\<space>"
let maplocalleader = ","

if has('termiguicolors')
    set termguicolors
endif
set equalalways splitbelow splitright
set undofile nobackup nowritebackup noswapfile history=1000
let &viminfofile=g:my_viminfofile
exec "set undodir=".g:my_undodir.'//,.'
exec "set backupdir=".g:my_backupdir.'//,.'
exec "set directory=".g:my_swapfiles.'//,.'
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set nofoldenable nojoinspaces formatoptions+=j
set backspace=2
set visualbell display=lastline virtualedit=block
set autoread hidden nowrapscan
set suffixes+=.pyc
set tags=./tags;/
set wildmenu wildchar=<Tab>
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
set completeopt=menu,menuone,preview,noinsert
set complete-=t
set complete-=kspell
set complete-=k
if filereadable(g:my_dict_eng)
    exec 'set dictionary+='.g:my_dict_eng
endif
set noshowmode
set shortmess+=I shortmess+=c shortmess+=t
set signcolumn=yes
if has('mouse')
    set mouse=a
endif
if has('unnamedplus')
    set clipboard=autoselectplus,unnamedplus
else
    set clipboard=autoselect,unnamed
endif
set timeout timeoutlen=1000 ttimeoutlen=100
set updatetime=1000
set encoding=utf-8 fileencoding=utf-8 fileencodings=utf-8
set list
set number relativenumber nocursorline
set incsearch nohlsearch ignorecase smartcase
set laststatus=2 showtabline=2
set showcmd
set cmdheight=1
set sessionoptions-=options sessionoptions-=blank sessionoptions+=help
set viewoptions-=options
set includeexpr=myfun#includeexpr(v:fname)

let python = mypy#pythonthree()
if !empty(python.home)
    let &pythonthreehome = python.home
endif
if !empty(python.dll)
    let &pythonthreedll = python.dll
endif

" }}
" My options {{
exec 'source '.g:my_configsdir.'/my-buffer.vim'
exec 'source '.g:my_configsdir.'/my-colorscheme.vim'
exec 'source '.g:my_configsdir.'/my-command-templates.vim'
exec 'source '.g:my_configsdir.'/my-commandmap.vim'
exec 'source '.g:my_configsdir.'/my-commands.vim'
exec 'source '.g:my_configsdir.'/my-grep.vim'
exec 'source '.g:my_configsdir.'/my-highlight.vim'
exec 'source '.g:my_configsdir.'/my-ide.vim'
exec 'source '.g:my_configsdir.'/my-insertmap.vim'
exec 'source '.g:my_configsdir.'/my-journal.vim'
exec 'source '.g:my_configsdir.'/my-newfile.vim'
exec 'source '.g:my_configsdir.'/my-normalmap.vim'
exec 'source '.g:my_configsdir.'/my-registers.vim'
exec 'source '.g:my_configsdir.'/my-sessions.vim'
exec 'source '.g:my_configsdir.'/my-snippets.vim'
exec 'source '.g:my_configsdir.'/my-source.vim'
exec 'source '.g:my_configsdir.'/my-tab.vim'
exec 'source '.g:my_configsdir.'/my-terminal.vim'
exec 'source '.g:my_configsdir.'/my-visualmap.vim'
exec 'source '.g:my_configsdir.'/my-window.vim'
" }}
" Autocmd {{
augroup my_main_autocmd
    autocmd!
    autocmd VimEnter * let g:netrw_list_hide = join([
      \ '__pycache__', '\.pyc',
      \ '\.DAT$', '\.dat$', '^ntuser',
      \ ], ',')
    autocmd InsertEnter * normal! zz
augroup end
" }}
" My pluggins {{
exec 'source '.expand(g:my_pluginsdir.'/nn.vim')
" }}
" Plugins {{
call plug#begin(g:my_pluggeddir)

Plug 'https://github.com/tpope/vim-sensible.git'
Plug 'https://github.com/tpope/vim-vinegar.git'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-endwise.git'
Plug 'https://github.com/tpope/vim-eunuch.git'
Plug 'https://github.com/tpope/vim-scriptease.git'
Plug 'https://github.com/mhinz/vim-lookup.git'
Plug 'https://github.com/tmhedberg/matchit.git'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/jszakmeister/vim-togglecursor.git'
Plug 'https://github.com/s3rvac/AutoFenc.git'
Plug 'https://github.com/kana/vim-textobj-user.git'
Plug 'https://github.com/kana/vim-textobj-entire.git'
Plug 'https://github.com/kana/vim-textobj-line.git'
Plug 'https://github.com/michaeljsmith/vim-indent-object.git'
Plug 'https://github.com/bps/vim-textobj-python.git'
Plug 'https://github.com/junegunn/goyo.vim.git'
Plug 'https://github.com/amix/vim-zenroom2.git'
Plug 'https://github.com/freitass/todo.txt-vim.git'
exec 'source '.expand(g:my_plugconfigsdir.'/startify.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/abolish.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/easy-align.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/easymotion.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/undotree.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/autosave.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/rooter.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/scratch.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/vim-windowswap.vim')

exec 'source '.expand(g:my_plugconfigsdir.'/nerdtree.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/netrw.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/fzf.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/grepper.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/quickrun.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/tabnine.vim')
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/editorconfig/editorconfig-vim.git'
Plug 'https://github.com/skywind3000/asyncrun.vim.git'
exec 'source '.expand(g:my_plugconfigsdir.'/dispatch.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/ale.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/vim-slime.vim')
Plug 'https://github.com/skywind3000/vim-preview.git'
Plug 'https://github.com/majutsushi/tagbar.git'
exec 'source '.expand(g:my_plugconfigsdir.'/openbrowser.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/investigate.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/vim-system-copy.vim')

exec 'source '.expand(g:my_plugconfigsdir.'/lightline.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/languagepack.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/colorschemes.vim')

call plug#end()
" }}
" vim:fdm=marker:fmr={{,}}:et:ts=4:sts=4:sw=4
