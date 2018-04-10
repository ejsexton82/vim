if !has('nvim') || !has('python3')
    setlocal omnifunc=phpcomplete#CompletePHP
endif

if exists('g:loaded_ftplugin_php_plugins')
    finish
endif
let g:loaded_ftplugin_php_plugins=1

if has('win32')
	source $HOME/vimfiles/ftplugin/plugins.vim
	source $HOME/vimfiles/ftplugin/javascript/plugins.vim
else
	source $HOME/.vim/ftplugin/plugins.vim
	source $HOME/.vim/ftplugin/javascript/plugins.vim
endif

packadd php.vim
packadd phpfolding.vim

if has('nvim')
    packadd phpactor
else
    packadd phpcomplete.vim
endif

packadd vdebug
