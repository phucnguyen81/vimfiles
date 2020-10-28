" My options {{
let g:my_basedir = expand('<sfile>:p:h')

let g:my_plugvim = expand(g:my_basedir.'/autoload/plug.vim')
if !filereadable(g:my_plugvim)
    echoerr 'Cannot read vim-plug file at '.g:my_plugvim
endif

let g:my_docdir = expand(g:my_basedir.'/doc')
if !isdirectory(g:my_docdir)
    call mkdir(g:my_docdir, "p")
endif

let g:my_pluggeddir = expand(g:my_basedir.'/plugged')
if !isdirectory(g:my_pluggeddir)
    call mkdir(g:my_pluggeddir, "p")
endif

let g:my_configsdir = expand(g:my_basedir.'/configs')
if !isdirectory(g:my_configsdir)
    call mkdir(g:my_configsdir, "p")
endif

let g:my_pluginsdir = expand(g:my_basedir.'/myplugins')
if !isdirectory(g:my_pluginsdir)
    call mkdir(g:my_pluginsdir, "p")
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

let g:my_doing_file = expand(g:my_vardir.'/doing.txt')

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
    " fd config file is at ~/.fdignore
    let g:my_fzf_default_command = 'fd --no-ignore-vcs'
endif
let g:my_fzf_history_dir = expand(g:my_vardir.'/fzf-history')
if !isdirectory(g:my_fzf_history_dir)
    call mkdir(g:my_fzf_history_dir, "p")
endif

let g:my_scratch_file = expand(g:my_vardir.'/scratch.txt')

" TODO: consider removing this (replace with temp buffer?)
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

let g:my_auto_save_on = 1

" Hint at completion plugins being used, jedi | lsp | tabnine
let g:my_completion_plugin = $VIM_COMPLETION_ENGINE

" Enable/disable auto-completion at startup
let g:my_auto_completion_on = 1

" Delay in miliseconds during typing before completion kicks in
let g:my_auto_completion_delay = 2000

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
set autoread hidden 
set nowrap nowrapscan
set whichwrap=b,s,<,>,[,] "more freedom to move between lines in normal mode"
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
if !empty(glob(g:my_dict_eng, 1))
    exec 'set dictionary+='.g:my_dict_eng
endif
set noshowmode
set shortmess+=I shortmess+=c shortmess+=t
set signcolumn=auto  "Show sign column if there is a sign to display"
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
set list "Show some hidden chars in listchars"
set number relativenumber "Line numbers"
set nocursorline "No highlighting of current line"
set incsearch nohlsearch ignorecase smartcase
set laststatus=2 showtabline=2
set showcmd
set cmdheight=1
set sessionoptions-=options "don't save options and mappings"
set sessionoptions-=blank   "don't save emtpy windows"
set sessionoptions+=help    "save help windows"
set viewoptions-=options
" Integrate with python3
if !empty(glob($VIM_PYTHONTHREE_DLL, 1))
    let &pythonthreedll = $VIM_PYTHONTHREE_DLL
    let &pythonthreehome = fnamemodify($VIM_PYTHONTHREE_DLL, ':h')
endif
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
exec 'source '.expand(g:my_configsdir.'/text_objects.vim')
exec 'source '.expand(g:my_configsdir.'/argwrap.vim')
Plug 'https://github.com/junegunn/goyo.vim.git'
exec 'source '.expand(g:my_configsdir.'/limelight.vim')
Plug 'https://github.com/amix/vim-zenroom2.git'
Plug 'https://github.com/freitass/todo.txt-vim.git'
exec 'source '.expand(g:my_configsdir.'/startify.vim')
exec 'source '.expand(g:my_configsdir.'/abolish.vim')
exec 'source '.expand(g:my_configsdir.'/easy-align.vim')
exec 'source '.expand(g:my_configsdir.'/sneak.vim')
exec 'source '.expand(g:my_configsdir.'/undotree.vim')
exec 'source '.expand(g:my_configsdir.'/autosave.vim')
exec 'source '.expand(g:my_configsdir.'/rooter.vim')
exec 'source '.expand(g:my_configsdir.'/vim-windowswap.vim')

exec 'source '.expand(g:my_configsdir.'/nerdtree.vim')
exec 'source '.expand(g:my_configsdir.'/netrw.vim')
exec 'source '.expand(g:my_configsdir.'/fzf.vim')
exec 'source '.expand(g:my_configsdir.'/grepper.vim')
exec 'source '.expand(g:my_configsdir.'/quickrun.vim')
exec 'source '.expand(g:my_configsdir.'/fugitive.vim')
Plug 'https://github.com/editorconfig/editorconfig-vim.git'
Plug 'https://github.com/skywind3000/asyncrun.vim.git'
exec 'source '.expand(g:my_configsdir.'/dispatch.vim')
exec 'source '.expand(g:my_configsdir.'/ale.vim')
exec 'source '.expand(g:my_configsdir.'/vim-slime.vim')
Plug 'https://github.com/skywind3000/vim-preview.git'
exec 'source '.expand(g:my_configsdir.'/tagbar.vim')
if has('popupwin')
    exec 'source '.expand(g:my_configsdir.'/anyjump.vim')
endif

if g:my_completion_plugin ==? 'tabnine'
    exec 'source '.expand(g:my_configsdir.'/tabnine.vim')
endif

" Built-in search engines: plugged/open-browser.vim/autoload/vital/__openbrowser__/OpenBrowser/Config.vim
exec 'source '.expand(g:my_configsdir.'/openbrowser.vim')

exec 'source '.expand(g:my_configsdir.'/investigate.vim')
exec 'source '.expand(g:my_configsdir.'/vim-system-copy.vim')
Plug 'https://github.com/jceb/vim-orgmode.git'

exec 'source '.expand(g:my_configsdir.'/snipmate.vim')

exec 'source '.expand(g:my_configsdir.'/lightline.vim')
exec 'source '.expand(g:my_configsdir.'/languagepack.vim')
exec 'source '.expand(g:my_configsdir.'/colorschemes.vim')

call plug#end()
" }}
" My configs {{
exec 'source '.expand(g:my_configsdir.'/my-arglist.vim')
exec 'source '.expand(g:my_configsdir.'/my-buffer.vim')
exec 'source '.expand(g:my_configsdir.'/my-command-templates.vim')
exec 'source '.expand(g:my_configsdir.'/my-commandmap.vim')
exec 'source '.expand(g:my_configsdir.'/my-commands.vim')
exec 'source '.expand(g:my_configsdir.'/my-doing.vim')
exec 'source '.expand(g:my_configsdir.'/my-grep.vim')
exec 'source '.expand(g:my_configsdir.'/my-highlight.vim')
exec 'source '.expand(g:my_configsdir.'/my-ide.vim')
exec 'source '.expand(g:my_configsdir.'/my-insertmap.vim')
exec 'source '.expand(g:my_configsdir.'/my-journal.vim')
exec 'source '.expand(g:my_configsdir.'/my-jumplist.vim')
exec 'source '.expand(g:my_configsdir.'/my-newfile.vim')
exec 'source '.expand(g:my_configsdir.'/my-nn.vim')
exec 'source '.expand(g:my_configsdir.'/my-normalmap.vim')
exec 'source '.expand(g:my_configsdir.'/my-project.vim')
exec 'source '.expand(g:my_configsdir.'/my-registers.vim')
exec 'source '.expand(g:my_configsdir.'/my-sessions.vim')
exec 'source '.expand(g:my_configsdir.'/my-snippets.vim')
exec 'source '.expand(g:my_configsdir.'/my-source.vim')
exec 'source '.expand(g:my_configsdir.'/my-tab.vim')
exec 'source '.expand(g:my_configsdir.'/my-template.vim')
if has('terminal')
    exec 'source '.expand(g:my_configsdir.'/my-terminal.vim')
endif
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
    " Silenly wipe buffers with no files
    for buf in getbufinfo({'buflisted': 1})
        if empty(glob(buf.name, 1))
            silent! exec 'bdelete! '.buf.bufnr
        endif
    endfor

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
" vim:fdm=marker:fmr={{,}}:et:ts=4:sts=4:sw=4
