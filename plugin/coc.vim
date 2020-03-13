" Completion engine.
" Source: https://github.com/neoclide/coc.nvim
" Doc: :help coc-nvim
" Settings: :CocConfig

if !exists('g:did_coc_loaded')
    finish
endif

" Use <C-Space> to trigger completion.
" Nah!, <C-Space> is already set for INSERT mode.
" inoremap <silent><expr> <C-Space> coc#refresh()
