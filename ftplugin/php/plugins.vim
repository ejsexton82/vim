if !has('nvim')
    setlocal omnifunc=phpcomplete#CompletePHP
endif

source $HOME/.vim/ftplugin/plugins.vim
source $HOME/.vim/ftplugin/javascript/plugins.vim

if exists('g:loaded_ftplugin_php_plugins')
    finish
endif
let g:loaded_ftplugin_php_plugins=1

packadd php.vim        " Syntax highlighting
packadd phpfolding.vim " Method folding

if has('nvim')
    " PADAWAN: {{{
    packadd deoplete-padawan
    silent ! composer install --working-dir=$HOME/.vim/pack/vendor/opt/deoplete-padawan/
    " }}}
else
    packadd phpcomplete.vim
endif

packadd vdebug
