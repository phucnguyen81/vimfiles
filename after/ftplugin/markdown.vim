" markdown files are also html files so the fix command is defined here to
" override the html fix command
if exists(':ALEFix') && executable('prettier')
    let b:my_fix_command = 'ALEFix prettier'
endif
