" For autoformat
let b:formatdef_lua = '"luafmt --stdin --indent-count ".&shiftwidth'
let b:formatters_lua = ['lua']

setlocal suffixesadd+=.lua

