" STANDARD VIM CONFIGURATION:
" {{{
set nocompatible             " Make Vim stop acting like Vi
set lazyredraw               " Don't redraw during macros/commands

syntax enable                " Enable syntax highlighting
filetype plugin indent on    " Enable file type plugins and indenting

set encoding=UTF-8           " Use UTF-8 encoding
set fileformats=unix,dos,mac " Create new files using unix(LF) file format

set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone " Show full completion menu, even with one entry
set pumheight=15             " Completion menu height

set sidescrolloff=3          " Keep 3 lines left/right
set scrolloff=3              " Keep 3 lines above/below

set number                   " Show current line number
set relativenumber           " Show relative line numbers (good for movements)
set colorcolumn=80           " Show guide column at 80 characters

set foldmethod=marker        " Automatically fold default foldmarker

set gdefault                 " Replace globally (/g) by default
set incsearch                " Incremental search highlighting
set ignorecase               " Ignore case while searching...
set smartcase                " ...except when there are capital letters

set laststatus=2             " Make sure the status line is displayed

set statusline=
set statusline+=%#Todo#
set statusline+=%h                           " Help buffer flag
set statusline+=%q                           " Quickfix list buffer flag
set statusline+=%{SignifyStatus()}           " Signify Status

set statusline+=%*
set statusline+=\ %f                         " File path
set statusline+=%m                           " Modified
set statusline+=%=                           " Right Align
set statusline+=%y\                          " filetype
set statusline+=\ %{empty(&fenc)?&enc:&fenc} " File Encoding
set statusline+=[%{&ff}]\                    " File Format

set statusline+=%#Search#
set statusline+=\ %p%%\ \                    " Percentage of lines
set statusline+=%l/%L\ ln\ :\ %c\            " Line Number

set nobackup                 " Don't need backup files
set noswapfile               " Don't need swap files

set path+=**                 " Search subfolders with find tab completion
set wildmenu                 " Displays all matches for tab completion
set wildignore=*.swp,*.orig  " Basic file types to ignore with find tab completion
set wildignore+=*.lock
set wildignore+=*.phar
set wildignore+=*.bak
set wildignore+=*.ico
set wildignore+=*.jpg,*.jpeg
set wildignore+=*.gif
set wildignore+=*.png
set wildignore+=*.svg

set formatoptions+=j        " Sane line join formatting

match ErrorMsg '\%>120v.\+' " Highlight lines >120 characters
match ErrorMsg '\s\+$'      " Highlight trailing whitespace

" }}}

" CONEMU CONFIGURATION:
" {{{
if !has('gui_running')
    set term=xterm

    " Fix the colors
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"

    " Fix the BackSpace
    inoremap <Char-0x07F> <BS>
    nnoremap <Char-0x07F> <BS>

    " Fix the Mouse Scroll Wheel
    set mouse=a
    inoremap <Esc>[62~ <C-X><C-E>
    inoremap <Esc>[63~ <C-X><C-Y>
    nnoremap <Esc>[62~ <C-E>
    nnoremap <Esc>[63~ <C-Y>
endif
" }}}

" ACK:
" {{{
cnoreabbrev ack Ack
if executable('rg')
    let g:ackprg = 'rg --vimgrep --no-heading'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
" }}}

" FZF: Better than Ctrl-P! (but only if it's installed)
" {{{
if executable('fzf')
    packadd! fzf
    packadd! fzf.vim
    let g:fzf_layout = { 'down': '~40%' }

    " WITH RG: Even better than FZF! (but only if it's installed)
    if executable('rg')
        let $FZF_DEFAULT_COMMAND = 'rg --files ' .
                    \ '--ignore-file .gitignore --ignore-file .hgignore ' .
                    \ '--glob !*.ico ' .
                    \ '--glob !*.png ' .
                    \ '--glob !*.gif ' .
                    \ '--glob !*.jpg --glob !*.jpeg --glob !*.jpe ' .
                    \ '--glob !*.ttf --glob !*.eot ' .
                    \ '--glob !*.lock '

        " Use RipGrep with FZF
        cnoreabbrev rg Rg
        command! -bang -nargs=* Rg
                    \ call fzf#vim#grep(
                    \   'rg --column --line-number --no-heading --color=always '.<q-args>, 1,
                    \   <bang>0 ? fzf#vim#with_preview('up:60%')
                    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                    \   <bang>0)
    endif

    " FZF Utilities
    nnoremap <C-p> :Files<CR>
    nnoremap <leader>b :Buffers<CR>
    nnoremap <leader>f :Files<CR>
    nnoremap <leader>l :Lines<CR>
    nnoremap <leader>t :Tags<CR>
    "nnoremap <Leader>t :Files<CR>
    "nnoremap <Leader>r :Tags<CR>

    " Insert mode completion
    "imap <c-x><c-k> <plug>(fzf-complete-word)
    "imap <c-x><c-f> <plug>(fzf-complete-path)
    "imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    "imap <c-x><c-l> <plug>(fzf-complete-line)
else
    " TODO Default to Ctrl-P, because it's better than nothing
endif
" }}}

" RIPGREP: Better than Grep! (but only if it's installed)
" {{{
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" SHORTCUTS:
" {{{
" Insert mode shortcuts
imap ii <Esc>

" Tag shortcuts
command! MakeTags !ctags -R .
nnoremap <leader>t :tag <c-r><c-w><cr>

" Quickfix shortcut
nnoremap <leader>x :cclose<CR>

" Cut/Copy/Paste
vmap <C-x> "*d
vmap <C-c> "*y
vmap <C-v> "*p

" Select All
nnoremap <C-a> ggVG

" Save buffers
map  <C-s> <Esc>:w<CR>
nmap <C-s> :w<CR>

" Visual Mode
vnoremap < <gv
vnoremap > >gv
" }}}

" SIGNIFY:
" {{{
highlight SignColumn        ctermbg=None
highlight SignifySignAdd    ctermbg=None ctermfg=119
highlight SignifySignDelete ctermbg=None ctermfg=167
highlight SignifySignChange ctermbg=None ctermfg=227
function! SignifyStatus()
    if !exists("g:loaded_signify")
        return ''
    endif
    let [added, modified, removed] = sy#repo#get_stats()
    let l:sy = ''
    for [flag, flagCount] in [
                \   [exists("g:signify_sign_add")?g:signify_sign_add:'+', added],
                \   [exists("g:signify_sign_change")?g:signify_sign_change:'~', modified],
                \   [exists("g:signify_sign_delete")?g:signify_sign_delete:'-', removed]
                \ ]
        if flagCount > 0
            if !empty(l:sy)
                let l:sy .= ' '
            endif
            let l:sy .= printf('%s%d', flag, flagCount)
        endif
    endfor
    if !empty(l:sy)
        return printf('  %s ', l:sy)
    else
        return ''
    endif
endfunction
call SignifyStatus()
" }}}

" STARTIFY:
" {{{
let g:startify_session_persistence = 1
let g:startify_list_order          = [
            \   ['Sessions'], 'sessions',
            \   ['Recent Files'], 'files',
            \   ['Commands'], 'commands'
            \]
let g:startify_fortune_use_unicode = 1
" }}}

" THEME:
" {{{
set fillchars=vert:│
highlight VertSplit term=NONE cterm=NONE gui=NONE
highlight Folded    ctermbg=4
" }}}
