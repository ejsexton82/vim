source $HOME/vimfiles/_vimrc

" FULLSCREEN:
" Automatically switch to fullscreen on load
autocmd GUIEnter * call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
autocmd GUIEnter * call libcallnr("gvimfullscreen.dll", "SetAlpha", 240)

" Hide some things we don't want
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions-=e

" Map some keys to enable fullscreen
noremap  <C-F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen",0)<CR>
nnoremap <C-F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen",0)<CR>

" TABS:
" Tab Commands
" nnoremap <C-Tab>   :tabnext<CR>
" nnoremap <C-S-Tab> :tabprev<CR>

" opens commands in a new tab (colemak.vim from Shia Coleman)
" cnoreabbr <expr> f    (getcmdtype() . getcmdline() != ':f'    ? 'f'    : 'tabfind' )
" cnoreabbr <expr> fi   (getcmdtype() . getcmdline() != ':fi'   ? 'fi'   : 'tabfind' )
" cnoreabbr <expr> fin  (getcmdtype() . getcmdline() != ':fin'  ? 'fin'  : 'tabfind' )
" cnoreabbr <expr> find (getcmdtype() . getcmdline() != ':find' ? 'find' : 'tabfind' )
" cnoreabbr <expr> h    (getcmdtype() . getcmdline() != ':h'    ? 'h'    : 'tab help')
" cnoreabbr <expr> he   (getcmdtype() . getcmdline() != ':he'   ? 'he'   : 'tab help')
" cnoreabbr <expr> hel  (getcmdtype() . getcmdline() != ':hel'  ? 'hel'  : 'tab help')
" cnoreabbr <expr> help (getcmdtype() . getcmdline() != ':help' ? 'help' : 'tab help')
" cnoreabbr <expr> e    (getcmdtype() . getcmdline() != ':e'    ? 'e'    : 'tabedit' )
" cnoreabbr <expr> ed   (getcmdtype() . getcmdline() != ':ed'   ? 'ed'   : 'tabedit' )
" cnoreabbr <expr> edi  (getcmdtype() . getcmdline() != ':edi'  ? 'edi'  : 'tabedit' )
" cnoreabbr <expr> edit (getcmdtype() . getcmdline() != ':edit' ? 'edit' : 'tabedit' )

" THEME:
set guifont=Consolas:h12
set background=dark
packadd dracula
colorscheme dracula
