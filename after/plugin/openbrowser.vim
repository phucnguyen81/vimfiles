" Source: https://github.com/tyru/open-browser.vim

" Stop right here if the plugin is not enabled.
if !exists('g:loaded_openbrowser')
    finish
endif

let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
