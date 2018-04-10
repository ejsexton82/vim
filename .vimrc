" STANDARD VIM CONFIGURATION: {{{
set lazyredraw                       " Don't redraw during macros/commands

syntax enable                        " Enable syntax highlighting
filetype plugin indent on            " Enable file type plugins and indenting

set encoding=UTF-8                   " Use UTF-8 encoding
set fileformats=unix,dos,mac         " Create new files using unix(LF) file format

set autoindent                       " Maintain the current indent on the next line
set backspace=indent,eol,start       " Delete newlines and start of insert
set smarttab                         " Delete tabs

set omnifunc=syntaxcomplete#Complete " Default built-in omni completion
set completeopt=longest,menuone      " Show full completion menu, even with one entry
set pumheight=15                     " Completion menu height

set sidescrolloff=3                  " Keep 3 lines left/right
set scrolloff=3                      " Keep 3 lines above/below

set number                           " Show current line number
set relativenumber                   " Show relative line numbers (good for movements)
set colorcolumn=80                   " Show guide column at 80 characters
set cursorline                       " Highlight the cursor line

set gdefault                         " Replace globally (/g) by default
set incsearch                        " Incremental search highlighting
set ignorecase                       " Ignore case while searching...
set smartcase                        " ...except when there are capital letters

set laststatus=2                     " Make sure the status line is displayed

set statusline=\                               " Custom status line
set statusline+=%(%h%q%w\ %)                   " Help/Quickfix/Preview window
set statusline+=%F                             " File path
set statusline+=%(\ %m%)                       " Modified
set statusline+=%=                             " Right Align
set statusline+=%y                             " filetype
set statusline+=\ [%{empty(&fenc)?&enc:&fenc}] " File Encoding
set statusline+=\ [%{&ff}]\                    " File Format

set nobackup                 " Don't need backup files
set noswapfile               " Don't need swap files

set path+=**                 " Search subfolders with find tab completion
set wildmenu                 " Displays all matches for tab completion
set wildignore=              " Basic file types to ignore with find tab completion
set wildignore+=*.bak
set wildignore+=*.gif
set wildignore+=*.ico
set wildignore+=*.jpg,*.jpeg,*.jpe
set wildignore+=*.lock
set wildignore+=*.phar
set wildignore+=*.png
set wildignore+=*.pyc
set wildignore+=*.svg
set wildignore+=*.swp,*.orig
set wildignore+=*.ttf,*.eot,*.woff,*.woff2
set wildignore+=*.pyc
set wildignore+=.git

" Set vimgrep command
cnoreabbrev grep silent grep
if executable("rg")
    " Use RipGrep if it is installed
    let rg_wildignore=" --glob !" . substitute(&wildignore, ',', ' --glob !', 'g')
    " let rg_ignore=" --ignore-file .gitignore --ignore-file .hgignore " . rg_wildignore
    let rg_ignore=" --no-ignore " . rg_wildignore
    let rg_options=" --no-heading --no-messages --ignore-case"
    let &grepprg="rg --vimgrep" . rg_options . rg_ignore
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

set formatoptions+=j        " Sane line join formatting

match ErrorMsg '\%>120v.\+' " Highlight lines >120 characters
match ErrorMsg '\s\+$'      " Highlight trailing whitespace

" Enable persistent undos
if has('persistent_undo')
	if has('win32')
		let &undodir = expand($HOME . '/vimfiles/undo')
	else
		let &undodir = expand($HOME . '/.vim/undo')
	endif
    if !isdirectory(&undodir)
        silent call mkdir(&undodir, 'p')
    endif
    set undofile
endif
" }}}
" CONEMU: {{{
if !has('gui_running')
    if !has('nvim')
        set term=xterm
    endif

    " Fix the colors
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"

    " Fix the BackSpace
    inoremap <Char-0x07F> <BS>
    nnoremap <Char-0x07F> <BS>

    " Fix the Mouse Scroll Wheel
    set mouse=a
    " inoremap <Esc>[62~ <C-X><C-E>
    " inoremap <Esc>[63~ <C-X><C-Y>
    " nnoremap <Esc>[62~ <C-E>
    " nnoremap <Esc>[63~ <C-Y>
endif
" }}}
" FZF: Better than Ctrl-P! (but only if it's installed) {{{
if executable('fzf')
    packadd! fzf
    packadd! fzf.vim
    let g:fzf_layout = { 'down': '~40%' }

    " WITH RG: Even better than FZF! (but only if it's installed)
    if executable('rg')
        let $FZF_DEFAULT_COMMAND = 'rg --files ' . rg_options . rg_ignore

        " Use RipGrep with FZF
        cnoreabbrev rg Rg
        command! -bang -nargs=* Rg
                    \ call fzf#vim#grep(
                    \   'rg --column --line-number --color=always' . rg_options . rg_ignore . ' ' .<q-args>, 1,
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
" LION: {{{
let g:lion_squeeze_spaces = 1
" }}}
" QF: {{{
let g:qf_auto_quit = 0
" }}}
" SIGNIFY: {{{
let g:signify_vcs_cmds = {
            \ 'git': 'git diff --no-color --no-ext-diff -U0 -- %f',
            \ }
" }}}
" SHORTCUTS: {{{
" Insert mode shortcuts
inoremap ii <Esc>

" Tag shortcuts
command! MakeTags !ctags -R .
nnoremap <leader>t :tag <c-r><c-w><cr>

" Quickfix shortcut
nnoremap <leader>x :cclose<CR>

" Cut/Copy/Paste
vmap <C-x> "*d
vmap <C-c> "*y
vmap <C-v> "*p

" Visual Mode
vnoremap < <gv
vnoremap > >gv
" }}}
" STARTIFY: {{{
let g:startify_session_persistence = 1
let g:startify_bookmarks = [
            \   '~/Documents/AutoHotKey.ahk'
            \ ]
let g:startify_list_order          = [
            \   ['Sessions'], 'sessions',
            \   ['Bookmarks'], 'bookmarks'
            \]
let g:startify_fortune_use_unicode = 1
let g:startify_custom_header = 'startify#fortune#boxed()'
" }}}
" THEME: {{{
set fillchars=vert:│
highlight VertSplit term=NONE cterm=NONE gui=NONE
" }}}
