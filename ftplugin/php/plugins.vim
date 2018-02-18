setlocal omnifunc=phpcomplete#CompletePHP

if exists('g:loaded_ftplugin_php_plugins')
    finish
endif
let g:loaded_ftplugin_php_plugins=1

source $HOME/.vim/ftplugin/plugins.vim
source $HOME/.vim/ftplugin/javascript/plugins.vim

packadd php.vim

packadd phpcomplete.vim

packadd vdebug
