setlocal suffixesadd+=.rb

" For vim-dispatch
if empty(findfile('Rakefile', getcwd()))
    let b:dispatch = 'ruby %'
else
    let b:dispatch = 'bundle exec ruby %'
endif
