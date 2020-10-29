" Fuzzy search
" Plug 'https://github.com/junegunn/fzf.git'
Plug 'https://github.com/junegunn/fzf.git', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim.git'

if exists('g:my_fzf_history_dir')
  \ && isdirectory(g:my_fzf_history_dir)
    let g:fzf_history_dir = g:my_fzf_history_dir
endif

" Fuzzy-find files in working directory
func! s:FindFile() abort
    let source = exists('g:my_fzf_default_command')
        \ ? g:my_fzf_default_command : ''
    call my#find#fuzzyfind(getcwd(), source)
endfunc
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
