" Open `doing` file
command! -nargs=0 Doing exec 'edit '.fnameescape(g:my_doing_file)
nnoremap <Leader>do :Doing<CR>
