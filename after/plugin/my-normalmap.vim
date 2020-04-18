" Select current paragraph
nnoremap <Leader>vp {jVO}

" Go to home directory
nnoremap <Leader>gh :edit ~/<CR>

" Edit vimrc profile
function! s:EditVimrc()
    if exists('g:my_vimrc') && filereadable(g:my_vimrc)
        exec 'edit '.fnameescape(g:my_vimrc)
        return
    endif
    edit $MYVIMRC
endfunction
nnoremap <Leader>ev :call <SID>EditVimrc()<CR>

" Edit gvimrc profile
function! s:EditGvimrc()
    if exists('g:my_gvimrc') && filereadable(g:my_gvimrc)
        exec 'edit '.fnameescape(g:my_gvimrc)
        return
    endif
    edit $MYGVIMRC
endfunction
nnoremap <Leader>eg :call <SID>EditGvimrc()<CR>

" Replace/substitute current whole word, case-sensitive
nnoremap <Leader>sw :.,$s/\V\C\<<C-r>=escape(expand("<cword>"),'/\')<CR>\>//gc<left><left><left>
nnoremap <Leader>Sw :1,.s/\V\C\<<C-r>=escape(expand("<cWORD>"),'/\')<CR>\>//gc<left><left><left>

" Search/find forward/backward for whole word, case-sensitive
nnoremap <Leader>fw /\V\C\<<C-r>=escape(expand("<cword>"),'/\')<CR>\><left><left>
nnoremap <Leader>Fw ?\V\C\<<C-r>=escape(expand("<cword>"),'/\')<CR>\><left><left>

" Grep in current file, populate location list, case-sensitive
nnoremap <Leader>lg :lvimgrep /\V\c<C-r>=escape(expand('<cword>'), '/\')<CR>/ %<Left><Left><Left>
nnoremap <Leader>lG :lvimgrep /\V\c<C-r>=escape(expand('<cWORD>'), '/\')<CR>/ %<Left><Left><Left>

" Grep all files in current directory, populate quickfix list, case-sensitive
nnoremap <Leader>vg :noautocmd vimgrep /\V\C<C-r>=escape(expand('<cword>'), '/\')<CR>/ *<Left><Left><Left>
nnoremap <Leader>vG :noautocmd vimgrep /\V\C<C-r>=escape(expand('<cWORD>'), '/\')<CR>/ *<Left><Left><Left>

" Go to the last cursor location saved in viminfo
nnoremap <Leader>gl :normal! g`"<CR>

" Search for definition
nnoremap <Leader>K :<C-u>call myfun#search_doc()<CR>

" Git status
nnoremap <Leader>gs :<C-u>Gstatus<CR>

" swap moving linewise with logical-linewise
" TODO this should be near wrap option
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> gj j
nnoremap <silent> gk k

" Clear messages and search highlight together
nnoremap <C-l> :<C-u>call myfun#clear_screen()<CR><C-l>

nnoremap <f3> :<C-u>call myfun#open_current_path()<CR>
nnoremap <Leader>oo :<C-u>call myfun#open_current_path()<CR>

" Open quickfix/location list
nnoremap <Leader>co :copen<CR>
nnoremap <Leader>lo :lopen<CR>

nnoremap <Leader>ms :call myfun#maximize_screen()<CR>
nnoremap <f11> :call myfun#maximize_screen()<CR>

" Change current/local working directory
nnoremap <Leader>cd :cd <C-r>=fnameescape(myfun#current_dir())<CR>
nnoremap <Leader>lc :lcd <C-r>=fnameescape(myfun#current_dir())<CR>

nnoremap <Leader>qa :confirm quitall<CR>

" toggle search highlighting
nnoremap <Leader>hl :setlocal hlsearch!<CR>

" select text just pasted (while gv selects text just yanked)
nnoremap gV `[v`]

" let Y be yank-to-eol to be consistent with other operations
nnoremap Y y$

" Q is for Ex mode, not useful, changed to calling macro q
nnoremap Q @qzz
