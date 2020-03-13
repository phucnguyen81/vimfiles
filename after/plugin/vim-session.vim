" Mappings for xolox/vim-session plugin.
" Source: https://github.com/xolox/vim-session
" Help: session.txt

" Stop here if the plugin has not been loaded.
if !exists('g:loaded_session')
    finish
endif

" Save session
nnoremap <Leader>ss :SaveSession<space><C-r>=fnamemodify(eval('v:this_session'),':t:r')<CR>

" Open session
nnoremap <Leader>os :OpenSession<space><C-r>=fnamemodify(eval('v:this_session'),':t:r')<CR>

" Delete session
nnoremap <Leader>ds :DeleteSession<CR>
