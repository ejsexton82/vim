setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

if exists('g:loaded_ftplugin_php_config')
    finish
endif
let g:loaded_ftplugin_php_config=1

let g:PHP_vintage_case_default_indent = 1
let g:PHP_indent_html = 1
let g:PHP_outdentphpescape = 0

" update tags in background whenever you write a php file
au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
