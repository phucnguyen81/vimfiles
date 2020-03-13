setlocal iskeyword+=-
setlocal suffixesadd+=.html
setlocal suffixesadd+=.htm
if executable('prettier')
    setlocal formatprg=js-beautify\ --type\ html
endif

if exists(':ALEFix') && executable('tidy')
    let b:my_fix_command = 'ALEFix tidy'
endif
if exists(':ALEFix') && executable('prettier')
    let b:my_fix_command = 'ALEFix prettier'
endif
