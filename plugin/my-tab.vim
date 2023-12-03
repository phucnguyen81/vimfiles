" All about tabs

" Create new tab
nnoremap <silent> <Leader>tn :<C-u>call myfun#new_tab()<CR>

" Close current tab
nnoremap <silent> <Leader>tc :tabclose<cr>

" Close all but this tab
nnoremap <silent> <Leader>to :tabonly<cr>

" Go to next tab (also 'gt')
" NOTE: don't map <Tab>, it is reserved for normal mode
nnoremap <silent> T :tabnext<cr>
nnoremap <silent> <Leader>tl :tabnext<cr>

" Go to previous tab (also 'gT')
nnoremap <silent> <Leader>th :tabprevious<cr>
nnoremap <silent> <S-Tab> :tabprevious<cr>

" Go to tab
noremap <silent> <Leader>0 :<C-u>tabfirst<cr>
noremap <silent> <Leader>1 1gt
noremap <silent> <Leader>2 2gt
noremap <silent> <Leader>3 3gt
noremap <silent> <Leader>4 4gt
noremap <silent> <Leader>5 5gt
noremap <silent> <Leader>6 6gt
noremap <silent> <Leader>7 7gt
noremap <silent> <Leader>8 8gt
noremap <silent> <Leader>9 9gt
noremap <silent> <Leader>$ :<C-u>tablast<cr>
noremap <silent> <Leader>t0 :<C-u>tabfirst<cr>
noremap <silent> <Leader>t1 1gt
noremap <silent> <Leader>t2 2gt
noremap <silent> <Leader>t3 3gt
noremap <silent> <Leader>t4 4gt
noremap <silent> <Leader>t5 5gt
noremap <silent> <Leader>t6 6gt
noremap <silent> <Leader>t7 7gt
noremap <silent> <Leader>t8 8gt
noremap <silent> <Leader>t9 9gt
noremap <silent> <Leader>t$ :<C-u>tablast<cr>

" Move tab to the right, wrap around if needed
func! s:MoveTabRight(count) abort
    if !empty(a:count)
        exec "tabmove ".(a:count - 1)
    elseif tabpagenr() == tabpagenr('$')
        " if at last tabpage, move to head
        tabmove 0
    else
        " else, just move to the right
        tabmove +1
    endif
endfunc
nnoremap <silent> <Leader>tm :<c-u>call <SID>MoveTabRight(v:count)<cr>
nnoremap <silent> <C-Down> :call <SID>MoveTabRight(0)<cr>

" Move tab to the left, wrap around if needed
func! s:MoveTabLeft(count) abort
    if !empty(a:count)
        exec "tabmove ".(a:count - 1)
    elseif tabpagenr() == 1
        " if at the head, move to the end
        tabmove
    else
        " not at the head, just move to the left
        tabmove -1
    endif
endfunc
" Move tab to the left
nnoremap <silent> <Leader>tM :<c-u>call <SID>MoveTabLeft(v:count)<cr>
nnoremap <silent> <C-Up> :call <SID>MoveTabLeft(0)<cr>
