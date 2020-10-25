" Fuzzy search
Plug 'https://github.com/junegunn/fzf.git'
Plug 'https://github.com/junegunn/fzf.vim.git'

if exists('g:my_fzf_history_dir')
  \ && isdirectory(g:my_fzf_history_dir)
    let g:fzf_history_dir = g:my_fzf_history_dir
endif

" Fuzzy-find files in working directory
function! s:FindFile() abort
    let curdir = my#project#dir()
    if empty(g:my_fzf_default_command)
        exec ':FZF '.fnameescape(curdir)
        return
    endif
    call fzf#run({
        \ 'dir': curdir,
        \ 'source': g:my_fzf_default_command,
        \ 'options': [
            \ '--multi', '--reverse',
            \ '--bind=change:top,ctrl-d:page-down,ctrl-u:page-up',
            \ ],
        \ 'sink': 'edit',
        \ 'down': '50%'
        \ })
endfunction

" Fuzzy find files
nnoremap <silent> <C-p> :<C-u>call <SID>FindFile()<CR>
nnoremap <silent> <Leader>ff :<C-u>call <SID>FindFile()<CR>

" Find recent files and buffers
nnoremap <Leader>fh :<C-u>History<CR>

" Find buffers
nnoremap <Leader>fb :<C-u>Buffers<CR>

" Find commands
nnoremap <Leader>fc :<C-u>Commands<CR>

" Find lines in current buffers
nnoremap <Leader>fl :<C-u>BLines<CR>

" Find lines in loaded buffers
nnoremap <Leader>fL :<C-u>Lines<CR>
