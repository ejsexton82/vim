setlocal omnifunc=phpcomplete#CompletePHP

if exists('g:loaded_ftplugin_php_plugins')
    finish
endif
let g:loaded_ftplugin_php_plugins=1

source $HOME/vimfiles/ftplugin/plugins.vim
source $HOME/vimfiles/ftplugin/javascript/plugins.vim

" PHP VIM:
" {{{
let php_folding = 1
" }}}
packadd php.vim

packadd phpcomplete.vim

" SUPERTAB:
" {{{
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" }}}
packadd supertab

packadd vdebug
