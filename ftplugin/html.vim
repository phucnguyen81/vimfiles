setlocal iskeyword+=-
setlocal suffixesadd+=.html
setlocal suffixesadd+=.htm

if exists(':ALEFix') && executable('tidy')
    let b:my_fix_command = 'ALEFix tidy'
endif
if exists(':ALEFix') && executable('prettier')
    let b:my_fix_command = 'ALEFix prettier'
endif
