if exists('g:loaded_ftplugin_php_config')
    finish
endif
let g:loaded_ftplugin_php_config=1

" update tags in background whenever you write a php file
au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
