if !has('nvim')
    setlocal omnifunc=phpcomplete#CompletePHP
endif

source $HOME/.vim/ftplugin/plugins.vim

if exists('g:loaded_ftplugin_php_plugins')
    finish
endif
let g:loaded_ftplugin_php_plugins=1

packadd php.vim        " Syntax highlighting

if has('nvim')
    " PADAWAN: {{{
    packadd deoplete-padawan
    silent ! composer install --working-dir=$HOME/.vim/pack/vendor/opt/deoplete-padawan/
    " }}}
else
    packadd phpcomplete.vim
endif

" REFACTORING: {{{
let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility   = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

let g:vim_php_refactoring_use_default_mapping = 0
nnoremap <leader>rlv :call PhpRenameLocalVariable()<CR>
nnoremap <leader>rcv :call PhpRenameClassVariable()<CR>
nnoremap <leader>rrm :call PhpRenameMethod()<CR>
nnoremap <leader>reu :call PhpExtractUse()<CR>
vnoremap <leader>rec :call PhpExtractConst()<CR>
nnoremap <leader>rep :call PhpExtractClassProperty()<CR>
vnoremap <leader>rem :call PhpExtractMethod()<CR>
nnoremap <leader>rnp :call PhpCreateProperty()<CR>
nnoremap <leader>rdu :call PhpDetectUnusedUseStatements()<CR>
vnoremap <leader>r== :call PhpAlignAssigns()<CR>
nnoremap <leader>rsg :call PhpCreateSettersAndGetters()<CR>

packadd vim-php-refactoring-toolbox
" }}}

packadd vdebug
