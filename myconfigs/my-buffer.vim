" Go to next buffer
nnoremap <silent> <Leader>bn :bnext<cr>
" Go to previous buffer
nnoremap <silent> <Leader>bp :bprevious<cr>
" Go to alternate buffer
nnoremap <Leader>ba :buffer #<CR>
" Go to first buffer
nnoremap <Leader>bf :bfirst<CR>
" Go to last buffer
nnoremap <Leader>bl :blast<CR>
" Go to next modified buffer
nnoremap <Leader>bm :bmodified<CR>

" Write current buffer to file
nnoremap <Leader>ww :call myfun#make_dir()<CR>:write!<CR>
" Trim then write current buffer to file
nnoremap <Leader>WW :call myfun#remove_trailing_spaces()<CR>:write!<CR>

" Switch with buffer on the left
nnoremap <Leader>bh :call myfun#switch_buffer('h')<cr>
" Switch with buffer on the right
nnoremap <Leader>bl :call myfun#switch_buffer('l')<cr>
" Switch with buffer below
nnoremap <Leader>bj :call myfun#switch_buffer('j')<cr>
" Switch with buffer above
nnoremap <Leader>bk :call myfun#switch_buffer('k')<cr>
" Switch with buffer in the clockwise direction
nnoremap <Leader>bw :call myfun#switch_buffer('w')<cr>
" Switch with buffer in the counter-clockwise direction
nnoremap <Leader>bW :call myfun#switch_buffer('W')<cr>
" Switch with buffer of window 1
nnoremap <Leader>b1 :call myfun#switch_buffer('1')<cr>
" Switch with buffer on window 2
nnoremap <Leader>b2 :call myfun#switch_buffer('2')<cr>
" Switch with buffer on window 3
nnoremap <Leader>b3 :call myfun#switch_buffer('3')<cr>
" Switch with buffer on window 4
nnoremap <Leader>b4 :call myfun#switch_buffer('4')<cr>
" Switch with buffer on window 5
nnoremap <Leader>b5 :call myfun#switch_buffer('5')<cr>

" Rotate buffers among windows
command RotateBuffers call myfun#rotate_buffers()
nnoremap <Leader>br :call myfun#rotate_buffers()<cr>

" Delete buffer and close its window
nnoremap <silent> <Leader>db :call myfun#delete_buffer(winnr('#'))<cr>
" Delete buffer, try not to close its window
nnoremap <silent> <Leader>bd :call myfun#delete_buffer()<cr>
" Delete buffer and its associated file
nnoremap <Leader>DD :call myfun#delete_file_buffer()<cr>
" delete buffer below
nnoremap <silent> <Leader>dj :call myfun#delete_buffer_at('j')<cr>
" delete buffer above
nnoremap <silent> <Leader>dk :call myfun#delete_buffer_at('k')<cr>
" delete left buffer
"
nnoremap <silent> <Leader>dh :call myfun#delete_buffer_at('h')<cr>
" delete right buffer
nnoremap <silent> <Leader>dl :call myfun#delete_buffer_at('l')<cr>
" delete first buffer clockwise
nnoremap <silent> <Leader>dw :call myfun#delete_buffer_at('w')<cr>
" delete first buffer counter-clockwise
nnoremap <silent> <Leader>dW :call myfun#delete_buffer_at('W')<cr>

