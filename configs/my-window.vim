" Close current window
nnoremap <silent><Leader>wc :call myfun#close_window()<CR>
nnoremap <silent><Leader>cc :call myfun#close_window()<CR> 

" Close all other windows
nnoremap <silent><Leader>wo :only<CR>

" Close a window that can be moved to with :wincmd wincmd_arg
func! s:CloseWindowAtWincmd(wincmd_arg) abort
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
endfunc
" close window below
nnoremap <silent><Leader>cj :call <SID>CloseWindowAtWincmd('j')<CR>
" close window above
nnoremap <silent><Leader>ck :call <SID>CloseWindowAtWincmd('k')<CR>
" close left window
nnoremap <silent><Leader>ch :call <SID>CloseWindowAtWincmd('h')<CR>
" close right window
nnoremap <silent><Leader>cl :call <SID>CloseWindowAtWincmd('l')<CR>
" close first window clockwise
nnoremap <silent><Leader>cw :call <SID>CloseWindowAtWincmd('w')<CR>
" close first window counter-clockwise
nnoremap <silent><Leader>cW :call <SID>CloseWindowAtWincmd('W')<CR>

" move to window at clockwise direction
nnoremap <silent><C-n> :wincmd w<CR>

" move to top left window
nnoremap <silent><Leader>wt :wincmd t<CR>
" move to bottom right window
nnoremap <silent><Leader>wb :wincmd b<CR>
" move to window on left
nnoremap <silent><Leader>wh :wincmd h<CR>
" move to window on right
nnoremap <silent><Leader>wl :wincmd l<CR>
" move to window down
nnoremap <silent><Leader>wj :wincmd j<CR>
" move to window above
nnoremap <silent><Leader>wk :wincmd k<CR>
" move to previous window
nnoremap <silent><Leader>wp :wincmd p<CR>
" move to preview window (e.g. quickfix window)
nnoremap <silent><Leader>wP :wincmd P<CR>
" close preview window (e.g from quickfix window)
nnoremap <silent><Leader>wz :wincmd z<CR>

" Move to window given its number
nnoremap <silent><Leader>w1 1<C-w>w
nnoremap <silent><Leader>w2 2<C-w>w
nnoremap <silent><Leader>w3 3<C-w>w
nnoremap <silent><Leader>w4 4<C-w>w
nnoremap <silent><Leader>w5 5<C-w>w

" Arrange windows
nnoremap <silent><Leader>wr :wincmd r<CR>
nnoremap <silent><Leader>wH :wincmd H<CR>
nnoremap <silent><Leader>wL :wincmd L<CR>
nnoremap <silent><Leader>wJ :wincmd J<CR>
nnoremap <silent><Leader>wK :wincmd K<CR>
" Move current window to new tab page
nnoremap <silent><Leader>wT :wincmd T<CR>

" Split windows
nnoremap <silent><Leader>ws :wincmd s<CR>
nnoremap <silent><Leader>wv :wincmd v<CR>
nnoremap <silent><Leader>wn :vertical new<CR>

" Resize windows (or use the mouse)
nnoremap <silent><Leader>w= :wincmd =<CR>
nnoremap <silent><Leader>we :wincmd =<CR>
nnoremap <silent><Leader>w<lt> :20wincmd <<CR>
nnoremap <silent><Leader>w> :20wincmd ><CR>
nnoremap <silent><Leader>w- :10wincmd -<CR>
nnoremap <silent><Leader>w+ :10wincmd +<CR>
