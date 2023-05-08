" Fuzzy search files, buffers, commands,...
" fzf: https://github.com/junegunn/fzf.git
" fzf-vim: https://github.com/junegunn/fzf.vim.git

if executable("fd")
    let $FZF_DEFAULT_COMMAND="fd --type f"
elseif executable("rg")
    let $FZF_DEFAULT_COMMAND="rg --files"
endif

" Fuzzy-find files in working directory
nnoremap <silent> <C-p> :<C-u>GFiles<CR>
nnoremap <silent> <Leader>ff :<C-u>FZF<CR>

" Find recent files and buffers
nnoremap <Leader>fh :<C-u>History<CR>

" Find buffers
nnoremap <Leader>fb :<C-u>Buffers<CR>

" Find tags
nnoremap <Leader>ft :<C-u>Tags<CR>

" Find commands
nnoremap <Leader>fc :<C-u>Commands<CR>

" Find lines in the current buffer
nnoremap <Leader>fl :<C-u>BLines<CR>

" Find lines in loaded buffers
nnoremap <Leader>fL :<C-u>Lines<CR>
