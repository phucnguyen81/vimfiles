if executable('rg')
    set grepprg=rg\ --fixed-strings\ --no-heading\ --vimgrep\ --smart-case\ --max-filesize\ 1M\ $*
    set grepformat=%f:%l:%c:%m
    nnoremap <Leader>rg :<C-u>grep <C-r><C-w>
endif

