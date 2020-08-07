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
" VIM COC: {{{
set hidden         " Abandon hidden buffers
set cmdheight=2 
set updatetime=300 " Shorter update time for CursorHold / CursorHoldI
set shortmess+=c   " No ins-completion-menu messages
set signcolumn=yes " Always show sign column
" }}}
" VIM DISPLAY: {{{
set conceallevel=2          " Hides quotes in JSON files
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
" VIM SHELL:{{{
if has('win32') || has('win64')
    " Fixes bug with &shell and jobstart() on Windows
    set shell=cmd.exe
endif
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
set wildignore+=node_modules
" }}}
" VIMGREP: {{{
cnoreabbrev grep silent grep
if executable("rg")
    " Use RipGrep if it is installed
    let rg_wildignore=' --glob "!' . substitute(&wildignore, ',', '" --glob "!', 'g') . '"'
    " let rg_ignore=" --ignore-file .gitignore --ignore-file .hgignore " . rg_wildignore
    let rg_ignore=rg_wildignore
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
" MOUSE: {{{
set mouse=a " Fix the Mouse Scroll Wheel
" }}}
" PLUG: {{{

if has('win32')
	if has('nvim')
		call plug#begin('$HOME/AppData/Local/nvim/plugged')
	else
		call plug#begin('$HOME/vimfiles/plugged')
	endif
else
	call plug#begin('$HOME/.vim/plugged')
endif

Plug 'altercation/vim-colors-solarized'
Plug 'PProvost/vim-ps1'
Plug 'chivalry/filemaker.vim'
Plug 'christoomey/vim-sort-motion'
Plug 'dracula/vim'
" Plug 'godlygeek/tabular', { 'on': 'Tabularize', 'for': 'markdown' }
Plug 'jamessan/vim-gnupg'
Plug 'jceb/vim-orgmode'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/vader.vim', { 'on': 'Vader', 'for': 'vader' }
Plug 'justinmk/vim-sneak'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() } }
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
" Plug 'SidOfc/mkdx', { 'for': 'markdown' }
Plug 'romainl/vim-qf'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/utl.vim'
Plug 'vim-vdebug/vdebug', { 'for': 'php' }

call plug#end()

" }}}
" CoC: {{{

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

command! -nargs=0 Format :call CocAction('format')
" command! -nargs=? Fold   :call CocAction('fold', <f-args>)

" }}}
" FZF: Better than Ctrl-P! (but only if it's installed) {{{
if executable('fzf')
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
" GOYO: {{{
function! s:goyo_enter()
    set spell
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()

function! s:goyo_leave()
    set nospell
endfunction
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nnoremap <leader>g :Goyo<CR>
" }}}
" GRAMMAROUS:{{{
cabbrev gc GrammarousCheck
cabbrev gr GrammarousReset
" }}}
" GnuPG:{{{
let g:GPGPreferArmor=1
let g:GPGDefaultRecipients=["ejsexton82@gmail.com"]
vnoremap { :!gpg --decrypt --quiet<Enter>
vnoremap } :!gpg --armor --encrypt<Enter>
" }}}
" INDENT-GUIDES: {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
" }}}
" LION: {{{
let g:lion_squeeze_spaces = 1
" }}}
" ORG MODE: {{{
let g:org_todo_keywords = [['PLAN', 'TODO', '|', 'DONE']]
" }}}
" PYTHON: {{{

" Check for Python 2 in some common locations
if executable('/usr/bin/python2')
    let g:python_host_prog = '/usr/bin/python2'
endif

" Check for Python 3 in some common locations
if executable('/usr/local/bin/python3')
    let g:python3_host_prog = '/usr/local/bin/python3'
endif

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
" TAGBAR: {{{
nmap <F8> :TagbarToggle<CR>
" }}}
" THEME: {{{
set fillchars=vert:│
highlight VertSplit term=NONE cterm=NONE gui=NONE

if has('win32') && has('nvim')
    " For some reason, colorscheme switches to default after init.vim on
    " Windows. Using autocmd solves this problem.
    autocmd VimEnter * colorscheme conemu
elseif has('mac')
    autocmd VimEnter * colorscheme solarized
endif
" }}}
" UTL: {{{
if !exists("g:utl_cfg_hdl_scm_http_system")

    if has("win32")
        let g:utl_cfg_hdl_scm_http_system = 'silent !cmd /q /c start "dummy title" "%u"'
        "let g:utl_cfg_hdl_scm_http_system = 'silent !start C:\Program Files\Internet Explorer\iexplore.exe %u#%f' 
        "let g:utl_cfg_hdl_scm_http_system = 'silent !start C:\Program Files\Mozilla Firefox\firefox.exe %u#%f'
    elseif has("mac")
        "let g:utl_cfg_hdl_scm_http_system = "silent !open -a /Applications/Firefox.app/Contents/MacOS/firefox-bin '%u'"
        let g:utl_cfg_hdl_scm_http_system = 'silent !open -a "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "%u"'
    elseif has("unix")
        " TODO: Standard Handler for Unixes that can be shipped
        "	    preconfigured with next utl.vim release
        "	    Probably to distinguish different Unix/Linux flavors.
        "
        "	    Proposed for Ubuntu/Debian by Jeremy Cantrell
        "	    to use xdg-open program
        "	    'silent !xdg-open %u'  <- does this work?
        "
        " 2nd best solution: explicitly configured browser:
        "
        "	Konqueror
        "let g:utl_cfg_hdl_scm_http_system = "silent !konqueror '%u#%f' &"
        "
        "	Lynx Browser.
        "let g:utl_cfg_hdl_scm_http_system = "!xterm -e lynx '%u#%f'"
        "
        "	Firefox
        "	Check if an instance is already running, and if yes use it, else start firefox.
        "	See <URL:http://www.mozilla.org/unix/remote.html> for mozilla/firefox -remote control
        "let g:utl_cfg_hdl_scm_http_system = "silent !firefox -remote 'ping()' && firefox -remote 'openURL( %u )' || firefox '%u#%f' &"
        let g:utl_cfg_hdl_scm_http_system = "silent !google-chrome '%u'"
    endif
    " else if MacOS
    " ??
    "let g:utl_cfg_hdl_scm_http_system = "silent !open -a Safari '%u#%f'"
    "
    "}

endif

if !exists("g:utl_cfg_hdl_scm_http")
    if exists("g:utl_cfg_hdl_scm_http_system")
        let g:utl_cfg_hdl_scm_http=g:utl_cfg_hdl_scm_http_system
    endif
endif
" }}}
