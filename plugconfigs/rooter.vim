" Work with project root directory.
" Root directory is identified by presence of known file/directory.
Plug 'https://github.com/airblade/vim-rooter.git'

" Auto-change directory can cause problems with other plugins
let g:rooter_manual_only = 1

" Patterns that indicate a root directory.
" Patterns that come first will be searched first.
" Patterns that end with '/' are for directories.
let g:rooter_patterns = ['package.json', 'manage.py', '.git/']

" Change working directory for global/tab-local/buffer scope
nnoremap <Leader>cd :cd <C-r>=fnameescape(<SID>current_dir())<CR>
nnoremap <Leader>td :tcd <C-r>=fnameescape(<SID>current_dir())<CR>
nnoremap <Leader>ld :lcd <C-r>=fnameescape(<SID>current_dir())<CR>

" Return directory most relevant to current buffer
function! s:current_dir() abort
    if (&filetype ==? 'netrw')
        \ && exists('b:netrw_curdir')
        \ && isdirectory(b:netrw_curdir)
        return expand(b:netrw_curdir)
    endif

    " git_dir is from fugitive plugin
    if (&filetype ==? 'fugitive')
        \ && exists('b:git_dir')
        \ && isdirectory(b:git_dir)
        return fnamemodify(b:git_dir, ':h')
    endif

    let curdir = FindRootDirectory()
    if isdirectory(curdir)
        return curdir
    endif

    let curdir = expand('%:p:h')
    if isdirectory(curdir)
        return curdir
    endif

    return getcwd()
endfunction
