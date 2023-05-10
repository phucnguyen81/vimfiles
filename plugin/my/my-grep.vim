if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep\ --smart-case\ $*
    set grepformat=%f:%l:%c:%m
endif

nnoremap <Leader>gw :<C-u>grep <C-r><C-w>
