" Fuzzy search
Plug 'https://github.com/junegunn/fzf.git'

if exists('g:my_fzf_history_dir') && isdirectory(g:my_fzf_history_dir)
    let g:fzf_history_dir = g:my_fzf_history_dir
endif

" Fuzzy-select from results of ripgrep
function! s:RipGrep() abort
    let word = input('Grep for: ', expand('<cword>'))
    if empty(word)
        return
    endif

    let curdir = myfun#current_dir()
    if !(curdir ==# getcwd())
        split
        exec 'lcd '.fnameescape(curdir)
    endif

    let grep_command = join(['rg',
        \ '--column --line-number --no-heading',
        \ '--color=always --smart-case',
        \ shellescape(word)
        \ ], ' ')
    let has_column = 1
    let options = {}
    let fullscreen = 0
    call fzf#vim#grep(grep_command, has_column, options, fullscreen)
endfunction
nnoremap <Leader>rg :<C-u>call <SID>RipGrep()<CR>

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

" Find lines in current buffer
function! s:FindBufferLines()
    call fzf#vim#buffer_lines({'options': ['--layout=reverse']})
endfunction
nnoremap <silent> <Leader>fl :call <SID>FindBufferLines()<CR>

" Find lines in loaded buffers
nnoremap <Leader>fL :Lines<CR>
