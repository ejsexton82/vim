" VIM: {{{
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

set formatoptions+=j        " Sane line join formatting
" }}}
" VIM ERRORMSG: {{{
match ErrorMsg '\%>120v.\+' " Highlight lines >120 characters
match ErrorMsg '\s\+$'      " Highlight trailing whitespace
" }}}
" VIM PERSISTENT_UNDO: {{{
if has('persistent_undo')
	if has('win32')
		if has('nvim')
			let &undodir = expand($HOME . '/AppData/Local/nvim/undo')
		else
			let &undodir = expand($HOME . '/vimfiles/undo')
		endif
	else
		let &undodir = expand($HOME . '/.vim/undo')
	endif
    if !isdirectory(&undodir)
        silent call mkdir(&undodir, 'p')
    endif
    set undofile
endif
" }}}
" VIM STATUSLINE: {{{
set laststatus=2                     " Make sure the status line is displayed

set statusline=\                               " Custom status line
set statusline+=%(%h%q%w\ %)                   " Help/Quickfix/Preview window
set statusline+=%F                             " File path
set statusline+=%(\ %m%)                       " Modified
set statusline+=%=                             " Right Align
set statusline+=%y                             " filetype
set statusline+=\ [%{empty(&fenc)?&enc:&fenc}] " File Encoding
set statusline+=\ [%{&ff}]\                    " File Format
" }}}
" VIM SWAP: {{{
set nobackup                 " Don't need backup files
set noswapfile               " Don't need swap files
" }}}
" VIM TABS: Default Tabs {{{
set expandtab
set tabstop=4
set shiftwidth=4
" }}}
" WILDIGNORE: {{{
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
" }}}
" VIMGREP: {{{
cnoreabbrev grep silent grep
if executable("rg")
    " Use RipGrep if it is installed
    let rg_wildignore=" --glob !" . substitute(&wildignore, ',', ' --glob !', 'g')
    " let rg_ignore=" --ignore-file .gitignore --ignore-file .hgignore " . rg_wildignore
    let rg_ignore=" --no-ignore " . rg_wildignore
    let rg_options=" --no-heading --no-messages --ignore-case"
    let &grepprg="rg --vimgrep" . rg_options . rg_ignore
    set grepformat=%f:%l:%c:%m,%f:%l:%m

    nnoremap gr :silent execute 'grep -t ' . &filetype expand('<cword>')<CR>
    " nnoremap Gr :execute 'grep -F -t ' . &filetype expand('<cword>')<CR>
    nnoremap gR :silent execute 'grep -w -t ' . &filetype expand('<cword>')<CR>
    " nnoremap GR :execute 'grep -F -w -t ' . &filetype expand('<cword>')<CR>
else
    nnoremap gr :silent grep <cword> *<CR>
    " nnoremap Gr :silent grep <cword> %:p:h/*<CR>
    nnoremap gR :silent grep "\b<cword>\b" *<CR>
    " nnoremap GR :silent grep '\b<cword>\b' %:p:h/*<CR>
endif
" }}}
" CONEMU: {{{
" if !has('gui_running')
"     if !has('nvim')
"         set term=xterm
"     endif

"     " Fix the colors
"     set t_Co=256
"     let &t_AB="\e[48;5;%dm"
"     let &t_AF="\e[38;5;%dm"

"     " Fix the BackSpace
"     inoremap <Char-0x07F> <BS>
"     nnoremap <Char-0x07F> <BS>

"     " Fix the Mouse Scroll Wheel
"     set mouse=a
"     " inoremap <Esc>[62~ <C-X><C-E>
"     " inoremap <Esc>[63~ <C-X><C-Y>
"     " nnoremap <Esc>[62~ <C-E>
"     " nnoremap <Esc>[63~ <C-Y>
" endif
" }}}
" DEOPLETE: {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#padawan#add_parentheses = 1
" needed for echodoc to work if add_parentheses is 1
let g:deoplete#skip_chars = ['$']
let g:deoplete#sources = {}
" let g:deoplete#sources.php = ['padawan', 'ultisnips', 'tags', 'buffer']
let g:deoplete#sources.php = ['padawan', 'tags', 'buffer']

if has("win32")
    let g:python3_host_prog = 'C:\Python37\python.exe'
endif

if has('nvim')
    packadd deoplete.nvim
    autocmd VimEnter * silent UpdateRemotePlugins
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
            \ 'hg':  'hg diff --config extensions.color=! --config defaults.diff= --nodates -U0 -- %f',
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
nnoremap <leader>X :cclose<CR>:bd<CR>

" Cut/Copy/Paste
vmap <C-x> "*d
vmap <C-c> "*y
vmap <C-v> "*p

" Popup Menu
inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"

" Visual Mode
vnoremap < <gv
vnoremap > >gv
" }}}
" STARTIFY: {{{
if has('win32') && has('nvim')
    let g:startify_session_dir = '~/Local/AppData/nvim/session'
endif
let g:startify_session_persistence = 1
if has('win32')
    let g:startify_bookmarks = [
                \   '~/Documents/AutoHotKey.ahk'
                \ ]
    let g:startify_list_order          = [
                \   ['Sessions'], 'sessions',
                \   ['Bookmarks'], 'bookmarks'
                \]
else
    let g:startify_bookmarks = [ ]
    let g:startify_list_order = [
                \ ['Sessions'], 'sessions'
                \]
endif
let g:startify_fortune_use_unicode = 1
let g:startify_custom_header = 'startify#fortune#boxed()'
" }}}
" THEME: {{{
set fillchars=vert:│
highlight VertSplit term=NONE cterm=NONE gui=NONE
if has('win32') && has('nvim')
    " For some reason, colorscheme switches to default after init.vim on
    " Windows. Using autocmd solves this problem.
    autocmd VimEnter * colorscheme conemu
endif
" }}}
