" Edit another file
nnoremap <Leader>ed :edit <C-R>=expand('%:h')<CR>

" Save as another file
nnoremap <Leader>sa :saveas <C-R>=expand('%:h')<CR>

" Go to home directory
nnoremap <Leader>gh :edit ~/<CR>

" Edit vimrc profile
nnoremap <Leader>ev :call myfun#edit_my_vimrc()<CR>

" Edit gvimrc profile
nnoremap <Leader>eg :call myfun#edit_my_gvimrc()<CR>

" Show current context info
nnoremap <Leader>if :call myfun#show_context_info()<CR>

" Replace/substitute current whole word, case-sensitive
nnoremap <Leader>sw :.,$s/\V\C\<<C-r>=escape(expand("<cword>"),'/\')<CR>\>//gc<left><left><left>
nnoremap <Leader>sW :.,$s/\V\C\<<C-r>=escape(expand("<cWORD>"),'/\')<CR>\>//gc<left><left><left>

" Search for whole word, case-sensitive
nnoremap <Leader>/w /\V\C\<<C-r>=escape(expand("<cword>"),'/\')<CR>\><left><left>
nnoremap <Leader>?w ?\V\C\<<C-r>=escape(expand("<cword>"),'/\')<CR>\><left><left>

" Grep in current file, populate location list, case-sensitive
nnoremap <Leader>lg :lvimgrep /\V\c<C-r>=escape(expand('<cword>'), '/\')<CR>/ %<Left><Left><Left>
nnoremap <Leader>lG :lvimgrep /\V\c<C-r>=escape(expand('<cWORD>'), '/\')<CR>/ %<Left><Left><Left>

" Grep all files in current directory, populate quickfix list, case-sensitive
nnoremap <Leader>vg :noautocmd vimgrep /\V\C<C-r>=escape(expand('<cword>'), '/\')<CR>/ *<Left><Left><Left>
nnoremap <Leader>vG :noautocmd vimgrep /\V\C<C-r>=escape(expand('<cWORD>'), '/\')<CR>/ *<Left><Left><Left>

" Go to the last cursor location saved in viminfo
nnoremap <Leader>gl :normal! g`"<CR>

" Search for definition
nnoremap <Leader>K :call myfun#search_doc()<CR>

" Git status
nnoremap <Leader>gs :0Git<CR>

" swap moving linewise with logical-linewise
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> gj j
nnoremap <silent> gk k

" Clear messages and search highlight together
nnoremap <C-l> :call myfun#clear_screen()<CR><C-l>

nnoremap <f3> :call myfun#open_current_path()<CR>
nnoremap <Leader>oo :call myfun#open_current_path()<CR>

" Open quickfix/location list
nnoremap <Leader>co :copen<CR>
nnoremap <Leader>lo :lopen<CR>

nnoremap <Leader>ms :call myfun#maximize_screen()<CR>
nnoremap <f11> :call myfun#maximize_screen()<CR>

nnoremap <Leader>qa :confirm quitall<CR>

" toggle search highlighting
nnoremap <Leader>hl :setlocal hlsearch!<CR>

nnoremap g0 ^

nnoremap g, ,

" select text just pasted (while gv selects text just yanked)
nnoremap gV `[v`]

" let Y be yank-to-eol to be consistent with other operations
nnoremap Y y$

" Q is for Ex mode, not useful, changed to calling macro q
nnoremap Q @qzz
