" nerdtree: file explorer
" Source: https://github.com/scrooloose/nerdtree.git

" Open nerdtree-tab in Gui only if a directory is given
let g:nerdtree_tabs_open_on_gui_startup = 2

" Don't take over netrw
let g:NERDTreeHijackNetrw =  0

" Don't close nerdtree when a file is openned
let g:NERDTreeQuitOnOpen = 0

" Delete buffer if file is deleted
let g:NERDTreeAutoDeleteBuffer = 1

" Don't show the help stuff
let g:NERDTreeMinimalUI = 1

" Default size is 31
let g:NERDTreeWinSize = 40

" Ignore file patterns
let g:NERDTreeIgnore = ['\.pyc$', '\~$', '__pycache', 'NTUSER.DAT']

" Toggle nerd tree panel
nnoremap <Leader>nt :NERDTree<CR>

" Reveal current file in nerd-tree panel
nnoremap <Leader>nf :NERDTreeFind<CR>
