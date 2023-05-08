nnoremap <Leader>ls :buffers<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>ba :buffer #<CR>
nnoremap <Leader>bf :bfirst<CR>
nnoremap <Leader>bl :blast<CR>
nnoremap <Leader>bm :bmodified<CR>
" Close current window
nnoremap <silent><Leader>wc :call myfun#close_window()<CR>
nnoremap <silent><Leader>cc :call myfun#close_window()<CR>
" Close all other windows
nnoremap <silent><Leader>wo :only<CR>
" Close a window that can be moved to with :wincmd wincmd_arg
func! s:CloseWindowAtWincmd(wincmd_arg) abort
    let wincmd_arg = a:wincmd_arg
    let curwin = winnr()

    " go to the target window to get its win number
    exec "wincmd ".wincmd_arg
    if winnr() == curwin
        echoerr "No window at ".wincmd_arg
        return
    endif
    let win_target = winnr()

    " go back then close the other
    exec curwin.'wincmd w'
    if win_target != curwin
        exec "close ".win_target
    else
        echoerr "Same window at ".wincmd_arg
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
" preview tag
nnoremap <silent><Leader>w} :wincmd }<CR>
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
" Open left-explore as sidebar
nnoremap <silent> <Leader>le :<C-u>exec 'Lexplore '.fnameescape(g:my#project#dir())<CR>
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
" Change working directory for global/tab-local/buffer scope
nnoremap <Leader>cd :cd <C-r>=fnameescape(my#project#dir())<CR>
nnoremap <Leader>td :tcd <C-r>=fnameescape(my#project#dir())<CR>
nnoremap <Leader>ld :lcd <C-r>=fnameescape(my#project#dir())<CR>
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
" swap moving linewise with logical-linewise
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> gj j
nnoremap <silent> gk k
" Open quickfix/location list
nnoremap <Leader>co :botright copen<CR>
nnoremap <Leader>lo :botright lopen<CR>
nnoremap <Leader>qa :confirm quitall<CR>
" toggle search highlighting
nnoremap <Leader>hl :setlocal hlsearch!<CR>
nnoremap g0 ^
" select text just pasted (while gv selects text just yanked)
nnoremap gV `[v`]
" let Y be yank-to-eol to be consistent with other operations
nnoremap Y y$
" Default Q is for Ex mode, not useful, changed to calling macro q
nnoremap Q @qzz

"""""""""""""" Mappings for capical letters """"""""""""""""""""
"G is for Git status
nnoremap <Leader>G :Git<CR>

" O is for openning a file
nnoremap <Leader>O :browse edit<CR>

" W is for write
nnoremap <Leader>W :write<CR>