" Async autocompletion for Vim 8 and Neovim with |timers|.
" Inspired by nvim-complete-manager but written in pure Vim Script.
Plug 'https://github.com/prabirshrestha/asyncomplete.vim.git'

imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

augroup my_asynccomplete
    autocmd!
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
augroup end

