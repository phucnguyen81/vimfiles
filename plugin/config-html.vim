" Options for html indent, see: $VIMRUNTIME/indent/html.vim

" html: don't increase indent after first <script>
let g:html_indent_script1 = "zero"

" html: don't indent after first <style>
let g:html_indent_style1 = "zero"

" html: increase indent after these tags
let g:html_indent_inctags = "html,body,head,tbody"

" html: don't increase indent after these tags
let g:html_indent_autotags = "p"