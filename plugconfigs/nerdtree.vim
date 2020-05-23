Plug 'https://github.com/scrooloose/nerdtree.git'

if exists('g:my_nerdtree_bookmarksfile')
    let g:NERDTreeBookMarksFile = g:my_nerdtree_bookmarksfile
endif

" Open nerdtree-tab in Gui only if a directory is given
let g:nerdtree_tabs_open_on_gui_startup = 2

let g:NERDTreeHijackNetrw =  0

" Don't close nerdtree when a file is openned
let g:NERDTreeQuitOnOpen = 0

" Delete buffer if file is deleted
let g:NERDTreeAutoDeleteBuffer = 1

" Don't show the help stuff
let g:NERDTreeMinimalUI = 1

let g:NERDTreeIgnore = ['\.pyc$', '\~$', '__pycache']

" Focus on current file in nerd-tree
nnoremap <Leader>nf :NERDTreeFind<CR>
