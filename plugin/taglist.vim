" Show tags of current files.
" Source: https://github.com/vim-scripts/taglist.vim

if !exists('loaded_taglist')
    finish
endif

" Show tags for current openned files
command Taglist :TlistOpen

