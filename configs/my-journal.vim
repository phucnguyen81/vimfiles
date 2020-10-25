" My journal file type.
" See '../ftplugin/journal.vim' for details.
augroup MyJournalFileTypeDectection
    autocmd!
    au BufNewFile,BufRead *.journal set filetype=journal
augroup END
