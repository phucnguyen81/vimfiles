" All about tabs

" Create new tab
nnoremap <silent> <Leader>tn :<C-u>call myfun#new_tab()<CR>

" Close current tab
nnoremap <silent> <Leader>tc :tabclose<cr>

" Close all but this tab
nnoremap <silent> <Leader>to :tabonly<cr>

" Go to next tab (also 'gt')
" NOTE: <Tab> is reserved for vim, should not bind it
nnoremap <silent> <C-Space> :tabnext<cr>
nnoremap <silent> <Leader>tl :tabnext<cr>
nnoremap <silent> T :tabnext<cr>

" Go to previous tab (also 'gT')
nnoremap <silent> <Leader>th :tabprevious<cr>
nnoremap <silent> <S-Tab> :tabprevious<cr>

" Go to tab
noremap <silent> <Leader>t0 :tabfirst<cr>
noremap <silent> <Leader>t1 1gt
noremap <silent> <Leader>t2 2gt
noremap <silent> <Leader>t3 3gt
noremap <silent> <Leader>t4 4gt
noremap <silent> <Leader>t5 5gt
noremap <silent> <Leader>t6 6gt
noremap <silent> <Leader>t7 7gt
noremap <silent> <Leader>t8 8gt
noremap <silent> <Leader>t9 9gt
noremap <silent> <Leader>t$ :tablast<cr>
noremap <silent> 1<Leader> 1gt
noremap <silent> 2<Leader> 2gt
noremap <silent> 3<Leader> 3gt
noremap <silent> 4<Leader> 4gt
noremap <silent> 5<Leader> 5gt
noremap <silent> 6<Leader> 6gt
noremap <silent> 7<Leader> 7gt
noremap <silent> 8<Leader> 8gt
noremap <silent> 9<Leader> 9gt

" Move tab to the right, wrap around if needed
function s:MoveTabRight(count) abort
    if !empty(a:count)
        exec "tabmove ".(a:count - 1)
    elseif tabpagenr() == tabpagenr('$')
        " if at last tabpage, move to head
        tabmove 0
    else
        " else, just move to the right
        tabmove +1
    endif
endfunction
nnoremap <silent> <Leader>tm :<c-u>call <SID>MoveTabRight(v:count)<cr>
nnoremap <silent> <C-Down> :call <SID>MoveTabRight(0)<cr>

" Move tab to the left, wrap around if needed
function s:MoveTabLeft(count) abort
    if !empty(a:count)
        exec "tabmove ".(a:count - 1)
    elseif tabpagenr() == 1
        " if at the head, move to the end
        tabmove
    else
        " not at the head, just move to the left
        tabmove -1
    endif
endfunction
" Move tab to the left
nnoremap <silent> <Leader>tM :<c-u>call <SID>MoveTabLeft(v:count)<cr>
nnoremap <silent> <C-Up> :call <SID>MoveTabLeft(0)<cr>
