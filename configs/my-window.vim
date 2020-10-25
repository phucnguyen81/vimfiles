" Close current window
nnoremap <silent> <Leader>wc :call myfun#close_window()<cr>
nnoremap <silent> <Leader>cc :call myfun#close_window()<cr> 

" Close all other windows
nnoremap <silent> <Leader>wo :only<cr>

" Close a window that can be moved to with :wincmd wincmd_arg
function! s:CloseWindowAtWincmd(wincmd_arg) abort
    let l:win = winnr()
    exec "wincmd ".a:wincmd_arg
    if winnr() == l:win
        echoerr "No window at ".a:wincmd_arg
        return
    endif
    let l:win_dest = winnr()
    " go back then close the other
    exec l:win.'wincmd w'
    if l:win_dest != l:win
        exec "close! ".l:win_dest
    else
        echoerr "Same window at ".a:wincmd_arg
    endif
endfunction
" close window below
nnoremap <silent> <Leader>cj :call <SID>CloseWindowAtWincmd('j')<cr>
" close window above
nnoremap <silent> <Leader>ck :call <SID>CloseWindowAtWincmd('k')<cr>
" close left window
nnoremap <silent> <Leader>ch :call <SID>CloseWindowAtWincmd('h')<cr>
" close right window
nnoremap <silent> <Leader>cl :call <SID>CloseWindowAtWincmd('l')<cr>
" close first window clockwise
nnoremap <silent> <Leader>cw :call <SID>CloseWindowAtWincmd('w')<cr>
" close first window counter-clockwise
nnoremap <silent> <Leader>cW :call <SID>CloseWindowAtWincmd('W')<cr>

" move to window at clockwise direction
nnoremap <silent> <C-n> :wincmd w<cr>

" move to top left window
nnoremap <silent> <Leader>wt :wincmd t<cr>
" move to bottom right window
nnoremap <silent> <Leader>wb :wincmd b<cr>
" move to window on left
nnoremap <silent> <Leader>wh :wincmd h<cr>
" move to window on right
nnoremap <silent> <Leader>wl :wincmd l<cr>
" move to window down
nnoremap <silent> <Leader>wj :wincmd j<cr>
" move to window above
nnoremap <silent> <Leader>wk :wincmd k<cr>
" move to previous window
nnoremap <silent> <Leader>wp :wincmd p<cr>
" move to preview window (e.g. quickfix)
nnoremap <silent> <Leader>wP :wincmd P<cr>

" Move to window given its number
nnoremap <silent> <Leader>w1 1<c-w>w
nnoremap <silent> <Leader>w2 2<c-w>w
nnoremap <silent> <Leader>w3 3<c-w>w
nnoremap <silent> <Leader>w4 4<c-w>w
nnoremap <silent> <Leader>w5 5<c-w>w

" Arrange windows
nnoremap <silent> <Leader>wr :wincmd r<cr>
nnoremap <silent> <Leader>wH :wincmd H<cr>
nnoremap <silent> <Leader>wL :wincmd L<cr>
nnoremap <silent> <Leader>wJ :wincmd J<cr>
nnoremap <silent> <Leader>wK :wincmd K<cr>
" Move current window to new tab page
nnoremap <silent> <Leader>wT :wincmd T<cr>

" Split windows
nnoremap <silent> <Leader>ws :wincmd s<cr>
nnoremap <silent> <Leader>wv :wincmd v<cr>
nnoremap <silent> <Leader>wn :vertical new<cr>

" Resize windows (or use the mouse)
nnoremap <silent> <Leader>w= :wincmd =<cr>
nnoremap <silent> <Leader>we :wincmd =<cr>
nnoremap <silent> <Leader>w<lt> :20wincmd <<cr>
nnoremap <silent> <Leader>w> :20wincmd ><cr>
nnoremap <silent> <Leader>w- :10wincmd -<cr>
nnoremap <silent> <Leader>w+ :10wincmd +<cr>
