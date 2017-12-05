" TABS:
set expandtab
set tabstop=4
set shiftwidth=4

" PLUGINS:
if exists('g:loaded_ftplugin_plugins')
    finish
endif
let g:loaded_ftplugin_plugins=1

packadd ale
packadd tagbar
packadd vim-commentary
packadd vim-surround
