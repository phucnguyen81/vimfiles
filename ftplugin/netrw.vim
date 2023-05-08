" TODO do <Leader>D to delete recursively with vim function delete()

" Show buffer name but not as a file, buggy!
" exec 'file netrw_'.bufnr('%')

setlocal buftype=nofile "avoid being saved as file"
setlocal winfixwidth "avoid adjusting netrw window width"

let b:auto_save = 0 "avoid being saved by vim-auto-save"

" safe, quick quit
nnoremap <buffer><silent> qq :close<CR>
