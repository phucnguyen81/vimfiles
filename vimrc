" Init {{
let g:my_basedir = expand('<sfile>:p:h')
let g:my_snippets = expand(g:my_basedir.'/snippets')
let g:my_vardir = expand(g:my_basedir.'/var')
let g:my_netrw_home = g:my_vardir
let g:my_viminfofile = expand(g:my_vardir.'/viminfo')
let g:my_undodir = expand(g:my_vardir.'/undodir')
let g:my_backupdir = expand(g:my_vardir.'/backupdir')
let g:my_swapfiles = expand(g:my_vardir.'/swapfiles')
let g:my_session_dir = expand(g:my_vardir.'/sessions')
let g:my_nerdtree_bookmarksfile = expand(g:my_vardir.'/NERDTreeBookMarks')
let g:my_fzf_history_dir = expand(g:my_vardir.'/fzf-history')
let g:my_scratch_file = expand(g:my_vardir.'/scratch.txt')
let g:my_command_template = expand(g:my_vardir.'/command_template.vim')
let g:my_calendar_dir = expand(g:my_vardir.'/calendar')
let g:my_dict_dir = expand(g:my_basedir.'/dict')
let g:my_dict_eng = expand(g:my_dict_dir.'/eng')
for dir in [g:my_vardir, g:my_vardir, g:my_netrw_home
  \, g:my_netrw_home, g:my_undodir, g:my_backupdir
  \, g:my_swapfiles, g:my_session_dir, g:my_fzf_history_dir
  \, g:my_calendar_dir]
    if !isdirectory(dir)
        call mkdir(dir, "p")
    endif
endfor

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

set equalalways splitbelow splitright
set undofile nobackup nowritebackup noswapfile history=1000
if filereadable(g:my_viminfofile)
    let &viminfofile=g:my_viminfofile
endif
if isdirectory(g:my_undodir)
    exec "set undodir=".g:my_undodir.'//,.'
endif
if isdirectory(g:my_backupdir)
    exec "set backupdir=".g:my_backupdir.'//,.'
endif
if isdirectory(g:my_swapfiles)
    exec "set directory=".g:my_swapfiles.'//,.'
endif
set expandtab tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set nofoldenable nojoinspaces formatoptions+=j
set backspace=2
set visualbell display=lastline virtualedit=block
set nohidden nowrapscan autoread
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
if exists('g:my_dictionary') && isdirectory(g:my_dictionary)
    exec 'set dictionary+='.fnameescape(g:my_dictionary)
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
" Autocmd {{
augroup my_autocmd
    autocmd!
    autocmd InsertEnter * norm zz
augroup end
" }}
" Plugins {{
call plug#begin()
Plug 'https://github.com/tpope/vim-sensible.git'
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
Plug 'https://github.com/xolox/vim-misc.git'
Plug 'https://github.com/tpope/vim-scriptease.git'
Plug 'https://github.com/mhinz/vim-lookup.git'
Plug 'https://github.com/jszakmeister/vim-togglecursor.git'
Plug 'https://github.com/wesQ3/vim-windowswap.git'
Plug 'https://github.com/freitass/todo.txt-vim.git'
Plug 'https://github.com/junegunn/goyo.vim.git'
Plug 'https://github.com/amix/vim-zenroom2.git'
Plug 'https://github.com/majutsushi/tagbar.git'
" Text objects
Plug 'https://github.com/kana/vim-textobj-user.git'
Plug 'https://github.com/kana/vim-textobj-entire.git'
Plug 'https://github.com/kana/vim-textobj-line.git'
Plug 'https://github.com/michaeljsmith/vim-indent-object.git'
Plug 'https://github.com/bps/vim-textobj-python.git'

" Status bar
Plug 'https://github.com/itchyny/lightline.vim.git'

" Collection of language packs (syntax, indent, completion, compiler,...)
" TODO: replace other language plugin with this
" Plug 'https://github.com/sheerun/vim-polyglot.git'
" Powershell
Plug 'https://github.com/PProvost/vim-ps1.git'
" Javascript/Html/Json/Markdown
Plug 'https://github.com/othree/yajs.vim.git'
Plug 'https://github.com/HerringtonDarkholme/yats.vim.git'
Plug 'https://github.com/othree/javascript-libraries-syntax.vim.git'
Plug 'https://github.com/othree/html5.vim.git'
Plug 'https://github.com/elzr/vim-json.git'
Plug 'https://github.com/kevinoid/vim-jsonc.git'
" Markdown
" Plug 'https://github.com/tpope/vim-markdown.git'

" Integration
" TODO: replace editorconfig with the more popular version
Plug 'https://github.com/sgur/vim-editorconfig.git'
Plug 'https://github.com/tyru/open-browser.vim.git'
Plug 'https://github.com/keith/investigate.vim.git'
Plug 'https://github.com/mhinz/vim-grepper.git'
Plug 'https://github.com/thinca/vim-quickrun.git'
Plug 'https://github.com/skywind3000/asyncrun.vim.git'
Plug 'https://github.com/tpope/vim-dispatch.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
" NOTE: ale conflicts with fugitive when doing Gdiff.
" Need to disable ale in buffer used for &diff.
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
" TODO: go with a colorscheme pack that contains gruvbox
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
