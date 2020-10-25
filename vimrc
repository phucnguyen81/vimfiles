" My options {{
let g:my_basedir = expand('<sfile>:p:h')

let g:my_plugvim = expand(g:my_basedir.'/autoload/plug.vim')
if !filereadable(g:my_plugvim)
    echoerr 'Missing vim-plug autoload file at '.g:my_plugvim
endif

let g:my_docdir = expand(g:my_basedir.'/doc')
if !isdirectory(g:my_docdir)
    call mkdir(g:my_docdir, "p")
endif

let g:my_pluggeddir = expand(g:my_basedir.'/plugged')
if !isdirectory(g:my_pluggeddir)
    call mkdir(g:my_pluggeddir, "p")
endif

let g:my_plugconfigsdir = expand(g:my_basedir.'/plugconfigs')
if !isdirectory(g:my_plugconfigsdir)
    call mkdir(g:my_plugconfigsdir, "p")
endif

let g:my_pluginsdir = expand(g:my_basedir.'/myplugins')
if !isdirectory(g:my_pluginsdir)
    call mkdir(g:my_pluginsdir, "p")
endif

let g:my_configsdir = expand(g:my_basedir.'/myconfigs')
if !isdirectory(g:my_configsdir)
    call mkdir(g:my_configsdir, "p")
endif

let g:my_snippets = expand(g:my_basedir.'/snippets')
if !isdirectory(g:my_snippets)
    call mkdir(g:my_snippets, "p")
endif

let g:my_templates = expand(g:my_basedir.'/templates')
if !isdirectory(g:my_templates)
    call mkdir(g:my_templates, "p")
endif

let g:my_vardir = expand(g:my_basedir.'/var')
if !isdirectory(g:my_vardir)
    call mkdir(g:my_vardir, "p")
endif

let g:my_doing_file = expand(g:my_vardir.'/doing.md')

let g:my_netrw_home = g:my_vardir
if !isdirectory(g:my_netrw_home)
    call mkdir(g:my_netrw_home, "p")
endif

let g:my_viminfofile = expand(g:my_vardir.'/viminfo')

let g:my_undodir = expand(g:my_vardir.'/undodir')
if !isdirectory(g:my_undodir)
    call mkdir(g:my_undodir, "p")
endif

let g:my_backupdir = expand(g:my_vardir.'/backupdir')
if !isdirectory(g:my_backupdir)
    call mkdir(g:my_backupdir, "p")
endif

let g:my_swapfiles = expand(g:my_vardir.'/swapfiles')
if !isdirectory(g:my_swapfiles)
    call mkdir(g:my_swapfiles, "p")
endif

let g:my_session_dir = expand(g:my_vardir.'/sessions')
if !isdirectory(g:my_session_dir)
    call mkdir(g:my_session_dir, "p")
endif

let g:my_nerdtree_bookmarksfile = expand(g:my_vardir.'/NERDTreeBookMarks')

let g:my_fzf_default_command = ''
if executable('fd')
    " Ignore files with ~/.fdignore
    let g:my_fzf_default_command = 'fd --no-ignore-vcs'
endif
let g:my_fzf_history_dir = expand(g:my_vardir.'/fzf-history')
if !isdirectory(g:my_fzf_history_dir)
    call mkdir(g:my_fzf_history_dir, "p")
endif

let g:my_scratch_file = expand(g:my_vardir.'/scratch.txt')

let g:my_command_template = expand(g:my_vardir.'/command_template.vim')

let g:my_calendar_dir = expand(g:my_vardir.'/calendar')
if !isdirectory(g:my_calendar_dir)
    call mkdir(g:my_calendar_dir, "p")
endif

let g:my_dict_dir = expand(g:my_basedir.'/dict')
if !isdirectory(g:my_dict_dir)
    call mkdir(g:my_dict_dir, "p")
endif

let g:my_dict_eng = expand(g:my_dict_dir.'/words_eng.txt')

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
set autoread hidden wrap nowrapscan
set suffixes+=.pyc
set tags=./tags;/
set tags+=./tags2;/
set tags+=./tags3;/
set tags+=./tags4;/
set tags+=./tags5;/
set wildmenu wildchar=<Tab>
set wildignore+=*.class,**/classes/** "Java, maven"
set wildignore+=.hg,.git,.svn " Version Controls"
set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.spl "Compiled splelling world list"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.DS_Store "OSX stuff"
set wildignore+=*.luac "Lua byte code"
set wildignore+=*.pyc,*/__pycache__/* "Python Object codes"
set wildignore+=*.orig,*.rej "Merge resolution files"
set completeopt=menuone,longest,preview
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
" Integrate with python3
if filereadable($VIM_PYTHONTHREE_DLL)
    let &pythonthreedll = $VIM_PYTHONTHREE_DLL
    let &pythonthreehome = fnamemodify($VIM_PYTHONTHREE_DLL, ':h')
endif
" }}
" My configs {{
exec 'source '.expand(g:my_configsdir.'/my-arglist.vim')
exec 'source '.expand(g:my_configsdir.'/my-buffer.vim')
exec 'source '.expand(g:my_configsdir.'/my-command-templates.vim')
exec 'source '.expand(g:my_configsdir.'/my-commandmap.vim')
exec 'source '.expand(g:my_configsdir.'/my-commands.vim')
exec 'source '.expand(g:my_configsdir.'/my-grep.vim')
exec 'source '.expand(g:my_configsdir.'/my-highlight.vim')
exec 'source '.expand(g:my_configsdir.'/my-ide.vim')
exec 'source '.expand(g:my_configsdir.'/my-insertmap.vim')
exec 'source '.expand(g:my_configsdir.'/my-journal.vim')
exec 'source '.expand(g:my_configsdir.'/my-newfile.vim')
exec 'source '.expand(g:my_configsdir.'/my-normalmap.vim')
exec 'source '.expand(g:my_configsdir.'/my-project.vim')
exec 'source '.expand(g:my_configsdir.'/my-registers.vim')
exec 'source '.expand(g:my_configsdir.'/my-sessions.vim')
exec 'source '.expand(g:my_configsdir.'/my-snippets.vim')
exec 'source '.expand(g:my_configsdir.'/my-source.vim')
exec 'source '.expand(g:my_configsdir.'/my-tab.vim')
exec 'source '.expand(g:my_configsdir.'/my-terminal.vim')
exec 'source '.expand(g:my_configsdir.'/my-visualmap.vim')
exec 'source '.expand(g:my_configsdir.'/my-window.vim')
" }}
" Autocmd {{
augroup my_main_autocmd
    autocmd!
    autocmd VimEnter * call <SID>OnVimEnter()
    autocmd VimLeave * call <SID>OnVimLeave()
augroup end

function s:OnVimEnter() abort
    " Set netrw_list_hide here since it is set somewhere else before vimenter
    let g:netrw_list_hide = join([
      \ '__pycache__', '\.pyc',
      \ '\.DAT$', '\.dat$', '^ntuser',
      \ ], ',')

    " Set colorscheme, should be called only once during startup
    set background=dark
    silent! colorscheme gruvbox
endfunction

function s:OnVimLeave() abort
    " Save session for current directory
    let curdir = getcwd()
    let parentdir = fnamemodify(curdir, ':h:t')
    let session = parentdir.'_'.fnamemodify(curdir, ':t')
    let session_file = expand(g:my_session_dir.'/'.session)
    exec 'mksession! '.fnameescape(session_file)

    " Save as latest session
    let latest_session = expand(g:my_session_dir.'/most-recent')
    exec 'mksession! '.fnameescape(latest_session)
endfunction

" }}
" My pluggins {{
exec 'source '.expand(g:my_pluginsdir.'/nn.vim')
exec 'source '.expand(g:my_pluginsdir.'/templates.vim')
" }}
" Plugins {{
call plug#begin(g:my_pluggeddir)

Plug 'https://github.com/tpope/vim-sensible.git'
Plug 'https://github.com/tpope/vim-vinegar.git'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/tpope/vim-surround.git'

" WIP: Replacing vim-commentary with tcomment_vim
" Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tomtom/tcomment_vim.git'

Plug 'https://github.com/tpope/vim-endwise.git'
Plug 'https://github.com/tpope/vim-eunuch.git'
Plug 'https://github.com/tpope/vim-scriptease.git'
Plug 'https://github.com/tpope/vim-speeddating.git'
Plug 'https://github.com/mhinz/vim-lookup.git'
Plug 'https://github.com/tmhedberg/matchit.git'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/jszakmeister/vim-togglecursor.git'
Plug 'https://github.com/s3rvac/AutoFenc.git'
exec 'source '.expand(g:my_plugconfigsdir.'/text_objects.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/argwrap.vim')
Plug 'https://github.com/junegunn/goyo.vim.git'
exec 'source '.expand(g:my_plugconfigsdir.'/limelight.vim')
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
exec 'source '.expand(g:my_plugconfigsdir.'/fugitive.vim')
Plug 'https://github.com/editorconfig/editorconfig-vim.git'
Plug 'https://github.com/skywind3000/asyncrun.vim.git'
exec 'source '.expand(g:my_plugconfigsdir.'/dispatch.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/ale.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/vim-slime.vim')
Plug 'https://github.com/skywind3000/vim-preview.git'
exec 'source '.expand(g:my_plugconfigsdir.'/tagbar.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/anyjump.vim')

" Built-in search engines: plugged/open-browser.vim/autoload/vital/__openbrowser__/OpenBrowser/Config.vim
exec 'source '.expand(g:my_plugconfigsdir.'/openbrowser.vim')

exec 'source '.expand(g:my_plugconfigsdir.'/investigate.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/vim-system-copy.vim')
Plug 'https://github.com/jceb/vim-orgmode.git'

exec 'source '.expand(g:my_plugconfigsdir.'/snipmate.vim')

exec 'source '.expand(g:my_plugconfigsdir.'/lightline.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/languagepack.vim')
exec 'source '.expand(g:my_plugconfigsdir.'/colorschemes.vim')

call plug#end()
" }}
" vim:fdm=marker:fmr={{,}}:et:ts=4:sts=4:sw=4
