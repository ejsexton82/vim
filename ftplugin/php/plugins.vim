if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

setlocal omnifunc=phpcomplete#CompletePHP

if exists('g:loaded_ftplugin_php_plugins')
    finish
endif
let g:loaded_ftplugin_php_plugins=1

source $HOME/vimfiles/ftplugin/plugins.vim
source $HOME/vimfiles/ftplugin/javascript/plugins.vim

packadd php.vim
packadd phpcomplete.vim
packadd supertab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
packadd vdebug
