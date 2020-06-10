" Fuzzy search
Plug 'https://github.com/junegunn/fzf.git'
Plug 'https://github.com/junegunn/fzf.vim.git'

if exists('g:my_fzf_history_dir')
  \ && isdirectory(g:my_fzf_history_dir)
    let g:fzf_history_dir = g:my_fzf_history_dir
endif

" Fuzzy-find files in working directory
function! s:FindFile() abort
    let curdir = myfun#current_dir()
    exec ':FZF '.fnameescape(curdir)
endfunction
nnoremap <silent> <C-p> :call <SID>FindFile()<CR>
nnoremap <silent> <Leader>ff :call <SID>FindFile()<CR>

" Find recent files and buffers
nnoremap <Leader>fh :History<CR>

" Find buffers
nnoremap <Leader>fb :Buffers<CR>

" Find commands
nnoremap <Leader>fc :Commands<CR>

" Find lines in current buffers
nnoremap <Leader>fl :BLines<CR>

" Find lines in loaded buffers
nnoremap <Leader>fL :Lines<CR>
